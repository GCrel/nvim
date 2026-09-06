# Neovim Configuration (v0.11+)

Configuración personal de Neovim v0.11.5, construida desde cero e integrada con:

* **lazy.nvim** (gestor de plugins)
* **LSP** (nvim-lspconfig + Mason)
* **nvim-cmp** (autocompletado)
* **Treesitter** (resaltado sintáctico)
* **OneDarkPro** (tema) con UI moderna
* **alpha-nvim** (dashboard de inicio)
* **Copilot** (sugerencias con IA)
* **nvim-dap** (debugging)
* **Conform** (formateo automático)
* **gitsigns / diffview** (integración con Git)
* Atajos personalizados optimizados

La configuración está diseñada para ser simple, modular y fácil de mantener.

---

## Requisitos previos

### Nerd Font

Descargar desde [https://www.nerdfonts.com/](https://www.nerdfonts.com/)

### Dependencias recomendadas

| Herramienta | Uso |
|-------------|-----|
| ripgrep | Búsquedas rápidas (Telescope) |
| fd | Búsqueda de archivos |
| Node.js | Algunos LSPs |
| Go | LSP gopls (opcional) |

---

## Instalación

### Windows

```powershell
git clone https://github.com/GCrel/nvim $env:LocalAppData/nvim
nvim
```

Luego ejecutar: `:Lazy sync`

### Linux / macOS

```bash
git clone https://github.com/GCrel/nvim ~/.config/nvim
nvim
```

Luego ejecutar: `:Lazy sync`

---

## Estructura del proyecto

```
nvim/
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins
│       ├── coding
│       │   ├── autopairs.lua
│       │   ├── comment.lua
│       │   ├── conform.lua
│       │   └── copilot.lua
│       ├── dap
│       │   └── dap.lua
│       ├── editor
│       │   ├── neo-tree.lua
│       │   ├── telescope.lua
│       │   ├── toggleterm.lua
│       │   └── treesitter.lua
│       ├── git
│       │   ├── diffview.lua
│       │   └── gitsigns.lua
│       ├── lsp
│       │   ├── cmp.lua
│       │   ├── jdtls.lua
│       │   └── servers.lua
│       ├── markdown
│       │   └── markdown.lua
│       └── ui
│           ├── alpha.lua
│           ├── bufferline.lua
│           ├── indent-blankline.lua
│           ├── lualine.lua
│           └── theme.lua
└── README.md
```

## Plugins incluidos

| Plugin | Función |
|--------|---------|
| lazy.nvim | Gestor de plugins |
| alpha-nvim | Dashboard de inicio |
| nvim-autopairs | Autocierre de pares |
| bufferline.nvim | Línea de buffers |
| onedarkpro.nvim (onedark_vivid) | Tema |
| Comment.nvim | Comentarios |
| conform.nvim | Formateo al guardar |
| copilot.lua | Sugerencias con IA |
| nvim-dap + dap-ui | Debugging |
| diffview.nvim | Vista de diffs de Git |
| gitsigns.nvim | Marcadores de Git en la línea |
| indent-blankline | Guías de indentación |
| nvim-jdtls | LSP de Java |
| lualine.nvim | Barra de estado |
| render-markdown.nvim | Renderizado de Markdown |
| neo-tree | Explorador de archivos |
| telescope.nvim | Búsqueda fuzzy |
| toggleterm.nvim | Terminal integrado |
| nvim-treesitter | Resaltado e indentación |
| nvim-cmp | Autocompletado |

---

## LSP incluido

| LSP | Lenguaje |
|-----|----------|
| lua_ls | Lua |
| jdtls | Java |
| ltex_plus | Español (ortografía/gramática, es-AR) en markdown/text/gitcommit |

Para instalar más: `:Mason`

El LSP de Java (jdtls) se configura automáticamente con:
* Soporte para Maven, Gradle y `.git` como directorios raíz del proyecto
* Lombok integrado (javaagent)
* Debugging remoto (java-debug-adapter) y tests (java-test) vía Mason
* Organización de imports, extracción de variables/constantes y ejecución de tests

---

## Keybindings completos

### Buffer Control

| Atajo | Acción |
|-------|--------|
| `<Tab>` | Siguiente buffer |
| `<S-Tab>` | Buffer anterior |
| `<leader>bc` | Cerrar buffer actual |
| `<leader>bs` | Guardar y cerrar buffer |

### Portapapeles

| Atajo | Acción |
|-------|--------|
| `cp` | Copiar (normal/visual) |
| `cv` | Pegar (normal/visual) |
| `x` | Borrar sin copiar |
| `<leader>a` | Seleccionar todo |

### Operaciones de línea

| Atajo | Acción |
|-------|--------|
| `<leader>d` | Duplicar línea |
| `<C-j>` | Mover línea/selección abajo |
| `<C-k>` | Mover línea/selección arriba |

### Selección

| Atajo | Acción |
|-------|--------|
| `<leader>s` | Seleccionar hasta fin de línea |
| `<leader>sl` | Seleccionar línea completa |

### Búsqueda y Navegación

| Atajo | Acción |
|-------|--------|
| `<leader>f` | Buscar en archivos (live_grep) |
| `<leader>p` | Buscar archivos (find_files) |
| `<leader>o` | Archivos recientes (oldfiles) |
| `<C-n>` | Toggle Neo-tree |
| `<leader>e` | Focus Neo-tree |

### Comentarios

| Atajo | Acción |
|-------|--------|
| `<C-_>` | Comentar línea (normal) |
| `<C-_>` | Comentar selección (visual) |

### Terminal

| Atajo | Acción |
|-------|--------|
| `<leader>th` | Terminal horizontal |
| `<leader>tf` | Terminal flotante |

### LSP - Navegación

| Atajo | Acción |
|-------|--------|
| `gd` | Ir a definición |
| `gD` | Ir a declaración |
| `gi` | Ir a implementación |
| `gr` | Ver referencias |
| `K` | Mostrar hover |

### LSP - Edición

| Atajo | Acción |
|-------|--------|
| `<space>rn` | Rename símbolo |
| `<leader>rr` | Rename (alternativo) |
| `<space>ca` | Code Actions |
| `<leader>fm` | Formatear documento |

### LSP - Diagnósticos

| Atajo | Acción |
|-------|--------|
| `<leader>en` | Siguiente error |
| `<leader>ep` | Error anterior |
| `<leader>eq` | Mostrar lista de errores |

### Autocompletado (Insert Mode)

| Atajo | Acción |
|-------|--------|
| `<C-j>` | Completar / mostrar sugerencias |
| `<Tab>` | Siguiente sugerencia |
| `<S-Tab>` | Anterior sugerencia |
| `<C-k>` | Scroll documentación arriba |
| `<C-l>` | Scroll documentación abajo |
| `<C-space>` | Forzar completado |
| `<C-e>` | Cancelar completado |
| `<CR>` | Confirmar selección |

### Copilot (Insert Mode)

| Atajo | Acción |
|-------|--------|
| `<C-y>` | Aceptar sugerencia |
| `<Alt-]>` | Siguiente sugerencia |
| `<Alt-[>` | Sugerencia anterior |
| `<C-\>` | Descartar sugerencia |

### Debugging (DAP)

| Atajo | Acción |
|-------|--------|
| `<F5>` | Iniciar / continuar debug |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>b` | Toggle breakpoint |

### Java (jdtls)

| Atajo | Acción |
|-------|--------|
| `<leader>jo` | Organizar imports |
| `<leader>jv` | Extraer variable |
| `<leader>jc` | Extraer constante |
| `<leader>tc` | Ejecutar test de la clase |
| `<leader>tm` | Ejecutar test más cercano |

### Treesitter (Visual Mode)

| Atajo | Acción |
|-------|--------|
| `<C-space>` | Iniciar / expandir selección incremental |
| `<bs>` | Reducir selección |

---

## Información del sistema

Configuración inicializada con:

```
NVIM v0.11.5
LuaJIT 2.1.1741730670
```

---

