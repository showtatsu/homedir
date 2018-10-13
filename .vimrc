" 
" .vimrc file, show.tatsu / 2017, with vim-plug
" 
"  Download this file to ~/.vimrc, and
"  setup vim-plug with following commands at first.
"
"     $   sed -n 's/^"""" //p' ~/.vimrc | bash
"
" # Setup commands
"""" mkdir -p ~/.vim/autoload
"""" curl -L -o ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"""" vim -c PlugInstall
"

call plug#begin('~/.vim/plugged')

"" Support for Perl 5 and Perl 6 in Vim - https://github.com/vim-perl/vim-perl
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
"" A colorful, dark color scheme for Vim. - https://github.com/nanotech/jellybeans.vim
Plug 'nanotech/jellybeans.vim'
"" fugitive.vim: a Git wrapper so awesome - https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
"" Tools and environment to make Vim superb for developing with Node.js.
"" - https://github.com/moll/vim-node
Plug 'moll/vim-node'
Plug 'posva/vim-vue'
Plug 'rizzatti/dash.vim'

call plug#end()

"" Terminal関連
set ttyfast
""" Terminal.appでvimスクロールが遅い時に設定
""set lazyredraw
set t_Co=256

"" colorschemeには「jellybeans」を使用
"" jellybeansの背景色をblackにするように変数を事前設定
let g:jellybeans_background_color=000000
let g:jellybeans_background_color_256=0
colorscheme jellybeans
""""""" jellybeans関連は以上 """""""""

"" エンコーディングと自動認識
set encoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,sjis
"" 未保存ファイルのbg化許容
set hidden
"" スクロール時の視界確保
set scrolloff=2
"" 空白文字を表示
set list
set listchars=tab:>\
"" 行番号表示
set number

"" 検索:Uc/Lc無視(全て大文字、小文字の場合)
set ignorecase
"" 検索:混在時はUc/Lcを区別
set smartcase
"" 検索:マッチ部分を強調
set hlsearch
"" 表示:カーソル対応の強調
set showmatch
"" 表示:曖昧な幅の文字は全角扱い
set ambiwidth=double
"" インデント =2
set tabstop=2
set shiftwidth=2
"" ソフトタブ使用
set expandtab

"" ステータスバー整形
set cmdheight=1
set showcmd
set laststatus=2
set statusline=[%n]
set statusline+=%<%F
set statusline+=%m
set statusline+=%r
set statusline+=%h
set statusline+=%w
set statusline+=[%{&fileformat}]
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
set statusline+=%y

"" Filetype毎の設定値調整
augroup FileTypeFormater
  autocmd!
  autocmd FileType vue syntax sync fromstart
augroup END

"" syntaxハイライト
syntax   on
filetype plugin on
filetype indent on

" カーソル位置の行番号を強調表示
set cursorline
hi clear CursorLine
hi CursorLineNr ctermfg=Yellow ctermbg=235
" 行番号の背景
hi LineNr ctermbg=235

"" Tab文字の色
"hi SpecialKey ctermbg=233

"" folding set
if has ("viminfo")
  set foldmethod=manual
  set foldopen=all
endif

""""""""" 以下、マクロ等 """"""""""""""""""
" キーストロークの待ち時間を短く
" ESC後の待ち時間短縮上の為だが、組み合わせキーをよく使用する場合は
" 長い方が便利かもしれない。
set timeoutlen=400

"" [TeraTermでの接続時のみ有効化すること]
"" vimの挿入モードからキャンセルするとIMEをOFFにするようにシーケンスを送信する
let &t_SI .= "\e[<r"
let &t_EI .= "\e[<s\e[<0t"
let &t_te .= "\e[<0t\e[<s"

"" ESC2回で:noh(検索強調を取消)
nnoremap <ESC><ESC> :nohlsearch<CR>
"" F2で:set number!(行番号表示をトグル)
nnoremap <F2> :set number!<CR>
"" F3で:set paste!(自動インデントをトグル)
nnoremap <F3> :set paste!<CR>
"" F4で:set list!(空白文字表示をトグル)
nnoremap <F4> :set list!<CR>
"" F5で:e(再読み込み)
nnoremap <F5> :e<CR>
"" Ctrl+Space @InsertMode でomnifunc
inoremap <C-Space> <C-x><C-o>

