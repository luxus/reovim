(import-macros
  {: rv
   : apply : call
   : >=> : filter
   : i>=> : ifilter
   : |>
   : ||> : o : compose
   : >== : foreach
   : i>== : forieach
   : map
   : imap}
  :init-macros)

(local packer (require :packer))

((. (require :packer.luarocks)
    :install_commands))

(packer.startup
  {1 (fn [use use-rocks]
       (local
         {: lsp_progress
          : lua_index_plugins}
         (. (require :globals) :custom))

       (use {1 :wbthomason/packer.nvim})
       (use {1 :rktjmp/hotpot.nvim
             :config (rv :hotpot)})
       (use {1 :lewis6991/impatient.nvim})

       ;; (local colourschemes
       ;;        [[:monokai
       ;;          :tanvirtin/monokai.nvim]
       ;;         [:sonokai
       ;;          :sainnhe/sonokai]
       ;;         [:nightfox 
       ;;          :EdenEast/nightfox.nvim]
       ;;         [:tokyonight 
       ;;          :folke/tokyonight.nvim 
       ;;          true]
       ;;         [:nebulous 
       ;;          :Yagua/nebulous.nvim]])
       (use {1 :folke/tokyonight.nvim
             :config (rv :tokyonight)})
       ;; (use {1 :EdenEast/nightfox.nvim
       ;;       :config (rv :nightfox)})

       (use {1 :nvim-telescope/telescope.nvim
             :requires [[:nvim-lua/popup.nvim]
                        [:nvim-lua/plenary.nvim]]
             :config (rv :telescope)})
       (local telescope-plugins
              [:nvim-telescope/telescope-packer.nvim
               :nvim-telescope/telescope-fzf-native.nvim
               :nvim-telescope/telescope-github.nvim
               :nvim-telescope/telescope-media-files.nvim
               :nvim-telescope/telescope-symbols.nvim
               :nvim-telescope/telescope-file-browser.nvim])

       (fn convert-to-telescope-opt [telescope-plugin]
         (let [opt {1 telescope-plugin
                    :requires [[:nvim-telescope/telescope.nvim]]}]
           opt))

       (fn modify-fzf-native [opt]
         (if (= (. opt 1) :nvim-telescope/telescope-fzf-native)
           (vim.tbl_deep_extend :force
                                {:run :make}
                                opt)
           ;; else
           opt))

       (i>== telescope-plugins
             (||>
               convert-to-telescope-opt
               modify-fzf-native
               use))

       (use {1 :vhyrro/neorg
             :requires [[:hrsh7th/nvim-cmp]
                        [:nvim-lua/plenary.nvim]
                        [:nvim-neorg/neorg-telescope]]
             :after [:telescope.nvim
                     :nvim-treesitter
                     :nvim-cmp]
             :config (rv :neorg)})
       (use {1 :nvim-neorg/neorg-telescope
             :requires [[:nvim-telescope/telescope.nvim]]})
       (use {1 :iamcco/markdown-preview.nvim
             :run (. vim.fn "mkdp#util#install")
             :config (rv :mdpreview)})
       (use {1 :jghauser/follow-md-links.nvim
             :requires [[:nvim-treesitter/nvim-treesitter]]
             :config (rv :mdlinks)})
       ;; (use {1 :nvim-orgmode/orgmode
       ;;       :requires [[:nvim-treesitter/nvim-treesitter]]
       ;;       :config (rv :orgmode)})
       ;; (use {1 :lukas-reineke/headlines.nvim
       ;;       :as :headlines
       ;;       :requires [[:nvim-orgmode/orgmode]
       ;;                  [:nvim-treesitter/nvim-treesitter]]
       ;;       :config (rv :headlines)})
       (use {1 :phaazon/mind.nvim
             :as :mind
             :requires [[:nvim-lua/plenary.nvim]]
             :branch :v2.2
             :config (rv :mind)})
       (use {1 :segeljakt/vim-silicon
             :config (rv :silicon)})
       (use {1 :folke/which-key.nvim
             :config (||>
                       (rv :whichkey)
                       (rv :whichkey.presets))})
       (use {1 :anuvyklack/hydra.nvim})
       (use {1 :goolord/alpha-nvim
             :as :alpha
             :config (rv :alpha)
             :disable true})
       (use {1 :rebelot/heirline.nvim
             :as :heirline
             :config (rv :heirline)
             :requires [[:kyazdani42/nvim-web-devicons]
                        [:lewis6991/gitsigns.nvim]]
             :after [:navic
                     :gitsigns]})
       (use {1 :SmiteshP/nvim-gps
             :as :gps
             :config (rv :gps)
             :requires [[:nvim-treesitter/nvim-treesitter]]})
       (use {1 :SmiteshP/nvim-navic
             :as :navic
             :config (rv :navic)
             :requires [[:nvim-treesitter/nvim-treesitter]]})
       (use {1 :romgrk/barbar.nvim
             :as :barbar
             :config (rv :barbar)
             :opt true})
       (use {1 :akinsho/bufferline.nvim
             :as :bufferline
             :config (rv :bufferline)
             :requires [[:kyazdani42/nvim-web-devicons]]
             :disable true})
       (use {1 :kyazdani42/nvim-web-devicons
             :config (rv :devicons)})
       (use {1 :yamatsum/nvim-nonicons
             :disable true
             :requires [[:kyazdani42/nvim-web-devicons]]
             :after [:nvim-web-devicons]})
       (use {1 :NvChad/nvim-colorizer.lua
             :as :colourizer
             :config (rv :colourizer)})
       (use {1 :andweeb/presence.nvim
             :as :presence
             :config (rv :presence)})
       (use {1 :RishabhRD/nvim-cheat.sh
             :requires [[:RishabhRD/popfix]]
             :config (rv :cheatsh)})
       (use {1 :rcarriga/nvim-notify
             :as :notify
             :config (rv :notify)})
       (use {1 :neovim/nvim-lspconfig
             :config (rv :lsp)})
       (use {1 :folke/trouble.nvim
             :requires [[:kyazdani42/nvim-web-devicons]]
             :config (rv :lsp.trouble)})
       (use {1 :ray-x/lsp_signature.nvim})
       (use {1 :kosayoda/nvim-lightbulb
             :disable true
             :config (rv :lsp.lightbulb)})
       (use {1 "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
             :as :lsp-lines
             :config (rv :lsp.lines)})
       (use {1 :jose-elias-alvarez/null-ls.nvim
             :requires [[:nvim-lua/plenary.nvim]
                        [:neovim/nvim-lspconfig]]})
       (use {1 :nanotee/sqls.nvim
             :requires [[:vim-scripts/dbext.vim]]})
       (use {1 :stevearc/aerial.nvim
             :config (rv :aerial)
             :disable true})
       (use {1 :saecki/crates.nvim
             :event ["BufRead Cargo.toml"]
             :requires [[:nvim-lua/plenary.nvim]]
             :config (rv :crates)})
       (use {1 :weilbith/nvim-code-action-menu
             :as :code-action-menu
             :cmd :CodeActionMenu})
       (use {1 :NTBBloodbath/rest.nvim
             :requires [[:nvim-lua/plenary.nvim]]
             :config (rv :rest)
             :ft [:http]})
       (use {1 :simrat39/rust-tools.nvim
             :config (rv :lsp.langs.rust-tools)})
       (use {1 :mlochbaum/BQN :rtp :editors/vim})
       (use {1 :shirk/vim-gas})
       (use {1 :aklt/plantuml-syntax})
       (use {1 :alaviss/nim.nvim
             :rtp :syntax
             :disable true})
       (use {1 :McSinyx/vim-octave})
       (use {1 :kmonad/kmonad-vim})
       (use {1 :scalameta/nvim-metals
             :requires [[:nvim-lua/plenary.nvim]]
             :config (rv :lsp.langs.metals)})
       (use {1 :Olical/aniseed
             :config (rv :aniseed)
             :disable true})
       (use {1 :Olical/conjure
             :config (rv :conjure)
             :disable true})
       (use {1 :eraserhd/parinfer-rust
             :config (rv :parinfer)
             :run "cargo build --release"
             :cond (= (vim.fn.executable :cargo) 1)})
       (use {1 :stevearc/dressing.nvim
             :config (rv :dressing)})
       (use {1 :mfussenegger/nvim-jdtls
             :config (rv :lsp.langs.jdtls)})
       (use {1 :jakewvincent/texmagic.nvim
             :config (rv :lsp.langs.texmagic)})
       (use {1 :jbyuki/nabla.nvim
             :config (rv :nabla)})
       (use {1 :b0o/schemastore.nvim})
       (use {1 :j-hui/fidget.nvim
             :as :fidget
             :config (rv :fidget)
             :cond (= lsp_progress :fidget)})
       (use {1 :nanotee/luv-vimdocs})
       (use {1 :milisims/nvim-luaref})
       (use {1 :mfussenegger/nvim-dap
             :config (rv :dap)})
       (use {1 :theHamsta/nvim-dap-virtual-text
             :requires [[:mfussenegger/nvim-dap]]
             :config (rv :dap.virttext)})
       (use {1 :rcarriga/nvim-dap-ui
             :requires [[:mfussenegger/nvim-dap]]
             :config (rv :dap.dapui)})
       (use {1 :L3MON4D3/LuaSnip
             :as :luasnip
             :config (rv :luasnip)})
       (use {1 :rafamadriz/friendly-snippets})
       (use {1 :sunjon/shade.nvim
             :disable true
             :config (rv :shade)})
       (use {1 :folke/twilight.nvim
             :config (rv :twilight)})
       (use {1 :xiyaowong/nvim-transparent
             :as :nvim-transparency
             :config (rv :transparency)})

       ;; Treesitter
       (use {1 :nvim-treesitter/nvim-treesitter
             :config (rv :treesitter)
             :run ":TSUpdate"})
       (local treesitter-plugins
              [[:nvim-treesitter/nvim-treesitter-textobjects
                {:as :treesitter-textobjects}]
               [:mfussenegger/nvim-ts-hint-textobject
                {:as :treesitter-hint-textobject}]
               [:nvim-treesitter/playground
                {:as :treesitter-playground}]
               [:p00f/nvim-ts-rainbow
                {:as :treesitter-rainbow}]
               [:romgrk/nvim-treesitter-context
                {:as :treesitter-context
                 :config (rv :treesitter.context)}]
               [:JoosepAlviste/nvim-ts-context-commentstring
                {:as :treesitter-context-commentstring}]
               [:windwp/nvim-ts-autotag
                {:as :treesitter-autotag}]
               [:RRethy/nvim-treesitter-textsubjects
                {:as :treesitter-textsubjects}]])
       (fn convert-to-treesitter-opt [treesitter-plugin]
         (var opt
              {1 (. treesitter-plugin 1)
               :requires [[:nvim-treesitter/nvim-treesitter]]})
         (set opt
              (vim.tbl_deep_extend :force
                                   (. treesitter-plugin 2)
                                   opt))
         opt)

       (i>== treesitter-plugins
           (||>
             convert-to-treesitter-opt
             use))

       (local cmp-sources
              [:hrsh7th/cmp-nvim-lsp
               :saadparwaiz1/cmp_luasnip
               :hrsh7th/cmp-buffer
               :hrsh7th/cmp-nvim-lua
               :hrsh7th/cmp-path
               :hrsh7th/cmp-calc
               :f3fora/cmp-spell
               :andersevenrud/cmp-tmux
               :hrsh7th/cmp-cmdline
               :hrsh7th/cmp-omni])
       (use {1 :hrsh7th/nvim-cmp
             :requires cmp-sources
             :config (rv :cmp)})

       (fn convert-to-cmp-opt [cmp-source]
         (let [opt {1 cmp-source
                    :requires [[:hrsh7th/nvim-cmp]]
                    :after [:nvim-cmp]}]
           opt))

       (i>== cmp-sources
           (||>
             convert-to-cmp-opt
             use))

       (use {1 :windwp/nvim-autopairs
             :as :autopairs
             :config (rv :autopairs)})
       (use {1 :m-demare/hlargs.nvim
             :as :hlargs
             :config (rv :hlargs)
             :requires [[:nvim-treesitter/nvim-treesitter]]})
       (use {1 :phaazon/hop.nvim
             :as :hop
             :config (rv :hop)
             :disable true})
       (use {1 :ggandor/leap.nvim
             :as :leap
             :config (rv :leap)})
       (use {1 :ggandor/leap-ast.nvim
             :as :leap-ast
             :config (rv :leap.ast)
             :requires [[:ggandor/leap.nvim]]})
       (use {1 :kevinhwang91/nvim-hlslens
             :disable true
             :config (rv :hlslens)})
       (use {1 :kylechui/nvim-surround
             :as :surround
             :config (rv :surround)})
       (use {1 :abecodes/tabout.nvim
             :as :tabout
             :config (rv :tabout)
             :requires [[:nvim-treesitter/nvim-treesitter]]
             :after [:nvim-cmp]})
       (use {1 :ethanholz/nvim-lastplace
             :as :lastplace
             :config (rv :lastplace)})
       (use {1 :sQVe/sort.nvim
             :ad :sort
             :config (rv :sort)})
       (use {1 :numToStr/Navigator.nvim
             :as :navigator
             :config (rv :navigator)})
       (use {1 :akinsho/toggleterm.nvim
             :as :toggleterm
             :config (rv :toggleterm)})
       (use {1 :nvim-neo-tree/neo-tree.nvim
             :as :tree
             :requires [[:nvim-lua/plenary.nvim]
                        [:kyazdani42/nvim-web-devicons]
                        [:MunifTanjim/nui.nvim]]
             :branch :v2.x
             :config (rv :tree)})
       (use {1 :elihunter173/dirbuf.nvim
             :as :dirbuf
             :config (rv :dirbuf)
             :disable true})
       (use {1 :monaqa/dial.nvim
             :config (rv :dial)})
       (use {1 :junegunn/vim-easy-align
             :config (rv :easyalign)})
       (use {1 :TimUntersberger/neogit
             :keys [:<leader>gs]
             :requires [[:nvim-lua/plenary.nvim]]
             :config (rv :neogit)})
       (use {1 :sindrets/diffview.nvim
             :after [:neogit]
             :config (rv :diffview)})
       (use {1 :lewis6991/gitsigns.nvim
             :as :gitsigns
             :requires [[:nvim-lua/plenary.nvim]]
             :config (rv :gitsigns)})
       (use {1 :ThePrimeagen/git-worktree.nvim
             :requires [[:nvim-treesitter/nvim-treesitter]]
             :config (rv :gitworktrees)})
       (use {1 :pwntester/octo.nvim
             :requires [{1 :kyazdani42/nvim-web-devicons
                         :opt true}]
             :config (rv :octo)
             :opt true})
       (use {1 :ruifm/gitlinker.nvim
             :requires [[:nvim-lua/plenary.nvim]]
             :config (rv :gitlinker)})
       (use {1 :numToStr/Comment.nvim
             :as :comments
             :config (rv :comments)})
       (use {1 :folke/todo-comments.nvim
             :requires [[:nvim-lua/plenary.nvim]
                        [:anuvyklack/nvim-keymap-amend]]
             :config (rv :todocomments)})
       (use {1 :kevinhwang91/nvim-ufo
             :as :ufo
             :config (rv :ufo)
             :requires [[:kevinhwang91/promise-async]]})
       (use {1 :bennypowers/nvim-regexplainer
             :as :regexplainer
             :config (rv :regexplainer)})
       (use {1 :jeffkreeftmeijer/vim-numbertoggle})
       (use {1 :jghauser/mkdir.nvim
             :config (rv :mkdir)})
       (use {1 :famiu/bufdelete.nvim
             :config (rv :bufdelete)})
       (use {1 :kwkarlwang/bufresize.nvim
             :config (rv :bufresize)})
       (use {1 :luukvbaal/stabilize.nvim
             :config (rv :stabilize)})
       (use {1 :gbprod/stay-in-place.nvim
             :as :stay
             :config (rv :stay)})
       (use {1 :sindrets/winshift.nvim
             :config (rv :winshift)})
       (use {1 :lewis6991/spellsitter.nvim
             :config (rv :spellsitter)})
       (use {1 :famiu/nvim-reload
             :config (rv :reload)})
       (use {1 :kevinhwang91/nvim-bqf
             :config (rv :betterquickfix)})
       (use {1 "https://gitlab.com/yorickpeterse/nvim-pqf.git"
             :config (rv :prettyquickfix)})
       (use {1 :lukas-reineke/indent-blankline.nvim
             :as :indentline
             :config (rv :indentline)})
       (use {1 :edluffy/specs.nvim
             :as :beacon
             :config (rv :beacon)}))
   :config {:max_jobs 40
            :display {:open_fn (fn []
                                 ((. (require :packer.util)
                                     :float)
                                  {:border :single}))}
            :profile {:threshold 1 :enable true}}})
