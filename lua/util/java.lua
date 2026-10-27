local M = {}

local MIN_SERVER_JAVA = 25 -- jdtls >= 1.62 necesita Java 25 para ejecutarse

--- Patrones de carpetas donde suele haber JDKs (cada match es un JAVA_HOME).
local function home_patterns()
    local home = vim.env.HOME
    local patterns = {
        home .. "/.sdkman/candidates/java/*",
        home .. "/.asdf/installs/java/*",
        home .. "/.local/share/mise/installs/java/*",
        home .. "/.jenv/versions/*",
        "/usr/lib/jvm/*",
        "/Library/Java/JavaVirtualMachines/*/Contents/Home",
        "/opt/homebrew/opt/openjdk*/libexec/openjdk.jdk/Contents/Home",
        "/opt/homebrew/opt/openjdk*",
    }
    -- JDTLS_JAVA_DIRS="/a:/b": cada entrada cuenta como JAVA_HOME y como carpeta que contiene JDKs
    for dir in (vim.env.JDTLS_JAVA_DIRS or ""):gmatch("[^:]+") do
        vim.list_extend(patterns, { dir, dir .. "/*" })
    end
    return patterns
end

--- Java instalados con su versión mayor, sin duplicados.
local function find_jdks()
    local dirs = {}
    for _, pattern in ipairs(home_patterns()) do
        vim.list_extend(dirs, vim.fn.glob(pattern, true, true))
    end
    local java_home = vim.env.JAVA_HOME
    if java_home and java_home ~= "" then
        table.insert(dirs, java_home)
    end
    local in_path = vim.fn.exepath("java")
    if in_path ~= "" then
        table.insert(dirs, vim.fs.dirname(vim.fs.dirname(vim.uv.fs_realpath(in_path) or in_path)))
    end
    local seen, jdks = {}, {}
    for _, dir in ipairs(dirs) do
        local home = vim.uv.fs_realpath(dir)
        if home and not seen[home] and vim.uv.fs_stat(home .. "/bin/java") then
            seen[home] = true
            local f = io.open(home .. "/release")
            local content = f and f:read("*a") or ""
            if f then f:close() end
            local v = content:match('JAVA_VERSION="([^"]+)"')
            local major = v and tonumber(v:match("^1%.(%d+)") or v:match("^(%d+)"))
            if major then
                table.insert(jdks, { home = home, major = major, jdk = vim.uv.fs_stat(home .. "/bin/javac") ~= nil })
            end
        end
    end
    return jdks
end

--- Devuelve el java para ejecutar jdtls y los runtimes que jdtls ofrece a los proyectos.
---@return string|nil java_executable, table runtimes
function M.resolve()
    local jdks = find_jdks()
    local runtimes, newest = {}, nil
    for _, jdk in ipairs(jdks) do
        if jdk.jdk then -- un JRE ejecuta jdtls pero no sirve para compilar el proyecto
            table.insert(runtimes, {
                name = jdk.major <= 8 and ("JavaSE-1." .. jdk.major) or ("JavaSE-" .. jdk.major),
                path = jdk.home,
            })
        end
        if not newest or jdk.major > newest.major then
            newest = jdk
        end
    end

    if not newest or newest.major < MIN_SERVER_JAVA then
        vim.notify(("jdtls necesita Java %d+ para ejecutarse; el más nuevo encontrado es %s"):format(
            MIN_SERVER_JAVA, newest and newest.major or "ninguno"), vim.log.levels.WARN)
    end
    return newest and (newest.home .. "/bin/java") or nil, runtimes
end

return M
