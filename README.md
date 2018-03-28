# Dart Support for Vim

dart-vim-plugin provides filetype detection, syntax highlighting, and
indentation for [Dart][] code in Vim.

Looking for auto-complete, diagnostics as you type, jump to definition and other
intellisense features? Try [dart_language_server][] and a vim plugin for the
[Language Server Protocol](http://langserver.org/) such as [vim-lsc][].

Looking for an IDE experience? See the [Dart Tools][] page.

[Dart]: http://www.dartlang.org/
[Dart tools]: http://www.dartlang.org/tools/
[dart_language_server]: https://pub.dartlang.org/packages/dart_language_server
[vim-lsc]: https://github.com/natebosch/vim-lsc

## Commands

You can use following vim commands:

### :Dart2Js

![](https://raw.github.com/dart-lang/dart-vim-plugin/master/Dart2Js.gif)

### :DartAnalyzer

![](https://raw.github.com/dart-lang/dart-vim-plugin/master/DartAnalyzer.gif)

### :DartFmt

![](https://raw.github.com/dart-lang/dart-vim-plugin/master/DartFmt.gif)

## Installation

Install as a typical vim plugin using your favorite approach. If you don't have
a preference [vim-plug][] is a good place to start. Below are examples for
common choices, be sure to read the docs for each option.

### [vim-plug][]

[vim-plug]:https://github.com/junegunn/vim-plug

```vimscript
call plug#begin()
"... <snip other plugins>
Plug 'dart-lang/dart-vim-plugin'

call plug#end()
```

Then invoke `:PlugInstall` to install the plugin.

### [pathogen][]

[pathogen]:https://github.com/tpope/vim-pathogen

Clone the repository into your pathogen directory.

```sh
mkdir -p ~/.vim/bundle && cd ~/.vim/bundle && \
git clone https://github.com/dart-lang/dart-vim-plugin
```

Ensure your `.vimrc` contains the line `execute pathogen#infect()`

### [vundle][]

[vundle]:https://github.com/VundleVim/Vundle.vim

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

Disable highlighting of core library classes with `let
dart_corelib_highlight=v:false` (default true).

Enable Dart style guide syntax (like 2-space indentation) with `let dart_style_guide = 2`

Enable DartFmt execution on buffer save with `let dart_format_on_save = 1`
