# clojuredocs.el

Make sure you have `request` library installed.

This is what I have in my init.el

```elisp
(use-package request)
```

For `elpaca` use:

```elisp
(use-package clojuredocs
  :ensure (clojuredocs
		    :host github
			:repo "oxalorg/clojuredocs.el"))
```

For `straight.el` use

```elisp
(use-package clojuredocs
  :straight (clojuredocs
              :type git
			  :host github
			  :repo "oxalorg/clojuredocs.el"))
```

For first time setup run `clojuredocs-download`, then use `clojuredocs-display-documentation`
