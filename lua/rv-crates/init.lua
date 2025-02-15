local M = {}

M.config = function()

    local opt = {
        smart_insert = true, -- try to be smart about inserting versions
        insert_closing_quote = true,
        avoid_prerelease = true, -- don"t select a prerelease if the requirement does not have a suffix
        autoload = true, -- automatically run update when opening a Cargo.toml
        autoupdate = true, -- automatically update when editing text
        loading_indicator = true, -- show a loading indicator while fetching crate versions
        date_format = "%Y-%m-%d", -- the date format passed to os.date
        thousands_separator = ".",
        notification_title = "Crates",
        disable_invalid_feature_diagnostic = false,
        text = {
            loading    = "   Loading",
            version    = "   %s",
            prerelease = "   %s",
            yanked     = "   %s",
            nomatch    = "   No match",
            upgrade    = "   %s",
            error      = "   Error fetching crate",
        },
        highlight = {
            loading    = "CratesNvimLoading",
            version    = "CratesNvimVersion",
            prerelease = "CratesNvimPreRelease",
            yanked     = "CratesNvimYanked",
            nomatch    = "CratesNvimNoMatch",
            upgrade    = "CratesNvimUpgrade",
            error      = "CratesNvimError",
        },
        popup = {
            autofocus = false, -- focus the versions popup when opening it
            copy_register = "\"", -- the register into which the version will be copied
            style = "minimal", -- same as nvim_open_win config.style
            border = "single", -- same as nvim_open_win config.border
            show_version_date = false,
            show_dependency_version = true,
            max_height = 30,
            min_width = 20,
            padding = 1,
            text = {
                title               = " %s",
                pill_left           = "",
                pill_right          = "",
                description         = "%s",
                created_label       = " created        ",
                created             = "%s",
                updated_label       = " updated        ",
                updated             = "%s",
                downloads_label     = " downloads      ",
                downloads           = "%s",
                homepage_label      = " homepage       ",
                homepage            = "%s",
                repository_label    = " repository     ",
                repository          = "%s",
                documentation_label = " documentation  ",
                documentation       = "%s",
                crates_io_label     = " crates.io      ",
                crates_io           = "%s",
                categories_label    = " categories     ",
                keywords_label      = " keywords       ",
                version             = "  %s",
                prerelease          = " %s",
                yanked              = " %s",
                version_date        = "  %s",
                feature             = "  %s",
                enabled             = " %s",
                transitive          = " %s",
                dependency          = "  %s",
                optional            = " %s",
                dependency_version  = "  %s",
                loading             = " ",
            },
            highlight = {
                title               = "CratesNvimPopupTitle",
                pill_text           = "CratesNvimPopupPillText",
                pill_border         = "CratesNvimPopupPillBorder",
                description         = "CratesNvimPopupDescription",
                created_label       = "CratesNvimPopupLabel",
                created             = "CratesNvimPopupValue",
                updated_label       = "CratesNvimPopupLabel",
                updated             = "CratesNvimPopupValue",
                downloads_label     = "CratesNvimPopupLabel",
                downloads           = "CratesNvimPopupValue",
                homepage_label      = "CratesNvimPopupLabel",
                homepage            = "CratesNvimPopupUrl",
                repository_label    = "CratesNvimPopupLabel",
                repository          = "CratesNvimPopupUrl",
                documentation_label = "CratesNvimPopupLabel",
                documentation       = "CratesNvimPopupUrl",
                crates_io_label     = "CratesNvimPopupLabel",
                crates_io           = "CratesNvimPopupUrl",
                categories_label    = "CratesNvimPopupLabel",
                keywords_label      = "CratesNvimPopupLabel",
                version             = "CratesNvimPopupVersion",
                prerelease          = "CratesNvimPopupPreRelease",
                yanked              = "CratesNvimPopupYanked",
                version_date        = "CratesNvimPopupVersionDate",
                feature             = "CratesNvimPopupFeature",
                enabled             = "CratesNvimPopupEnabled",
                transitive          = "CratesNvimPopupTransitive",
                dependency          = "CratesNvimPopupDependency",
                optional            = "CratesNvimPopupOptional",
                dependency_version  = "CratesNvimPopupDependencyVersion",
                loading             = "CratesNvimPopupLoading",
            },
            keys = {
                hide           = { "q", "<ESC>" },
                open_url       = { "<CR>" },
                select         = { "<CR>" },
                select_alt     = { "s" },
                copy_value     = { "yy" },
                toggle_feature = { "<CR>" },
                goto_item      = { "gd", "K", "<C-LeftMouse>" },
                jump_forward   = { "<C-i>" },
                jump_back      = { "<C-o>", "<C-RightMouse>" },
            },
        },
        src = {
            insert_closing_quote = false,
            text = {
                prerelease = "  pre-release ",
                yanked = "  yanked ",
            },
            coq = {
                enabled = false,
                name = "Crates",
            },
        },
        null_ls = {
            enabled = false,
            name = "Crates",
        },
    }

    require("crates").setup(opt)

    local wk = require("which-key")

    local mappings = {
        r = {
            name = "Crates",
            t = { require("crates").toggle , "Toggle" },
            r = { require("crates").reload , "Reload" },
            v = { require("crates").show_versions_popup , "Versions popup" },
            f = { require("crates").show_features_popup , "Features popup" },
            c = { require("crates").show_crate_popup , "Crate popup" },
            u = { require("crates").update_crate , "Update crate" },
            a = { require("crates").update_all_crates , "Update all crates" },
            U = { require("crates").upgrade_crate , "Upgrade crate" },
            A = { require("crates").upgrade_all_crates , "Upgrade all crates" },
            H = { require("crates").open_homepage , "Open homepage" },
            R = { require("crates").open_repository , "Open repository" },
            D = { require("crates").open_documentation , "Open documentation" },
            C = { require("crates").open_crates_io , "Open crates.io" },
        },
    }

    local visualMappings = {
        r = {
            name = "Crates",
            u = { require("crates").update_crates , "Update crates" },
            U = { require("crates").upgrade_crates , "Upgrade crates" },
        }
    }

    wk.register(mappings, { prefix = "<leader>" })
    wk.register(visualMappings, { mode = "v", prefix = "<leader>" })

end

return M
