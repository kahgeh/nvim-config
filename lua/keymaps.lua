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
  keymap("i", "<A-BS>", "<ESC>hdaw", opts)
  keymap("i", "<S-BS>", "<ESC>hdaw", opts)
  keymap("n", "<DEL>", '"dd1l', opts)
  keymap("i", "<DEL>", '<ESC>l"dd1li', opts)
  keymap("v", "<DEL>", '"dd', opts)


  keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  -- Enable telescope fzf native, if installed
  pcall(require('telescope').load_extension, 'fzf')

  -- See `:help telescope.builtin`
  vim.keymap.set('n', '<leader>sr', M.oldfiles, { desc = 'Recently opened files' })
  vim.keymap.set('n', '<leader>so', require('telescope.builtin').buffers, { desc = 'Open files' })
  vim.keymap.set('n', '<leader>sg', require('telescope.builtin').git_files, { desc = 'Git Files' })
  vim.keymap.set('n', '<leader>sf', M.find_files, { desc = 'Files' })
  vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Help' })
  vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Current word' })
  vim.keymap.set('n', '<leader>st', require('telescope.builtin').live_grep, { desc = 'Text' })
  vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Diagnostics' })

  local n_opts = {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

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

  local n_mappings = {
    ["e"] = { "<cmd>LFGoTo<CR>", "Explore Files" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["Q"] = { "<cmd>qa!<CR>", "Quit" },
    ["c"] = { "<cmd>bdelete<CR>", "Close Buffer" },
    ["C"] = { "<cmd>execute '%bdelete|edit#|bdelete#|NvimTreeToggle'<CR>", "Close All Others" },
    ["f"] = { "<cmd>ToggleEnableFold<cr>", "Toggle Fold Feature" },
    s = {
      name = "Search"
    },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = {
        "<cmd>lua vim.diagnostic.open_float()<cr>",
        "Diagnostics",
      },
      w = {
        "<cmd>Telescope diagnostics<cr>",
        "Workspace Diagnostics",
      },
      f = { "<cmd>lua vim.lsp.buf.format { async = true }  <cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>Mason<cr>", "Installer Info" },
      j = {
        "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
        "Next Diagnostic",
      },
      k = {
        "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
        "Prev Diagnostic",
      },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
      },
    },
    H = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Harpoon Menu" },
    m = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Harpoon Mark" },
    [" "] = { name = "Goto",
      ["m"] = { "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", "goto1" },
      [","] = { "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", "goto2" },
      ["."] = { "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", "goto3" },
      ["j"] = { "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", "goto4" },
      ["k"] = { "<CMD>lua require('harpoon.ui').nav_file(5)<CR>", "goto5" },
      ["l"] = { "<CMD>lua require('harpoon.ui').nav_file(6)<CR>", "goto6" },
    }
  }
  local status, which_key = pcall(require, 'which-key')
  if status then
    which_key.register(n_mappings, n_opts)
  end
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
