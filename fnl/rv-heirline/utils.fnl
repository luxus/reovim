(let [{: heirline
       : conditions
       : utils
       : colors
       : gps
       : navic
       : luasnip
       : dap
       : icons}
      (require :rv-heirline.common)

      {: Space}
      (require :rv-heirline.components.align)

      ;; Header Bubble
      header-bubble
      (fn [delimiters colours header body]
       (let [left-delim (. delimiters 1)
             middle-delim (. delimiters 2)
             right-delim (or (. delimiters 3)
                             middle-delim)
             colours (if (= (type colour) :function)
                         (colours self)
                         ;; else
                         colours)
             header (vim.tbl_deep_extend "force" header {})
             body   (vim.tbl_deep_extend "force" body   {})]

         [;;  -><-  master 
          {:hl (fn [self]
                 (let [header-bg (. colours :header :bg)]
                   {:fg header-bg}))
           :provider left-delim}
          ;;   -><-  master 
          {:hl (fn [self]
                 (let [header-bg (. colours :header :bg)
                       header-fg (. colours :header :fg)]
                   {:fg header-fg
                    :bg header-bg}))
           1 (unpack [header])}
          ;;   -><-  master 
          {:hl (fn [self]
                 (let [header-bg (. colours :header :bg)
                       body-bg   (. colours :body   :bg)]
                   {:fg header-bg
                    :bg body-bg}))
           :provider middle-delim}
          ;;   -> <- master 
          {:hl (fn [self]
                 (let [body-bg (. colours :body :bg)
                       body-fg (. colours :body :fg)]
                   {:fg body-fg
                    :bg body-bg}))
           1 (unpack [Space])}
          ;;    ->master<-  
          {:hl (fn [self]
                 (let [body-fg (. colours :body :fg)
                       body-bg (. colours :body :bg)]
                   {:fg body-fg
                    :bg body-bg}))
           1 (unpack [body])}
          ;; ;;   master -> <- 
          ;; {:hl (fn [self]
          ;;       (let [body-fg (. colours :body :fg)
          ;;             body-bg (. colours :body :bg)]
          ;;         {:fg body-fg
          ;;          :bg body-bg})}
          ;;  1 (unpack [Space])}
          ;;   master  -><-
          {:hl (fn [self]
                 (let [body-bd (. colours :body :bg)]
                   {:fg body-bd}))
           :provider right-delim}]))]

  {: header-bubble})
