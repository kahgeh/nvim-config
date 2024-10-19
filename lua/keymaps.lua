local M = {}

M.find_files = function()
  require("telescope.builtin").find_files({
    hidden = true,
    file_ignore_patterns = { "node_modules", ".git" }
  })
end

M.oldfiles = function()
  require("telescope.builtin").oldfiles({
    hidden = true,
    only_cwd = true,
    file_ignore_patterns = { "node_modules", ".git" }
  })
end

M.configure_core = function()
  local opts = { noremap = true, silent = true }

  -- Shorten function name
  local keymap = vim.api.nvim_set_keymap

  --Remap space as leader key
  keymap("", "<Space>", "<Nop>", opts)
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Modes
  --   normal_mode = "n",
  --   insert_mode = "i",
  --   visual_mode = "v",
  --   visual_block_mode = "x",
  --   term_mode = "t",
  --   command_mode = "c",

  -- Normal --
  -- Better window navigation
  keymap("n", "<C-h>", "<C-w>h", opts)
  keymap("n", "<C-j>", "<C-w>j", opts)
  keymap("n", "<C-k>", "<C-w>k", opts)
  keymap("n", "<C-l>", "<C-w>l", opts)

  -- Resize with arrows
  keymap("n", "<C-Up>", ":resize -2<CR>", opts)
  keymap("n", "<C-Down>", ":resize +2<CR>", opts)
  keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
  keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

  -- Navigate buffers
  keymap("n", "<S-l>", ":bnext<CR>", opts)
  keymap("n", "<S-h>", ":bprevious<CR>", opts)

  -- Move text up and down
  keymap("n", "<A-j>", "<Esc>:m .+1<CR>", opts)
  keymap("n", "<A-k>", "<Esc>:m .-2<CR>", opts)

  -- Insert --
  -- Press jk fast to enter
  keymap("i", "jk", "<ESC>", opts)

  -- Visual --
  -- Stay in indent mode
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)

  -- Move text up and down
  keymap("v", "<A-j>", ":m .+1<CR>==", opts)
  keymap("v", "<A-k>", ":m .-2<CR>==", opts)
  keymap("v", "p", '"_dP', opts)

  -- Visual Block --
  -- Move text up and down
  keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
  keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
  keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
  keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

  -- Buffer navigation --
  keymap("n", "<A-BS>", "bdw", opts)
  keymap("n", "d", '"dd', opts) -- delete shouldn't move update the default register
  keymap("n", "c", '"dc', opts) -- delete shouldn't move update the default register
  keymap("v", "d", '"dd', opts) -- delete shouldn't move update the default register
  keymap("i", "<A-BS>", "<ESC>hdaw", opts)
  keymap("i", "<S-BS>", "<ESC>hdaw", opts)
  keymap("n", "<DEL>", '"dd1l', opts)
  keymap("i", "<DEL>", '<ESC>l"dd1li', opts)
  keymap("v", "<DEL>", '"dd', opts)


  keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  -- Enable telescope fzf native, if installed
  pcall(require('telescope').load_extension, 'fzf')

  vim.api.nvim_create_user_command('LFGoTo',
    function()
      local current_file_path = vim.api.nvim_buf_get_name(0)
      if vim.g.lf == nil or current_file_path == nil then
        require('telescope.builtin').find_files()
        return
      end
      vim.cmd(':!lf -remote \"send ' ..
        vim.g.lf.clientid ..
        ' select ' .. vim.api.nvim_buf_get_name(0) .. '\" && tmux select-pane -t ' .. vim.g.lf.pane_number)
      vim.cmd(':!lf -remote \"send ' .. vim.g.lf.clientid .. ' maximise"')
    end,
    { nargs = 0 })

  vim.api.nvim_create_user_command('ToggleEnableFold',
    function()
      if vim.wo.foldexpr == nil or vim.wo.foldexpr == '' then
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        return
      end
      vim.wo.foldexpr = ''
    end,
    { nargs = 0 })
end

M.configure_lsp = function(bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
end

return M
