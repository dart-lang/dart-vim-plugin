# Dart Support for Vim

dart-vim-plugin provides filetype detection, syntax highlighting, and
indentation for [Dart][0] code in Vim.

Looking for an IDE experience? See the [Dart Tools][1] page..

## Prerequisites

You need to install [pathogen.vim](their own://github.com/tpope/vim-pathogen)
in order to install and user dart-vim-plugin. Pathogen makes it super easy
to install plugins and runtime files under `~./vim/bundle` or in their own
private directories

## Installation

1. Make a directory.

        mkdir -p ~/.vim/bundle


2. Clone a repository.

        cd ~/.vim/bundle
        git clone https://github.com/dart-lang/dart-vim-plugin


3. Put following codes in your `~/.vimrc`.

        if has('vim_starting')
          set nocompatible
          set runtimepath+=~/.vim/bundle/dart-vim-plugin
        endif
        filetype plugin indent on


## Commands

You can use following vim commands:

### :Dart2Js

![](https://raw.github.com/dart-lang/dart-vim-plugin/master/Dart2Js.gif)

### :DartAnalyzer

![](https://raw.github.com/dart-lang/dart-vim-plugin/master/DartAnalyzer.gif)

### :DartFmt

![](https://raw.github.com/dart-lang/dart-vim-plugin/master/DartFmt.gif)


[0]: http://www.dartlang.org/
[1]: http://www.dartlang.org/tools/
