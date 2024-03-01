-- Set indenting to 2 spaces for specific filetypes
vim.api.nvim_exec(
	[[
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal shiftwidth=2
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal softtabstop=2
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal tabstop=2
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal expandtab
]],
	false
)
