local M = {}

M.config = function()

local opt = {
        -- General options
        auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text   = "Just a text editor",       -- Text displayed when hovered over the Neovim image
        main_image          = "file",                     -- Main image display (either "neovim" or "file")
        client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
        log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number  = true,                       -- Displays the current line number instead of the current project
        blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)

        -- Rich Presence text options
        -- editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer
        editing_text        = function(filename) -- filename arg doesn"t need to be used here
            -- Determine type of file using vim"s &filetype variable
            local filetype = vim.bo.filetype:gsub("^%l", string.upper)
            return string.format("Editing a %s file (%s)", filetype, filename)
        end,
        file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer
        git_commit_text     = "Committing changes",       -- Format string rendered when commiting changes in git
        plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins
        -- reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer
        reading_text        = function(filename)
            if filename:find("zsh") == 1 then
                return string.format("Using terminal #%s", string.sub(filename, -1))
            else
                return string.format("Reading %s", filename)
            end
        end,
        workspace_text      = "Working on %s",            -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
        line_number_text    = "Line %s out of %s",        -- Line number format string (for when enable_line_number is set to true)
    }

    require("presence"):setup(opt)

end

return M
