" Vim syntax file " Language: Dart
" Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
" for details. All rights reserved. Use of this source code is governed by a
" BSD-style license that can be found in the LICENSE file.

" Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  " we define it here so that included files can test for it
  let main_syntax='dart'
  syn region dartFold start="{" end="}" transparent fold
endif

" Ensure long multiline strings are highlighted.
syn sync fromstart

" keyword definitions
syn keyword dartConditional    if else switch
syn keyword dartRepeat         do while for
syn keyword dartBoolean        true false
syn keyword dartConstant       null
syn keyword dartTypedef        this super class typedef
syn keyword dartOperator       new is as in factory
syn match   dartOperator       "+=\=\|-=\=\|*=\=\|/=\=\|%=\=\|\~/=\=\|<<=\=\|>>=\=\|[<>]=\=\|===\=\|\!==\=\|&=\=\|\^=\=\||=\=\|||\|&&\|\[\]=\=\|=>\|!\|\~\|?\|:"
syn keyword dartType           void var bool int double num dynamic
syn keyword dartStatement      return
syn keyword dartStorageClass   static abstract final const
syn keyword dartExceptions     throw rethrow try on catch finally
syn keyword dartAssert         assert
syn keyword dartClassDecl      extends with implements
syn keyword dartBranch         break continue nextgroup=dartUserLabelRef skipwhite
syn keyword dartKeyword        get set operator call external
syn match   dartUserLabelRef   "\k\+" contained

syn region  dartLabelRegion   transparent matchgroup=dartLabel start="\<case\>" matchgroup=NONE end=":"
syn keyword dartLabel         default

syn match dartLibrary         "^\(import\|part of\|part\|export\|library\|show\|hide\)\s"

" Comments
syn keyword dartTodo          contained TODO FIXME XXX
syn region  dartComment       start="/\*"  end="\*/" contains=dartTodo,dartDocLink,@Spell
syn match   dartLineComment   "//.*" contains=dartTodo,@Spell
syn match   dartLineDocComment "///.*" contains=dartTodo,dartDocLink,@Spell
syn region  dartDocLink       contained start=+\[+ end=+\]+

" Strings
syn region  dartString        start=+\z(["']\)+ end=+\z1+ contains=@Spell,dartInterpolation,dartSpecialChar
syn region  dartRawString     start=+r\z(["']\)+ end=+\z1+ contains=@Spell
syn region  dartMultilineString     start=+\z("\{3\}\|'\{3\}\)+ end=+\z1+ contains=@Spell,dartInterpolation,dartSpecialChar
syn region  dartRawMultilineString     start=+r\z("\{3\}\|'\{3\}\)+ end=+\z1+ contains=@Spell
syn match   dartInterpolation contained "\$\(\w\+\|{[^}]\+}\)"
syn match   dartSpecialChar   contained "\\\(u\x\{4\}\|u{\x\+}\|x\x\x\|x{\x\+}\|.\)"

" Numbers
syn match dartNumber         "\<\d\+\(\.\d\+\)\=\>"

" TODO(antonm): consider conditional highlighting of corelib classes.
syn keyword dartCoreClasses    BidirectionalIterator Comparable DateTime Duration Expando Function Invocation Iterable Iterator List Map Match Object Pattern RegExp RuneIterator Runes Set StackTrace Stopwatch String StringBuffer StringSink Symbol Type
syn keyword dartCoreTypedefs   Comparator
syn keyword dartCoreExceptions AbstractClassInstantiationError ArgumentError AssertionError CastError ConcurrentModificationError Error Exception FallThroughError FormatException IntegerDivisionByZeroException NoSuchMethodError NullThrownError OutOfMemoryError RangeError RuntimeError StackOverflowError StateError TypeError UnimplementedError UnsupportedError


" The default highlighting.
command! -nargs=+ HiLink hi def link <args>
HiLink dartBranch          Conditional
HiLink dartUserLabelRef    dartUserLabel
HiLink dartLabel           Label
HiLink dartUserLabel       Label
HiLink dartConditional     Conditional
HiLink dartRepeat          Repeat
HiLink dartExceptions      Exception
HiLink dartAssert          Statement
HiLink dartStorageClass    StorageClass
HiLink dartClassDecl       dartStorageClass
HiLink dartBoolean         Boolean
HiLink dartString          String
HiLink dartRawString       String
HiLink dartMultilineString String
HiLink dartRawMultilineString String
HiLink dartNumber          Number
HiLink dartStatement       Statement
HiLink dartOperator        Operator
HiLink dartComment         Comment
HiLink dartLineComment     Comment
HiLink dartLineDocComment  Comment
HiLink dartConstant        Constant
HiLink dartTypedef         Typedef
HiLink dartTodo            Todo
HiLink dartKeyword         Keyword
HiLink dartType            Type
HiLink dartInterpolation   PreProc
HiLink dartDocLink         SpecialComment
HiLink dartSpecialChar     SpecialChar
HiLink dartLibrary         Include

HiLink dartCoreClasses     Type
HiLink dartCoreTypedefs    Typedef
HiLink dartCoreExceptions  Exception

delcommand HiLink

let b:current_syntax = "dart"

if main_syntax == 'dart'
  unlet main_syntax
endif

let b:spell_options="contained"

" Enable automatic indentation (2 spaces)
set expandtab
set shiftwidth=2
set softtabstop=2
set cindent
set cinoptions+=j1,J1
