(fn config []
  (let [dk       (require :def-keymaps)
        leap-ast (require :leap-ast)]
    (dk [:n :x :o]
        {:ha [leap-ast.leap "Leap AST"]}
        {:prefix :<leader>})))

{: config}
