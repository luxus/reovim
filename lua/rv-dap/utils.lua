local M = {}

local dap_mappings = function()
    local wk = require("which-key")

    local mappings = {
        d = {
            name = "DAP",
            b = {
                name = "Breakpoint",
                t = { require("dap").toggle_breakpoint, "Toggle"}
            },
            c = { require("dap").continue, "Continue" },
            C = { require("dap").run_to_cursor, "Run to Cursor" },
            s = {
                name = "Step",
                o = { require("dap").step_over, "Over" },
                i = { require("dap").step_into, "Into" },
                u = { require("dap").step_out, "Out" },
                b = { require("dap").step_back, "Back" },
            },
            -- p = { require("dap").pause.toggle, "Pause" },
            r = { require("dap").repl.toggle, "REPL"},
            d = { require("dap").disconnect, "Disconnect" },
            q = { require("dap").close, "Quit" },
            g = { require("dap").session, "Get Session" },
        },
    }

    wk.register(mappings, { prefix = "<leader>" })
end

local dap_override_icons = function()
    local signs = {
        Breakpoint = {
            text = "",
            texthl = "LspDiagnosticsSignError",
            linehl = "",
            numhl = "",
        },
        BreakpointRejected = {
            text = "",
            texthl = "LspDiagnosticsSignHint",
            linehl = "",
            numhl = "",
        },
        Stopped = {
            text = "",
            texthl = "LspDiagnosticsSignInformation",
            linehl = "DiagnosticUnderlineInfo",
            numhl = "LspDiagnosticsSignInformation",
        },
    }

    for type, data in pairs(signs) do
        local name = "Dap" .. type
        vim.fn.sign_define(name, data)
    end
end

local dap_set_repl = function()
    require("dap").defaults.fallback.terminal_win_cmd = "50vsplit new"
end

M.dap_mappings = dap_mappings
M.dap_override_icons = dap_override_icons
M.dap_set_repl = dap_set_repl

return M
