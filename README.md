# Dart Support for Vim

dart-vim-plugin provides filetype detection, syntax highlighting, and
indentation for [Dart][] code in Vim.

Looking for auto-complete, diagnostics as you type, jump to definition and other
intellisense features? Try a vim plugin for the
[Language Server Protocol](http://langserver.org/) such as [vim-lsc][]
configured to start the Dart analysis server with the `--lsp` flag.

Looking for an IDE experience? See the [Dart Tools][] page.

[Dart]: https://dart.dev/
[Dart tools]: https://dart.dev/tools
[vim-lsc]: https://github.com/natebosch/vim-lsc

## Commands

### :DartFmt

![](https://raw.github.com/dart-lang/dart-vim-plugin/master/DartFmt.gif)

## Installation

Install as a typical vim plugin using your favorite approach. If you don't have
a preference [vim-plug][] is a good place to start. Below are examples for
common choices, be sure to read the docs for each option.

### [vim-plug][]

[vim-plug]: https://github.com/junegunn/vim-plug

```vimscript
call plug#begin()
"... <snip other plugins>
Plug 'dart-lang/dart-vim-plugin'

call plug#end()
```

Then invoke `:PlugInstall` to install the plugin.

### [pathogen][]

[pathogen]: https://github.com/tpope/vim-pathogen

Clone the repository into your pathogen directory.

```sh
mkdir -p ~/.vim/bundle && cd ~/.vim/bundle && \
git clone https://github.com/dart-lang/dart-vim-plugin
```

Ensure your `.vimrc` contains the line `execute pathogen#infect()`

### [vundle][]

[vundle]: https://github.com/VundleVim/Vundle.vim

```vimscript
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"... <snip other plugins>
Plugin 'dart-lang/dart-vim-plugin'

call vundle#end()
```

## Configuration

Enable HTML syntax highlighting inside Dart strings with `let
dart_html_in_string=v:true` (default false).

Highlighting for specific syntax groups can be disabled by defining custom
highlight group links. See `:help dart-syntax`

Enable Dart style guide syntax (like 2-space indentation) with
`let g:dart_style_guide = 2`

Enable DartFmt execution on buffer save with `let g:dart_format_on_save = 1`

## FAQ

### Why doesn't the plugin indent identically to `dartfmt`?

The indentation capabilities within vim are limited and it's not easy to fully
express the indentation behavior of `dartfmt`. The major area where this plugin
differs from `dartfmt` is indentation of function arguments when using a
trailing comma in the argument list. When using a trailing comma (as is common
in flutter widget code) `dartfmt` uses 2 space indent for argument parameters.
In all other indentation following an open parenthesis (argument lists without a
trailing comma, multi-line assert statements, etc) `dartmft` uses 4 space
indent. This plugin uses 4 space indent to match the most cases.


### How do I configure an LSP plugin to start the analysis server?

The Dart SDK comes with an analysis server that can be run in LSP mode. The
server ships with the SDK. Assuming the `bin` directory of the SDK is at
`$DART_SDK` the full command to run the analysis server in LSP mode is
`$DART_SDK/dart $DART_SDK/snapshots/analysis_server.dart.snapshot --lsp`. If
you'll be opening files outside of the `rootUri` sent by your LSP client
(usually `cwd`) you may want to pass `onlyAnalyzeProjectsWithOpenFiles: true` in
the `initializationOptions`. See the documentation for your LSP client for how
to configure initialization options. If you are using the [vim-lsc][] plugin
there is an additional plugin which can configure everything for you at
[vim-lsc-dart][]. A minimal config for a good default experience using
[vim-plug][] would look like:

```vimscript
call plug#begin()
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
call plug#end()

let g:lsc_auto_map = v:true
```

[vim-lsc-dart]: https://github.com/natebosch/vim-lsc-dart
