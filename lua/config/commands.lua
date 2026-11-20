vim.api.nvim_create_user_command("FormatProject", function()
    local files = vim.fn.globpath("src", "**/*.java", true, true)
    for i, file in ipairs(files) do
        vim.cmd("edit " .. vim.fn.fnameescape(file))
        local bufnr = vim.api.nvim_get_current_buf()
        vim.wait(20000, function()
            return #vim.lsp.get_clients({ bufnr = bufnr, name = "jdtls" }) > 0
        end, 100)
        require("conform").format({ bufnr = bufnr, lsp_format = "fallback", timeout_ms = 5000 })
        vim.cmd("write")
        print(string.format("(%d/%d) %s", i, #files, file))
    end
    print("Listo: " .. #files .. " archivos formateados.")
end, {})

local SEVERITIES = { "CRITICAL", "HIGH", "MEDIUM", "LOW", "UNKNOWN" }
local SEVERITY_ORDER = {}
for i, sev in ipairs(SEVERITIES) do SEVERITY_ORDER[sev] = i end

--- Línea del <artifactId> de la dependencia en el archivo (1 si es transitiva o no aparece).
local function dependency_line(lines, pkg_name)
    local artifact = pkg_name:match(":(.+)$") or pkg_name
    for i, line in ipairs(lines) do
        if line:find("<artifactId>" .. artifact .. "</artifactId>", 1, true) then
            return i
        end
    end
    return 1
end

vim.api.nvim_create_user_command("DepScan", function()
    local root = vim.fs.root(0, { "pom.xml", "build.gradle", "build.gradle.kts", ".git" }) or vim.fn.getcwd()
    local trivy = vim.fn.stdpath("data") .. "/mason/bin/trivy"
    vim.notify("DepScan: analizando " .. root .. " (la primera vez descarga la base de trivy)")

    local ok, err = pcall(vim.system, { trivy, "fs", "--scanners", "vuln", "--format", "json", "--quiet", root },
        { text = true }, vim.schedule_wrap(function(res)
            if res.code ~= 0 then
                return vim.notify("DepScan: trivy falló\n" .. (res.stderr or ""), vim.log.levels.ERROR)
            end
            local ok_json, report = pcall(vim.json.decode, res.stdout)
            if not ok_json then
                return vim.notify("DepScan: salida de trivy inválida", vim.log.levels.ERROR)
            end

            local items, counts = {}, {}
            for _, result in ipairs(report.Results or {}) do
                local file = root .. "/" .. result.Target
                local lines = vim.fn.filereadable(file) == 1 and vim.fn.readfile(file) or {}
                for _, v in ipairs(result.Vulnerabilities or {}) do
                    counts[v.Severity] = (counts[v.Severity] or 0) + 1
                    table.insert(items, {
                        filename = file,
                        lnum = dependency_line(lines, v.PkgName),
                        type = (v.Severity == "CRITICAL" or v.Severity == "HIGH") and "E" or "W",
                        text = string.format("%s %s → %s  %s [%s] %s", v.PkgName, v.InstalledVersion,
                            v.FixedVersion or "sin fix", v.VulnerabilityID, v.Severity, v.Title or ""),
                        severity = v.Severity,
                    })
                end
            end

            if #items == 0 then
                return vim.notify("DepScan: sin vulnerabilidades")
            end
            table.sort(items, function(a, b)
                return (SEVERITY_ORDER[a.severity] or 9) < (SEVERITY_ORDER[b.severity] or 9)
            end)
            vim.fn.setqflist({}, " ", { title = "DepScan", items = items })

            local summary = {}
            for _, sev in ipairs(SEVERITIES) do
                if counts[sev] then table.insert(summary, sev .. ": " .. counts[sev]) end
            end
            vim.notify("DepScan: " .. #items .. " vulnerabilidades (" .. table.concat(summary, ", ") .. ")",
                vim.log.levels.WARN)
            Snacks.picker.qflist()
        end))
    if not ok then
        vim.notify("DepScan: no se pudo ejecutar trivy (¿instalado con :MasonToolsInstall?)\n" .. tostring(err),
            vim.log.levels.ERROR)
    end
end, { desc = "Escanea dependencias vulnerables con trivy" })
