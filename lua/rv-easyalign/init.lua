local M = {}

M.config  = function()

    local wk = require("which-key")

    local mappings = {
        ["ga"] = { "<Plug>(EasyAlign)", "EasyAlign" },
    }

    wk.register(mappings, { prefix = "" })
    wk.register(mappings, { mode = "v", prefix = "" })

end

return M
