(import-macros
  {: >==}
  :init-macros)

;; (vim.api.nvim_create_autocmd :FileType
;;                              {:pattern :lspinfo
;;                               :callback #(vim.api.nvim_buf_set_keymap
;;                                            0
;;                                            :n
;;                                            :q
;;                                            ":q<CR>"
;;                                            {:silent true})})

;; Terminal utilities
(vim.api.nvim_create_autocmd :TermOpen
                             {:pattern :*
                              :callback #((vim.api.nvim_buf_set_keymap
                                            0
                                            :t
                                            :<Esc>
                                            :<C-\><C-n>
                                            {})
                                          (vim.cmd ":startinsert")
                                          (vim.cmd "setlocal listchars= nonumber norelativenumber"))})

;;; Turn off hlsearch in Insert Mode
(vim.api.nvim_create_autocmd :InsertEnter
                             {:pattern :*
                              :command "setlocal nohlsearch"})

;;; Highlight yanked text
(vim.api.nvim_create_autocmd :TextYankPost
                             {:pattern :*
                              :callback #(vim.highlight.on_yank {:higroup :IncSearch
                                                                 :timeout 300})})

;;; Save Shada
(vim.api.nvim_create_autocmd :VimLeave
                             {:pattern :*
                              :command ":wshada!"})

;;; Set preffered shiftwidth for some filetypes
(fn set-shiftwidth [filetype shiftwidth]
  (vim.api.nvim_create_autocmd :FileType
                               {:pattern filetype
                                :callback #(vim.cmd
                                             (string.format
                                               " setlocal expandtab tabstop=%d shiftwidth=%d softtabstop=%d "
                                               shiftwidth
                                               shiftwidth
                                               shiftwidth))}))

(>== [:haskell
      :norg
      :xml
      :xslt
      :javascript
      :javascriptreact
      :javascript.jsx
      :typescript
      :typescriptreact
      :typescript.tsx
      :json
      :css
      :html
      :terraform
      :scheme
      :nix]
     #(set-shiftwidth $1 2))
