local M = {}

M.ui = {
    telescope = {style = "borderless"}, -- borderless / bordered
    cheatsheet = {theme = "grid"},
    hl_add = {},
    hl_override = {},
    extended_integrations = {},
    changed_themes = {},
    theme_toggle = {"onedark", "one_light"},
    theme = "onedark",
    -- cmp themeing
    cmp = {
        icons = true,
        lspkind_text = true,
        style = "default", -- default/flat_light/flat_dark/atom/atom_colored
        border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
        selected_item_bg = "colored" -- colored / simple
    },
    statusline = {
        theme = "default", -- default/vscode/vscode_colored/minimal
        -- default/round/block/arrow separators work only for default statusline theme
        -- round and block will work for minimal theme only
        separator_style = "default",
        overriden_modules = nil
    },
    -- lazyload it when there are 1+ buffers
    tabufline = {
        show_numbers = false,
        enabled = true,
        lazyload = true,
        overriden_modules = nil
    },
    nvdash = {
        load_on_startup = false
    }
}

M.base46 = {
  integrations = {},
}

return M

