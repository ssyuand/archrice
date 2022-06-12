local cmp = require 'cmp'
cmp.register_source('path', require('lsp.path').new())
cmp.setup({
    mapping = {
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        })
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    sources = {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'look' },
        { name = 'nvim_lsp' },
    },
    --menu width
    formatting = {
        fields = { "abbr", "menu", "kind" };
        format = function(entry, vim_item)
            local kind_icons = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "ﰠ",
                Variable = "",
                Class = "ﴯ",
                Interface = "",
                Module = "",
                Property = "ﰠ",
                Unit = "塞",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "פּ",
                Event = "",
                Operator = "",
                TypeParameter = "",
            }
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 66)
            return vim_item
        end
    },
    experimental = {
        ghost_text = true,
        native_menu = false
    }
})
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    },
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })
})

--<C-j>, <C-k> mapping
_G.Next = function(str)
    str = "<C-n>"
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.previous = function(str)
    str = "<C-p>"
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
vim.api.nvim_set_keymap("i", "<C-j>", "v:lua.Next()", { expr = true })
vim.api.nvim_set_keymap("i", "<C-k>", "v:lua.previous()", { expr = true })
