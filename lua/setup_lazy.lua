local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local lazy_opts = {
  change_detection = { enabled = false, notify = false }
}
require('lazy').setup({
  -- tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim',          config = true },
      { 'williamboman/mason-lspconfig.nvim' },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim'
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },
  {
    'folke/which-key.nvim',
    version = "v3.10.0",
    opts = {},
    keys = {
      -- harpoon navigation
      { "<leader>,",         "<cmd>lua require('harpoon.ui').nav_file(2)<CR>",          desc = "goto2" },
      { "<leader><leader>.", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",          desc = "goto3" },
      { "<leader>i",         "<cmd>lua require('harpoon.ui').nav_file(8)<cr>",          desc = "goto8" },
      { "<leader><leader>j", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>",          desc = "goto4" },
      { "<leader><leader>k", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>",          desc = "goto5" },
      { "<leader><leader>l", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>",          desc = "goto6" },
      { "<leader><leader>m", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",          desc = "goto1" },
      { "<leader><leader>o", "<cmd>lua require('harpoon.ui').nav_file(9)<cr>",          desc = "goto9" },
      { "<leader><leader>u", "<cmd>lua require('harpoon.ui').nav_file(7)<CR>",          desc = "goto7" },
      { "<leader>m",         "<cmd>lua require('harpoon.mark').add_file()<CR>",         desc = "Harpoon Mark" },
      { "<leader>H",         "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",  desc = "Harpoon Menu" },
      -- file and nvim standard operations
      { "<leader>w",         "<cmd>w!<CR>",                                             desc = "Save" },
      { "<leader>Q",         "<cmd>qa!<CR>",                                            desc = "Quit" },
      { "<leader>c",         "<cmd>bdelete<CR>",                                        desc = "Close Buffer" },
      { "<leader>e",         "<cmd>LFGoTo<CR>",                                         desc = "Explore Files" },
      { "<leader>r",         "<cmd>lua vim.lsp.buf.rename()<cr>",                       desc = "Rename" },
      { "<leader>D",         'ggvG"dd',                                                 desc = "Clear" },
      { "<leader>Y",         "<cmd>%y<cr>",                                             desc = "Copy All" },

      -- editing super powers
      { "<leader>ealn",      ":s/^/\\=(line('.')-line(\"'<\")+0)/",                     desc = "Add line numbers",                              mode = "v" },
      { "<leader>erc",       ":s/^.\\{0,1\\}//",                                        desc = "Remove character(s) at the start of each line", mode = "v" },
      { "<leader>ern",       ":s/^\\d*//",                                              desc = "Remove numbers at the start of each line",      mode = "v" },

      -- fold
      { "<leader>f",         "<cmd>ToggleEnableFold<cr>",                               desc = "Toggle Fold Feature" },
      -- lsp
      { "<leader>lI",        "<cmd>Mason<cr>",                                          desc = "Installer Info" },
      { "<leader>lS",        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",        desc = "Workspace Symbols" },
      { "<leader>la",        "<cmd>lua vim.lsp.buf.code_action()<cr>",                  desc = "Code Action" },
      { "<leader>ld",        "<cmd>lua vim.diagnostic.open_float()<cr>",                desc = "Diagnostics" },
      { "<leader>lf",        "<cmd>lua vim.lsp.buf.format { async = true }  <cr>",      desc = "Format" },
      { "<leader>li",        "<cmd>LspInfo<cr>",                                        desc = "Info" },
      { "<leader>lj",        "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",             desc = "Next Diagnostic" },
      { "<leader>lk",        "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",             desc = "Prev Diagnostic" },
      { "<leader>ll",        "<cmd>lua vim.lsp.codelens.run()<cr>",                     desc = "CodeLens Action" },
      { "<leader>lr",        "<cmd>lua vim.lsp.buf.rename()<cr>",                       desc = "Rename" },

      { "<leader>q",         "<cmd>lua vim.diagnostic.setloclist()<cr>",                desc = "Quickfix" },

      { "<leader>\"",        "viwxi\"\"<esc>P",                                         desc = 'double quotes' },
      { "<leader>\'",        "viwxi''<esc>P",                                           desc = 'single quotes' },

      -- telescope search
      { "<leader>so",        "<cmd>lua require('telescope.builtin').buffers()<cr>",     desc = 'Open files' },
      { "<leader>sr",        "<cmd>lua require('telescope.builtin').oldfiles()<cr>",    desc = 'Recent files' },
      { "<leader>sf",        "<cmd>lua require('telescope.builtin').find_files()<cr>",  desc = 'All files' },
      { "<leader>sg",        "<cmd>lua require('telescope.builtin').git_files()<cr>",   desc = "Git Files" },
      { "<leader>sh",        "<cmd>lua require('telescope.builtin').help_tags()<cr>",   desc = 'Help' },
      { "<leader>sw",        "<cmd>lua require('telescope.builtin').grep_string()<cr>", desc = 'Current word' },
      { "<leader>st",        "<cmd>lua require('telescope.builtin').live_grep()<cr>",   desc = 'Text' },
      { "<leader>sd",        "<cmd>lua require('telescope.builtin').diagnostics()<cr>", desc = 'Diagnostics' },
    }
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = require('settings.gitsigns').opts,
  },

  {
    -- Theme inspired by Atom
    'sar/ultra-darkplus.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'darkplus'
    end,
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {},
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground'
    },
    build = ':TSUpdate',
  },

  { import = 'plugins' },
}, lazy_opts)
