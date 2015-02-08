# Dart Support for Vim

dart-vim-plugin provides filytype detection, syntax highlighting, and
indentation for [Dart](https://dartlang.org/) code in Vim.

Looking for an IDE experience? Try [Dart Editor][1],
[Dart plugin for Eclipse][2], or [Dart plugin for IntelliJ/WebStorm][3].

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

[1]: http://www.dartlang.org/editor
[2]: http://news.dartlang.org/2012/08/dart-plugin-for-eclipse-is-ready-for.html
[3]: http://plugins.intellij.net/plugin/?id=6351

