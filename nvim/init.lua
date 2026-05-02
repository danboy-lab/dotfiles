-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Configurações básicas
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

require("lazy").setup({
  spec = {
    { 
      "catppuccin/nvim", 
      name = "catppuccin", 
      priority = 1000,
      config = function()
        require("catppuccin").setup({
          flavour = "mocha",
          transparent_background = false,
          show_end_of_buffer = false,
          term_colors = true,
        })
        vim.cmd.colorscheme("catppuccin")
      end
    },
    
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
        { "<leader>f", "<cmd>NvimTreeFindFile<CR>", desc = "Find file in explorer" },
      },
      config = function()
        require("nvim-tree").setup({
          sort_by = "case_sensitive",
          view = { width = 30, side = "left" },
          renderer = { group_empty = true },
          filters = { dotfiles = false },
        })
      end
    },
    
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = {
            theme = "catppuccin",
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
          },
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
        })
      end
    },
    
    {
      "akinsho/bufferline.nvim",
      version = "*",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      keys = {
        { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
        { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
        { "<leader>bd", "<cmd>bdelete<CR>", desc = "Delete buffer" },
      },
      config = function()
        require("bufferline").setup({
          options = {
            numbers = "none",
            close_command = "bdelete! %d",
            right_mouse_command = "bdelete! %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            indicator = { icon = '▎', style = 'icon' },
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            max_name_length = 30,
            max_prefix_length = 30,
            tab_size = 20,
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level, diagnostics_dict)
              local s = " "
              for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " " or (e == "warning" and " " or "")
                s = s .. sym .. n
              end
              return s
            end,
            always_show_bufferline = true,
            theme = "catppuccin",
          },
        })
      end
    },
    
    {
      "ibhagwan/fzf-lua",
      keys = {
        { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
        { "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
        { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Find buffers" },
        { "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc = "Help tags" },
        { "<leader>fc", "<cmd>FzfLua commands<CR>", desc = "Commands" },
      },
      config = function()
        require("fzf-lua").setup({
          winopts = {
            preview = { layout = "vertical", vertical = "up:40%" },
          },
        })
      end
    },
  },
  
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true },
  change_detection = { notify = false },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
  
  -- 🔥 AQUI ESTÃO OS ÍCONES DE RAIOZINHO E OUTROS 🔥
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      import = "📥",
      keys = "🔑",
      lazy = "💤",
      loaded = "🔋",
      not_loaded = "⚡",        -- <-- raiozinho quando não carregado
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
})
