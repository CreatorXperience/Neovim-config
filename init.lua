--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = "n"
vim.g.localleader = "\\"

-- IMPORTS
 require('vars')      -- Variables
 require('opts')      -- Options
 require('keys')      -- Keymaps
 require('plug')      -- Plugins


-- PLUGINS: Add this section
require('nvim-tree').setup{}
-- PLUGINS
require('nvim-tree').setup{}
-- Add the block below
require('lualine').setup {
  options = {
    theme = 'dracula-nvim'
  }
}
require('nvim-autopairs').setup{}
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Use LuaSnip for snippets
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept completion with enter
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },    -- LSP completions
    { name = 'luasnip' },     -- Snippet completions
  }, {
    { name = 'buffer' },      -- Buffer completions
  })
})

-- Use buffer source for '/' and ':' (command line).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup LSP servers.
local lspconfig = require'lspconfig'

-- Example: Configuring the Python LSP (pyright).
lspconfig.pyright.setup{
  on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  end
}

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "bashls", "eslint", "glint" ,"biome","pylsp" , "html" }
}

require'lspconfig'.biome.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.glint.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.html.setup{}
