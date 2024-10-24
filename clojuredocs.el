;;; clojuredocs.el --- ClojureDocs browser for emacs -*- lexical-binding: t -*-

(require 'json)
(require 'request)

(defvar clojuredocs-cache-file "~/.clojuredocs-cache.json"
  "Location to store the downloaded ClojureDocs JSON file.")

(defun clojuredocs-download ()
  "Download the ClojureDocs JSON and save it to a local cache file."
  (interactive)
  (request
    "https://clojuredocs.org/clojuredocs-export.json"
    :type "GET"
    :parser 'json-read
    :success (cl-function
              (lambda (&key data &allow-other-keys)
		(with-temp-file clojuredocs-cache-file
		  (prin1 data (current-buffer)))
		(message "ClojureDocs JSON downloaded and saved!")))
    :error (cl-function
            (lambda (&key error-thrown &allow-other-keys)
              (message "Error: %S" error-thrown)))))

(defun clojuredocs-read-cache ()
  "Read the cached ClojureDocs JSON."
  (with-temp-buffer
    (insert-file-contents clojuredocs-cache-file)
    (read (current-buffer))))

(defun clojuredocs-lookup ()
  "Lookup a Clojure function and open its documentation in a new buffer."
  (interactive)
  (let* ((clojuredocs-data (clojuredocs-read-cache))
         (vars (alist-get 'vars clojuredocs-data))
         (href-list (mapcar (lambda (fn-doc) (alist-get 'href fn-doc)) vars))
         (selected-href (completing-read "Select function: " href-list)))
    (clojuredocs-display-documentation selected-href vars)))

(defun clojuredocs-display-documentation (href fn-docs)
  "Display the documentation and examples for the function identified by HREF."
  (let* ((fn-doc (seq-find (lambda (doc) (string= (alist-get 'href doc) href)) fn-docs))
         (doc (alist-get 'doc fn-doc))
         (examples (alist-get 'examples fn-doc)))
    (with-current-buffer (get-buffer-create "*ClojureDocs*")
      (erase-buffer)
      (insert (format "Function: %s\n\n" href))
      (insert (format "Documentation:\n%s\n\n" doc))
      (insert "Examples:\n")
      (dolist (example examples)
        (insert (format "- %s\n\n" (alist-get 'body example))))
      (when (fboundp 'clojure-mode)
        (clojure-mode))
      (goto-char (point-min))
      (pop-to-buffer (current-buffer)))))

(provide 'clojuredocs)

;;; clojuredocs.el ends here
