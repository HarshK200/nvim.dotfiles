# My MAIN neovim config (Uses Neovim v0.12)

- This is my main neovim config which i use on windows and will most porbably use on linux
- The plugins are kept to the minimal for maximum startup speed and minimal lag
- Lazy.nvim package manager used

- RUNNING TASKS:
Just create a .vscode/launch.json file and write your tasks in its tasks field,
the schema my personal taskspawn plugin follows is exactly the same as vscode. 
```**Example at the bottom**```

- DEBUGGING:

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
