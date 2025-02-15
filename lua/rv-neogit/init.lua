local M = {}

M.config = function()

    local opt = {
        disable_context_highlighting = false,
        disable_signs = false,
        disable_commit_confirmation = false,
        disable_builtin_notifications = false,
        disable_insert_on_commit = false,
        auto_refresh = true,
        commit_popup = {
            kind = "split",
        },
        signs = {
            hunk = { "", "" },
            item = { ">", "v" },
            section = { ">", "v" }
        },
        integrations = {
            diffview = true
        },
        mappings = {
            status = {
                ["q"] = "Close",
                ["1"] = "Depth1",
                ["2"] = "Depth2",
                ["3"] = "Depth3",
                ["4"] = "Depth4",
                ["<tab>"] = "Toggle",
                ["x"] = "Discard",
                ["s"] = "Stage",
                ["S"] = "StageUnstaged",
                ["<c-s>"] = "StageAll",
                ["u"] = "Unstage",
                ["U"] = "UnstageStaged",
                ["d"] = "DiffAtFile",
                ["$"] = "CommandHistory",
                ["<c-r>"] = "RefreshBuffer",
                ["<enter>"] = "GoToFile",
                ["<c-v>"] = "VSplitOpen",
                ["<c-x>"] = "SplitOpen",
                ["<c-t>"] = "TabOpen",
                ["?"] = "HelpPopup",
                ["D"] = "DiffPopup",
                ["p"] = "PullPopup",
                ["r"] = "RebasePopup",
                ["P"] = "PushPopup",
                ["c"] = "CommitPopup",
                ["L"] = "LogPopup",
                ["Z"] = "StashPopup",
                ["b"] = "BranchPopup",
            }
        }
    }

    require("neogit").setup(opt)

    local wk = require("which-key")

    local mappings = {
        g = {
            name = "Git",
            s = { function() require("neogit").open() end, "Status" },
        },
    }

    wk.register(mappings, { prefix = "<leader>" })

end

return M
