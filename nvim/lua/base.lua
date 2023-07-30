vim.cmd 'filetype plugin indent on'
vim.cmd 'syntax enable'

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileformats = { "unix", "dos", "mac" }

vim.opt.viminfo += "/var/tmp/vim/viminfo"
vim.opt.directory = "/var/tmp/vim/"
vim.opt.undodir = "/var/tmp/vim/"
vim.opt.backupdir = "/var/tmp/vim/"
vim.opt.writebackup = true

vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = { eol = "¶", tab = "|", trail = "~" }

vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.scrolloff = 4

vim.opt.mouse -= "a"

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.clipborad = "unnamedplus"

vim.opt.hidden = true

vim.cmd 'autocmd ColorScheme * highlight Normal ctermbg=none guibg=none'
vim.cmd 'autocmd ColorScheme * highlight NonText ctermbg=none guibg=none'
vim.cmd 'autocmd ColorScheme * highlight LineNr ctermbg=none guibg=none'
vim.cmd 'autocmd ColorScheme * highlight Folded ctermbg=none guibg=none'
vim.cmd 'autocmd ColorScheme * highlight EndOfBuffer ctermbg=none guibg=none'
