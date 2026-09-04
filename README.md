# My MAIN neovim config (Uses Neovim v0.12+)

- This is my main neovim (Neovim v0.12.5) config which i use on windows and will most porbably use on linux
- The plugins are kept to the minimal for maximum startup speed and minimal lag
- Lazy.nvim package manager used


## IMPORTANT NOTE! ON WINDOWS 11 (NOT SURE ABOUT 10)
```
You MUST add nvim.exe, alacritty.exe (my terminal), nvim config directory and nvim install directory
to Exclusion on Windows Defender/Security.

otherwise you have +2 or even +5 seconds to the startup time
cause windows defender makes file reads slow for some reason?? So your extensions will load super slow
even with lazy loading
```


## Things you MUST have installed before using this config

- **A Patched font for unicode glyph's, font i'm using is Hack Nerd Font: https://www.nerdfonts.com/font-downloads**
```sh
-> scoop install cmake ffmpeg fzf mpv ninja ripgrep tree-sitter fd 7zip neovim nu

```
- **Also make sure you have [SPECIFICALLY python_3.12], any nodejs and any cl.exe i.e. visual studio complier for C and
C++ as they are used by tree-sitter to compile syntax parsers for most languages**


## RUNNING TASKS:

Just create a .vscode/launch.json file and write your tasks in its tasks field,
the schema my personal taskspawn plugin follows is exactly the same as vscode. 
```**Example at the bottom**```


## LSP SETUP:
In order to setup a new lsp server, just type `:Mason` and install whatever lsp you want
then go into lua/plugins/lspconfig.lua file and there at the bottom call
```lua
-- NOTE: the lsp_name MUST MATCH nvim-lspconfig's lsp name NOT the Mason lsp package name
-- You can find you lsp name in lspconfig docs by typeing `h lspconfig-all`
vim.lsp.enable("lsp_name")
```

NOTE: ensure_installed opts does not work in MASON or nvim-lsp config, you HAVE TO install lsp via `:Mason` command manually.


## DEBUGGING:

Setting up debug adapter for your language,
just create a new entery in the dap.adapters.you_adapter_name table like so:

```lua
-- setup debug adapters
local dap = require("dap")
dap.adapters.lldb = {
    type = "executable",
    command = "C:\\Program Files\\LLVM\\bin\\lldb-dap.exe",
    args = {},
}
```

NOTE: In the above the lldb is the name of the adapter and when writing the configuration file i.e.
.vscode/launch.json it should match the "type" field exactly in it as shown in the example below:

```json
{
  "$schema": "https://raw.githubusercontent.com/mfussenegger/dapconfig-schema/master/dapconfig-schema.json",
  "version": "0.2.0",

  // these are the tasks taskspawner reads
  "tasks": [
    {
      "label": "build-debug-win32-d3d11",
      "cmd": "odin run ./build_scripts -collection:topdown_game=. -out:./build_scripts/build.exe -- --debug --d3d11"
    },
  ],

  // these are the debug configuration dap reads
  "configurations": [
    {
      "name": "debug-win32-d3d11",
      "type": "lldb",     // <----------- this lldb should match with the dap.adapters.lldb
      "request": "launch",
      "program": "${workspaceFolder}/build/debug/main.exe",
      "cwd": "${workspaceFolder}"
    }
  ]
}
```

- vim Global autocomplete and intellsence
The vim global has full autocomplete and intellesence while editing this nvim config since
the file .luarc.json specifies the vim library path like so:
```json
{
  "$schema": "https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json",
  "workspace.library": [
    "C:/Users/Harsh/scoop/apps/neovim/current/share/nvim/runtime/lua" // <---- For Windows
  ]
}
```
