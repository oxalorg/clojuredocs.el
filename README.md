# clojuredocs.el

- Search for all functions available on clojuredocs from within emacs
- Open the documentation + examples of a function inside emacs buffer
- Modify and evaluate examples from within the buffer (if clojure repl is available)

Read blog post here: https://oxal.org/blog/clojuredocs-emacs-intgeration-browser-elisp/ 

## Screenshot

On calling `M-x clojuredocs-lookup`

![image](https://github.com/user-attachments/assets/ce60a0cb-9cb3-4786-9ada-c65ea6a0a9e6)

On selecting an entry from the above minibuffer completion:

![image](https://github.com/user-attachments/assets/fc2f92b7-1274-4f6b-aaf3-50d4e1c8ddd5)

BONUS: change and evaluate the examples from this buffer if you are connected to a clojure repl!

## Installation

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

For first time setup run 

```emacs
M-x clojuredocs-download
```

or add this to your config

```elisp
(unless (file-exists-p clojuredocs-cache-file)
  (message "ClojureDocs cache file not found, downloading...")
  (clojuredocs-download))
```

then use `M-x clojuredocs-lookup` or bind it a hotkey.
