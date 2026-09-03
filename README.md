# Neovim Configuration (v0.11+)

Configuración personal de Neovim v0.11.5, construida desde cero e integrada con:

* **LSP** (nvim-lspconfig)
* **Mason** (instalador LSP / linters / formatters)
* **nvim-cmp** (autocompletado)
* **Treesitter** (resaltado sintáctico)
* Atajos personalizados optimizados
* Tema Catppuccin con UI moderna

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
├── README.md
└── lua/
    ├── config/
    │   ├── keymaps.lua
    │   ├── lazy.lua
    │   └── settings.lua
    └── plugins/
        ├── alpha.lua
        ├── autopairs.lua
        ├── bufferline.lua
        ├── catppuccin.lua
        ├── comment.lua
        ├── indent-blankline.lua
        ├── lualine.lua
        ├── nvim-tree.lua
        ├── telescope.lua
        ├── toggleterm.lua
        ├── treesitter.lua
        └── lsp/
            ├── cmp.lua
            └── servers.lua
```

---

## LSP incluido

| LSP | Lenguaje |
|-----|----------|
| lua_ls | Lua |

Para instalar más: `:Mason`

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
| `<leader>f` | Buscar en archivos (grep) |
| `<leader>p` | Buscar archivos |
| `<leader>o` | Archivos recientes |
| `<C-n>` | Toggle árbol de archivos |
| `<leader>e` | Focus árbol de archivos |

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
| `<C-e>` | Cancelar completado |
| `<CR>` | Confirmar selección |

### Treesitter (Visual Mode)

| Atajo | Acción |
|-------|--------|
| `<C-space>` | Iniciar selección incremental |
| `<C-space>` | Expandir selección |
| `<bs>` | Reducir selección |

---

## Información del sistema

Configuración inicializada con:

```
NVIM v0.11.5
LuaJIT 2.1.1741730670
```

---

