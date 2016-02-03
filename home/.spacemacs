;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.
;;
;; References:
;; - https://github.com/syl20bnr/spacemacs
;; - http://www.clauswitt.com/a-walkthrough-of-my-space>

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; auto-completion
     ;; better-defaults
     emacs-lisp
     ;; git
     ;; markdown
     ;; org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     ;; --------------------------------------------------------
     ;; --------------------------------------------------------
     ;; auto-completion
     ;;
     ;; This layer provides auto-completion to Spacemacs.
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/auto-completion
     auto-completion
     ;; better-defaults
     ;;
     ;; This layer enhances the default commands of Emacs and is primarily
     ;; intended to be used with the emacs editing style as it does not change
     ;; anything in the Vim key bindings.
     ;;
     ;; However the emacs editing style is not required, you can still use this
     ;; layer while you are using the vim editing style if you have some kind
     ;; of mixed style.
     ;;
     ;; The commands defined in this layer are taken from various sources like
     ;; Prelude.
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/better-defaults
     better-defaults
     ;; c-c++
     ;;
     ;; This layer adds configuration for C/C++ language as well support for
     ;; CMake scripts.
     ;;
     ;; Features:
     ;; - Support syntax checking via flycheck with Clang.
     ;; - Support code reformatting with clang-format.
     ;; - Display function or variable definition at the bottom. (when semantic
     ;;   layer is included)
     ;; - Display current function cursor is in at the top. See
     ;;   stickyfunc-demos for demos in some programming languages. (when
     ;;   semantic layer is included)
     ;; - Support common refactoring with semantic-refactor . See
     ;;   srefactor-demos for demonstration of refactoring features. (when
     ;;   semantic layer is included)
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!lang/c-c++
     c-c++
     ;; git
     ;;
     ;; This layers adds extensive support for git.
     ;;
     ;; Features:
     ;; - git repository management the indispensable magit package
     ;; - git-flow add-on for magit.
     ;; - quick in buffer history browsing with git-timemachine.
     ;; - quick in buffer last commit message per line with git-messenger
     ;; - colorize buffer line by age of commit with smeargle
     ;; - gitignore generator with helm-gitignore
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!source-control/git
     ;; http://magit.vc/
     git
     ;; github
     ;;
     ;; This layers adds support for Github.
     ;;
     ;; Features:
     ;; - magit-gh-pulls: handy magit add-on to manage Github pull requests.
     ;; - gist.el: full-featured mode to browse and post Github gists.
     ;; - github-browse-file and git-link: quickly browse github URL in your
     ;;   browser.
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!source-control/github
     github
     ;; go
     ;;
     ;; This layer adds extensive support for go.
     ;;
     ;; Features:
     ;; - gofmt on file save
     ;; - Auto-completion using go-autocomplete
     ;; - Source analysis using go-oracle
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!lang/go
     go
     ;; html
     ;;
     ;; This layer adds support for editing HTML and CSS.
     ;; Features:
     ;; - Editing HTML and CSS file using web-mode
     ;; - Support for Sass/Scss and Less files
     ;; - Generate HTML and CSS coding using emmet-mode
     ;; - Tags navigation on key % using evil-matchit
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!lang/html
     html
     ;; javascript
     ;;
     ;; This layer adds support for the JavaScript language using js2-mode.
     ;;
     ;; Features:
     ;; - Smart code folding
     ;; - Refactoring: done using js2-refactor.
     ;; - Auto-completion and documentation: provided by tern
     ;; - CoffeeScript support
     ;; - Formatting with web-beautify
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!lang/javascript
     javascript
     ;; markdown
     ;;
     ;; This layer adds markdown support to Spacemacs.
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!lang/markdown
     markdown
     ;; org
     ;;
     ;; This layer enables org mode for Spacemacs.
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/org
     org
     ;; osx
     ;;
     ;; The recommend mac port of emacs, emacs-mac-port, has slightly
     ;; different key handling than traditional emacs. The osx configuration
     ;; layer corrects this. More information:
     ;;
     ;; https://github.com/syl20bnr/spacemacs#os-x
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/osx
     osx
     ;; python
     ;;
     ;; This layer adds support for the Python language.
     ;;
     ;; Features:
     ;; - Auto-completion using anaconda-mode
     ;; - Code Navigation using anaconda-mode
     ;; - Documentation Lookup using anaconda-mode and pylookup
     ;; - Test Runners using nose.el or pytest
     ;; - Virtual Environment using pyvenv and pyenv
     ;; - semantic mode is enabled
     ;; - Django support via pony-mode
     ;; - PEP8 compliant formatting via YAPF
     ;; - Suppression of unused import with autoflake
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!lang/python
     python
     ;; ruby
     ;;
     ;; This layer aims at providing support for the Ruby language using
     ;; enh-ruby-mode and robe-mode.
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!lang/ruby
     ruby
     ;; shell
     ;;
     ;; This layer configures the various shells available in Emacs.
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/shell
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     ;; syntax-checking
     ;;
     ;; This layer provides on the fly syntax and spelling checking using
     ;; Flycheck and Flyspell.
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/syntax-checking
     syntax-checking
     ;; themes-megapack
     ;;
     ;; This simple contribution layer is an example. It installs around 100
     ;; themes for Emacs. You can try them easily by invoking helm-themes with:
     ;; <SPC> T h.
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/themes-megapack
     themes-megapack
     ;; version-control
     ;;
     ;; This layers adds general configuration for Emacs VC. It should work
     ;; with all VC backends such as Git, Mercurial, Bazaar, SVN, etc…
     ;;
     ;; Features:
     ;; - Highlights uncommitted changes in the fringe or margin with
     ;;   diff-hl (git-gutter alternative)
     ;;
     ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!source-control/version-control
     ;; https://github.com/dgutov/diff-hl
     version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         seti
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ;; -----------------------------------------------------------------------
   ;; User Defaults
   ;; -----------------------------------------------------------------------
   ;; ruby-enable-ruby-on-rails-support
   ;;
   ;; From the ruby configuration layer.
   ;;
   ;; Rails support is available through projectile-rails. This will also add
   ;; haml-mode (for templates written in haml language and feature-mode for
   ;; Cucumber support.
   ;;
   ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!lang/ruby#rails-support
   ruby-enable-ruby-on-rails-support t
   ;; ruby-version-manager
   ;;
   ;; From the ruby configuration layer.
   ;;
   ;; Possible values are rbenv and rvm.
   ;;
   ;; https://github.com/syl20bnr/spacemacs/tree/master/contrib/!lang/ruby#ruby-version-management
   ruby-version-manager 'rbenv
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put almost
any user code here.  The exception is org related code, which should be placed
in `dotspacemacs/user-config'."
   ;; Enable mouse support
   ;;
   ;; Source:
   ;;   http://stackoverflow.com/a/8859057
   ;;
   ;; Alternative:
   ;;   (global-set-key [mouse-4] 'scroll-down-line)
   ;;   (global-set-key [mouse-5] 'scroll-up-line)
   ;;
   ;; More information:
   ;;   https://github.com/syl20bnr/spacemacs/issues/4591
   (unless window-system
     (require 'mouse)
     (xterm-mouse-mode t)
     (global-set-key [mouse-4] (lambda ()
                                 (interactive)
                                 (scroll-down 1)))
     (global-set-key [mouse-5] (lambda ()
                                 (interactive)
                                 (scroll-up 1)))
     (defun track-mouse (e))
     (setq mouse-sel-mode t)
   )
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
