# Neovim Config (v0.11+)

Esta es mi configuración personal de **Neovim v0.11.5**, construida desde cero e integrada con:

* **LSP** (nvim-lspconfig)
* **Mason** (instalador LSP / linters / formatters)
* **nvim-cmp** (autocompletado)
* **Treesitter**
* Atajos personalizados
* Opciones de UI, iconos Nerd Font, etc.

La config está pensada para ser **simple, modular y fácil de migrar**.

---

## 🚀 Requisitos previos

Antes de instalar, asegúrate de tener:

### **1. Nerd Font instalada**

[https://www.nerdfonts.com/](https://www.nerdfonts.com/)

### **2. Dependencias recomendadas**

* **ripgrep** (búsquedas)
* **fd** (telescope)
* **Node.js** (algunos LSPs)
* **Go** (si usas `gopls`)

---

## 📥 Instalación

### 🔹 **Windows**

Clona el repositorio en:

```
%LocalAppData%/nvim
```

Ejemplo:

```powershell
git clone https://github.com/GCrel/nvim $env:LocalAppData/nvim
```

Luego abre Neovim:

```powershell
nvim
```

Y ejecuta:

```
:Lazy sync
```

---

### 🔹 **Linux (Ubuntu / Arch / Fedora / etc.)**

Clona el repositorio en:

```
~/.config/nvim
```

Ejemplo:

```bash
git clone https://github.com/GCrel/nvim ~/.config/nvim
```

Luego:

```bash
nvim
```

Y ejecuta:

```
:Lazy sync
```

---

## 📁 Estructura del proyecto

```
nvim
│   init.lua
│   lazy-lock.json
│   README.md
└───lua
    ├───config
    │       keymaps.lua
    │       lazy.lua
    │       settings.lua
    └───plugins
        │   alpha.lua
        │   autopairs.lua
        │   bufferline.lua
        │   catppuccin.lua
        │   comment.lua
        │   indent-blankline.lua
        │   lualine.lua
        │   nvim-tree.lua
        │   telescope.lua
        │   toggleterm.lua
        │   treesitter.lua
        └───lsp
                cmp.lua
                servers.lua
```

---

## 🧠 LSP incluido por defecto

* **lua_ls**

Puedes instalar más con:

```
:Mason
```

---

## ⌨️ Keybindings importantes

### **LSP**

* `gd` → Ir a definición
* `gD` → Declaración
* `gi` → Implementación
* `K` → Hover
* `<space>rn` → Rename
* `<space>ca` → Code Action
* `gr` → Referencias

---

## 📝 Notas

Esta configuración fue iniciada con:

```
NVIM v0.11.5
LuaJIT 2.1.1741730670
```

---

