
"------------------------------------------------------------------------------- wxw added
"-------------------------------------------------------------------------------
"keymappings
"set winaltkeys=no
imap <C-k> <Esc>ld$kpa
imap <A-[> <Esc>
imap <A-n> <C-n>
imap <A-p> <C-p>
imap <A-r> <Esc>S
imap <A-u> <Esc>ld0i
imap <A-d> <Esc>ld$a
imap <A-w> <Esc>lcaw
imap <A-b> <Esc>caw
imap <A-s> <Esc>lci"
imap <A-o> <Esc>o
imap <A-i> <Esc>O
imap <A-c> <Esc>ly$i
imap <A-v> <Esc>pi
nmap <A-c> y$
nmap <A-v> p
imap <A-e> <Esc>$a
imap <A-j> <Down>
imap <A-k> <Up>
imap <A-h> <left>
imap <A-l> <Right>
""""""""""""""""""""""""""""""
" helptags
""""""""""""""""""""""""""""""
set helplang=cn
helptags ~/.vim/doc

"added by 2010/9/11
set fileencoding=utf-8
set fileencodings=utf-8,gb18030,ucs-bom,gbk,gb2312,cp936
set encoding=utf8

""""""""""""""""""""""""""""""
" minibufexplorer.vim
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget=0
let g:miniBufExplorerMoreThanOne=2
let g:miniBufExplModSelTarget=1
let g:miniBufExplUseSingleClick=1
"let g:miniBufExplDefaultHelp=0
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplorerAutoUpdate=0
let g:bufExplorerSortBy="name"
autocmd BufRead,BufNew :call UMiniBufExplorer
let g:miniBufExplMapWindowNavArrows=1
"let g:miniBufExplVSplit=25
"let g:miniBufExplSplitBelow=1

noremap <silent>,b :TMiniBufExplorer<cr>

"map <right> <ESC>:MBEbn<RETURN>
"map <left> <ESC>:MBEbp<RETURN>
" Fast switch buffer
"
"nn <C-.> :bn<cr>
"nn <C-,> :bp<cr>

""""""""""""""""""""""""""""""
" tab switch
""""""""""""""""""""""""""""""
" function! TabPos_ActivateBuffer(num)  
" 	let s:count = a:num   
" 	exe "tabfirst"  
" 	exe "tabnext" s:count    
" endfunction  
"   
" function! TabPos_Initialize()  
" 	for i in range(1, 9)   
" 		exe "map <M-" . i . "> :call TabPos_ActivateBuffer(" . i . ")<cr>"  
" 	endfor  
" 	exe "map <M-0> :call TabPos_ActivateBuffer(10)<cr>"  
" endfunction  
"   
" autocmd VimEnter * :call TabPos_Initialize()

nn <M-1> 1gt
nn <M-2> 2gt
nn <M-3> 3gt
nn <M-4> 4gt
nn <M-5> 5gt
nn <M-6> 6gt
nn <M-7> 7gt
nn <M-8> 8gt
nn <M-9> 9gt
nn <M-0> :tablast<CR>

ino <M-1> <C-o>1gt
ino <M-2> <C-o>2gt
ino <M-3> <C-o>3gt
ino <M-4> <C-o>4gt
ino <M-5> <C-o>5gt
ino <M-6> <C-o>6gt
ino <M-7> <C-o>7gt
ino <M-8> <C-o>8gt
ino <M-9> <C-o>9gt
ino <M-0> <C-o>:tablast<CR>

""""""""""""""""""""""""""""""

" a.vim
""""""""""""""""""""""""""""""
nnoremap <silent><F6> : A<cr>


""""""""""""""""""""""""""""""
" grep.vim
""""""""""""""""""""""""""""""
nnoremap <silent>,g :Grep<cr>
"map <leader>g :Grep<cr>


""""""""""""""""""""""""""""""
"
" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
""""""""""""""""""""""""""""""
filetype plugin indent on
set completeopt=longest,menu

let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_DefaultNamespaces = ["std"]     "逗号分割的字符串
let OmniCpp_MayCompleteScope = 1
let OmniCpp_ShowPrototypeInAbbr = 0
let OmniCpp_SelectFirstItem = 2

"c-j自动补全，当补全菜单打开时，c-j,k上下选择
imap <expr> <c-n>      pumvisible()?"\<C-N>":"\<C-X><C-O>"
imap <expr> <c-p>      pumvisible()?"\<C-P>":"\<esc>"


" " f:文件名补全，l:行补全，d:字典补全，]:tag补全
imap <C-]>             <C-X><C-]>
imap <C-F>             <C-X><C-F>
imap <C-D>             <C-X><C-D>
imap <C-L>             <C-X><C-L>

""""""""""""""""""""""""""""""
" visualmark.vim
""""""""""""""""""""""""""""""
"<F2> to preview mark
"<F3> to next mark

""""""""""""""""""""""""""""""
" markbrowser setting
""""""""""""""""""""""""""""""
noremap <silent>,l :MarksBrowser<cr>
"""""""""""""""""""""""""""""""
" showmarks setting
""""""""""""""""""""""""""""""
" Enable ShowMarks
let showmarks_enable = 1
" Show which marks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1 
""""""""""""""""""""""""""""""
" mark setting
""""""""""""""""""""""""""""""
"
"    nmap <Leader>M <Plug>MarkToggle
"    nmap <Leader>N <Plug>MarkAllClear
"
""To remove the default overriding of * and #, use:
"    nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
"    nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
 

" For mark plugin
" hi MarkWord1  ctermbg=Cyan     ctermfg=Black  guibg=#8CCBEA    guifg=Black
" hi MarkWord2  ctermbg=Green    ctermfg=Black  guibg=#A4E57E    guifg=Black
" hi MarkWord3  ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
" hi MarkWord4  ctermbg=Red      ctermfg=Black  guibg=#FF7272    guifg=Black
" hi MarkWord5  ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black
" hi MarkWord6  ctermbg=Blue     ctermfg=Black  guibg=#9999FF    guifg=Black 

""""""""""""""""""""""""""""""
"  quickfix
""""""""""""""""""""""""""""""
"nmap<F3> :cp<cr>
"nmap<F4> :cn<cr>


""""""""""""""""""""""""""""""
"  vim gui configuration
""""""""""""""""""""""""""""""
if has("gui_running")
	winpos 800 0
	set lines=85 columns=105
	set go-=m "no menu
	set go-=T "no tools

"no scroll bar
	set go-=l
	set go-=L
	set go-=r
	set go-=R
endif


function! MaximizeWindow()
	silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction

"colorscheme evening
"colorscheme delek
"colorscheme desert
"colorscheme peachpuff
"colorscheme oceandeep
colorscheme molokai
"let g:molokai_original = 1


""""""""""""""""""""""""""""""""""""""
"key-binding for hjkl in insert mode
""""""""""""""""""""""""""""""""""""""
"noremap! <M-j> <Down>
"noremap! <M-k> <Up>
"noremap! <M-h> <left>
"noremap! <M-l> <Right>



""""""""""""""""""""""""""""""""""""""
"yankring.vim
""""""""""""""""""""""""""""""""""""""
noremap <silent>,y :YRShow<cr>
"map <leader>y:YRShow<cr>

""""""""""""""""""""""""""""""""""""""
"surround.vim
""""""""""""""""""""""""""""""""""""""
" {{{ plugin - surround.vim 快速替换、清除包围符号、标签
"  Old text                  Command     New text ~
"  "Hello *world!"           ds"         Hello world!
"  [123+4*56]/2              cs])        (123+456)/2
"  "Look ma, I'm *HTML!"     cs"<q>      <q>Look ma, I'm HTML!</q>
"  if *x>3 {                 ysW(        if ( x>3 ) {
"  my $str = *whee!;         vlllls'     my $str = 'whee!';
"  "Hello *world!"           ds"         Hello world!
"  (123+456)/2              ds)         123+456/2
"  <div>Yo!*</div>           dst         Yo!
"  Hello w*orld!             ysiw)       Hello (world)!
" }}}

""""""""""""""""""""""""""""""
" mapleader func
""""""""""""""""""""""""""""""

let mapleader=","
let g:mapleader=","

"Fast saving
nmap <leader>w :w!<cr>
"Fast editing of the .vimrc
map <leader>ee :e! ~/.vimrc<cr>
"Fast quit for editing file
nmap <leader>q :q<cr>
nmap <leader>aa :qa<cr>
nmap <leader>! :q!<cr>
"Fast enter shell
nmap <leader>sh :shell<cr>
"Fast open Tlist
nmap <silent> <leader>t :TlistToggle<cr>
nmap <silent> <leader>sp :sp<cr>
nmap <silent> <leader>vs :vs<cr>
map  <silent> <leader>cq :cclose<cr>

imap <leader>p <Esc>"*p
map  <leader>p "*p

imap <leader>= <Esc>"+p
map  <leader>= "+p

imap <leader>- <Esc>"+y
map  <leader>- "+y

"Fastmaping mapping
inoremap <leader>1 ()<esc>:let leavechar=")"<cr>i
inoremap <leader>2 []<esc>:let leavechar="]"<cr>i
inoremap <leader>3 {}<esc>:let leavechar="}"<cr>i
inoremap <leader>4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap <leader>5 [[]]<esc>h:let leavechar="]"<cr>i
inoremap <leader>6 {{{<esc>o}}}<esc>:let leavechar="}"<cr>O
inoremap <leader>" ""<esc>:let leavechar="""<cr>i
inoremap <leader>' ''<esc>:let leavechar="'"<cr>i
inoremap <leader>, <><esc>:let leavechar=">"<cr>i
inoremap <leader>. -><esc>:let leavechar=">"<cr>a
inoremap <leader>< << <esc>:let leavechar=" "<cr>a
inoremap <leader>> >> <esc>:let leavechar=" "<cr>a
inoremap <leader>: :: <esc>:let leavechar=" "<cr>a
inoremap <leader>= != <esc>:let leavechar=" "<cr>a

""""""""""""""""""""""""""""""

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source $HOME/.vimrc
set autoread "when editing object is changed outside, auto read it

" recover from last file position
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

""""""""""""""""""""""""""""""
" Bash(Emacs)
imap <C-e> <END>
imap <C-a> <HOME>


""""""""""""""""""""""""""""""
"MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<cr>

""""""""""""""""""""""""""""""
"neocomplcache
""""""""""""""""""""""""""""""
"Setting examples:
" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
" Use neocomplcache.

let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Expand the keyword width
let g:neocomplcache_max_keyword_width = 15
" Expand the filename width
let g:neocomplcache_max_filename_width = 255
let g:neocomplcache_max_list = 10
" When neocomplcache displays candidates, this option controls whether neocomplcache selects the first candidate automatically.  If you enable this option, neocomplcache's completion behaivior is like |AutoComplPop|.
" Recommended key-mappings.
" <cr>: close popup and save indent.

inoremap <expr><cr>  (pumvisible() ? "\<C-y>":'') . "\<C-f>\<cr>X\<BS>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()



""""""""""""""""""""""""""""""""""""""""
" vimwiki configuration
""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_use_mouse=1
let g:vimwiki_camel_case=0
let g:vimwiki_CJK_length=1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_menu = ''

let tlist_vimwiki_settings = 'wiki;h:Headers'

let g:vimwiki_list=[{'path':'~/note/vimwiki/',
\ 'path_html':'~/note/vimwiki/html/',
\ 'html_header':'~/note/vimwiki/template/header.tpl',}]

""""""""""""""""""""F12 to call Do_CsTag()""""""""""""""""""""
"autocmd BufEnter * cd %:p:h "the same with autochdir
""""""""""""""""""""F12 to call Do_CsTag()""""""""""""""""""""
map <F12> :call Do_CsTag()<cr>
function! Do_CsTag()
    let dir = getcwd()

    "先删除已有的tags和cscope文件，如果存在且无法删除，则报错。
    if ( DeleteFile(dir, "tags") )
        return
    endif
    if ( DeleteFile(dir, "cscope.files") )
        return
    endif
    if ( DeleteFile(dir, "cscope.out") )
        return
    endif
    if ( DeleteFile(dir, "cscope.in.out") )
        return
    endif
    if ( DeleteFile(dir, "cscope.po.out") )
        return
    endif

    if(executable('ctags'))
		"silent! execute "!ctags -I __THROW --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+lS -R -f ."
		silent! execute "!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q ."
		silent! execute "set tags=./tags;"
    endif

   if(executable('cscope') && has("cscope") )
	   silent! execute "!find . -name '*.[ch]' -o -name '*.cpp' > cscope.files"
	   silent! execute "!cscope -b"
	   execute "normal :"
	   if filereadable("cscope.out")
		   execute "cs add cscope.out"
	   endif
   endif
    " 刷新屏幕
    execute "redr!"
endfunction

function! DeleteFile(dir, filename)
    if filereadable(a:filename)
        let ret = delete("./".a:filename)
        if (ret != 0)
            echohl WarningMsg | echo "Failed to delete ".a:filename | echohl None
            return 1
        else
            return 0
        endif
    endif
    return 0
endfunction

"-------------------------------------------------------------------------------
" Various settings
"-------------------------------------------------------------------------------
syntax on
syntax enable
filetype plugin indent on
set statusline=\ %r%{CurDir()}%h\ \ %f[%1*%m%*%n%r%h]%=\ %c:%l/%L

function! CurDir()
	let CurDir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return CurDir
endfunction

"set guifont=XHei\ for\ Powerline\ Mono\ 11.5
set guifont=XHei\ Mono\ 11.5
set tabstop=4
set cindent shiftwidth=4
set autoindent shiftwidth=4
"set number						" display the number of line
"map <leader>n :set number<cr>
"set mouse=v                     " enable the use of the mouse
set selection=exclusive
set selectmode=mouse,key
let c_space_errors=1			" very usefull for program, highlight spilith space
set incsearch                   " do incremental searching
set autoindent                  " copy indent from current line
set autoread                    " read open files again when changed outside Vim
set noautochdir
set autowrite                   " write a modified buffer on each :next , ...
set history=50                  " keep 50 lines of command line history
"set hlsearch                    " highlight the last used search pattern
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions
set wildmenu                    " command-line completion in an enhanced mode
set nobk						" no bak file (x~)
set showcmd
set cursorline

set nobackup		" do not keep a backup file, use versions instead
"""""""""""""""""""""""""""""""added by wxw
  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80
"""""""""""""""""""""""""""""""added by wxw
"""""""""""""""""""""""""""""""added by wxw
set magic "Set magic on, for regular expressions
set backspace=indent,eol,start  " backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,]      "added by wxw
set smartindent
"set wrap "Wrap lines
set cmdheight=1 "The commandbar heigh
set laststatus=2 "always show commandbar
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
set nocompatible
filetype on
set showmatch
set ruler
set vb t_vb=
set hlsearch
set si
set si
set smartcase
"set ignorecase "ignore case when searching
"set paste  粘贴时有用
"set nopaste
"
"-------------------------------------------------------------------------------
" fold setting
set foldmethod=syntax       " 设置语法折叠
set foldcolumn=1            " 设置折叠区域的宽度
set foldlevel=100		" Don't autofold
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

:highlight Folded  term=standout ctermbg=8 guifg=SlateBlue guibg=black
":highlight FoldColumn  term=standout ctermbg=8 guifg=SlateBlue guibg=black

"-------------------------------------------------------------------------------
"compile(,m) and run(,f)
"-------------------------------------------------------------------------------
" make setting
au FileType c set makeprg=gcc\ -Wall\ -g\ %\ -o\ %<
au FileType cpp set makeprg=g++\ -Wall\ -g\ %\ -o\ %<

map   <silent> <F9> :make<cr>
imap <F9> <Esc><F9>

"map <leader>p :!g++ % -o %<<cr>
map   <silent> <F10> :!./%:r<cr>

"--------------------------------------------------
"command_t
"--------------------------------------------------
function! PROJECT_DIR_FUNCTION()
if "uboot-mx-rtm"==matchstr(getcwd(), "uboot-mx-rtm")
	silent! execute "cd /work/m30/uboot-mx-rtm"
elseif "uboot-mx"==matchstr(getcwd(), "uboot-mx")
	silent! execute "cd /work/m30/uboot-mx"
elseif "uboot-1.3.4-m9_v4"==matchstr(getcwd(), "uboot-1.3.4-m9_v4")
	silent! execute "cd /meizu/svn_src/bootloader/uboot-1.3.4-m9_v4"
elseif "uboot-mxse"==matchstr(getcwd(), "uboot-mxse")
	silent! execute "cd /work/m32/uboot-mxse"
elseif "uboot-mx-m040"==matchstr(getcwd(), "uboot-mx-m040")
	silent! execute "cd /work/m40/uboot-mx-m040"
elseif "linux-3.0.39-rtm-mp-dev"==matchstr(getcwd(), "linux-3.0.39-rtm-mp-dev")
	silent! execute "cd /work/m40/linux-3.0.39-rtm-mp-dev"
elseif "linux-3.0.39-rtm-mp-dev"==matchstr(getcwd(), "linux-3.0.39-rtm-mp-dev")
	silent! execute "cd /work/m40/linux-3.0.39-rtm-mp-dev"
endif
endfunction

map  <silent> <F5> :call PROJECT_DIR_FUNCTION()<CR>:CommandT<CR>
imap <F5> <Esc><F5> :call PROJECT_DIR_FUNCTION()<CR>:CommandT<CR>
map  <silent> <leader>cf :call PROJECT_DIR_FUNCTION()<CR>:CommandT<CR>

"-------------------------------------------------------------------------------
"winmanager setting
"-------------------------------------------------------------------------------
"
"let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWindowLayout='FileExplorer'
let g:winManagerWidth=30
nmap wm :WMToggle<cr>
"-------------------------------------------------------------------------------

"taglist setting
"-------------------------------------------------------------------------------
"
" ctags and cscope
"-------------------------------------------------------------------------------
"let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Left_Window = 1

"set tags=~/.vim/tags/libc.tags
"set tags+=~/.vim/tags/glib.tags
set tags=./tags,./../tags,./../../tags,./../../../tags,./../../../../tags
"set tags+=~/.vim/tags/sys.tags
"set tags+=~/.vim/tags/susv2.tags

"set tags+=/home/xiaowu/.vim/tags/cpp
"set tags+=/home/xiaowu/.vim/tags/sys.tags
"set tags+=/home/xiaowu/.vim/tags/tags
"!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."

au BufWritePost *.c,*.cpp,*.cxx,*.cc,*.h "!ctags -I __THROW --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+lS -R -f ."

if has("cscope")
	set csto=1
	set cst
	set nocsverb
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	set cscopetag
	set csverb
	set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f-
	nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
	nmap <leader>si :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>

	" s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
	" g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
	" d: 查找本函数调用的函数
	" c: 查找调用本函数的函数
	" t: 查找指定的字符串
	" e: 查找egrep模式，相当于egrep功能，但查找速度快多了
	" f: 查找并打开文件，类似vim的find功能
	" i: 查找包含本文件的文件

endif
"
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis
"-------------------------------------------------------------------------------
"misc setting
"-------------------------------------------------------------------------------
map   <silent> <F2>      :copen<CR>

"
"-------------------------------------------------------------------------------
"""""""""""""""""""""""""""""""""""""""""""""""""""
"		authorinfo.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimrc_author='Wang Xiaowu'
let g:vimrc_email='hellowxwworld@gmail.com'
let g:vimrc_homepage='hellowxwworld@gmail.com'

nmap <leader>ha :AuthorInfoDetect<cr>

"added by wxw Jan, 10th, 2011
"进行版权声明的设置
"添加或更新头
" nmap <leader>h ms:call TitleDet()<cr>'s
" "map <F7> ms:call TitleDet()<cr>'s
" function AddTitle()
"         "call append(0,"####################################################")
"         call append(0,"/*")
"         call append(1," * Filename: ".expand("%:t"))
"         call append(2," * Description:")
"         call append(3," * Author: xiaowu, hellowxwworld@gmail.com")
"         call append(4," * Last modified: ".strftime("%Y-%m-%d %H:%M"))
"         call append(5," */")
"         "call append(5,"####################################################")
"         "echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
" endf
" "更新最近修改时间和文件名
" function UpdateTitle()
"         normal m'
"         execute '/# *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
"         normal ''
"         normal mk
"         execute '/# *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
"         execute "noh"
"         normal 'k
"         echohl WarningMsg | echo "Successful in updating the copy right." | echohl N
"
" endfunction
" "判断前10行代码里面，是否有Last modified这个单词，
" "如果没有的话，代表没有添加过作者信息，需要新添加；
" "如果有的话，那么只需要更新即可
" function TitleDet()
"         let n=1
"         "默认为添加
"         while n < 10
"                 let line = getline(n)
"                 if line =~ '^\#\s*\S*Last\smodified:\S*.*$'
"                         call UpdateTitle()
"                         return
"                 endif
"                 let n = n + 1
"         endwhile
"         call AddTitle()
" endfunction

""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"all below put in the .vim/syntax/tex.vim
""""""""""""""""""""""""""""""
""latex editor
"""
let g:tex_flavor="latex"

""" 在Tex文档中根据section,subsection设置折叠
""let g:tex_fold_enabled=1
""set fdm=syntax

"let g:tex_conceal= 'admgs'
"hi Conceal guifg=DarkMagenta guibg=#202020

set grepprg=grep\ -nH\ $*
"" 编译Latex
"map <silent> <buffer> ,r :call Tex()<cr>
"function! Tex()
    "w
    "!latex %
    "silent !dvipdfmx  %:r
    "silent ! start %:r.pdf
"endfunction</cr>
""""""""""""""""""""""""""""""
"all above put in the .vim/syntax/tex.vim
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""
" vimdiff
""""""""""""""""""""""""""""""""""""""""""""""""""
" @see http://vim.wikia.com/wiki/Selecting_changes_in_diff_mode
if &diff
    let g:origCursorPos=getpos('.')
    autocmd WinEnter * :call setpos('.', g:origCursorPos)
    autocmd WinLeave * :let g:origCursorPos=getpos('.')
    nmap <F7> [c
    nmap <F8> ]c
else
    map <F7> :cp<cr>
    map <F8> :cn<cr>
endif

" Remove trailing whitespace when writing a buffer, but not for diff files.
" From: Vigil
" @see http://blog.bs2.to/post/EdwardLee/17961
function RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
"autocmd BufWritePre * call RemoveTrailingWhitespace()
nmap <leader>rs :call RemoveTrailingWhitespace()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" doxygentoolkit.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:doxygenToolkit_authorName="Wang Xiaowu"
let g:doxygenToolkit_briefTag_funcName="yes"
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns"
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_licenseTag="My own license" "<-- !!! Does not end with \<enter>

map <leader>da :DoxAuthor<cr>
map <leader>df :Dox<cr>
map <leader>db :DoxBlock<cr>
map <leader>dc O/** */<Left><Left>

""""""""""""""""""""""""""""""""""""""""""""""""""
"			cmdline-complete.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
cmap <A-p> <Plug>CmdlineCompleteBackward
cmap <A-n> <Plug>CmdlineCompleteForward

"powerline{
set guifont=XHei\ Mono\ 11.5
set nocompatible
set t_Co=256
let g:Powerline_symbols = 'fancy'
"let g:Powerline_stl_path_style = 'full'
call Pl#Theme#InsertSegment('pwd', 'before', 'filename')
"call Pl#Theme#InsertSegment('pwd', 'after', 'filetype')
"}
" stardict
function! Mydict()
	let expl=system('sdcv -n ' .
		\  expand("<cword>"))
	windo if
       \ expand("%")=="diCt-tmp" |
       \ q!|endif
 25vsp diCt-tmp
 setlocal buftype=nofile bufhidden=hide noswapfile
 1s/^/\=expl/
 1
endfunction
nmap F :call Mydict()<CR>
nmap <silent><leader>d :!sdcv <cword> <CR>"
""""""""""""""""""""""""""""""""""""""""""""""""""
" rainbow parenthese
"""""""""""""""""""""""""""""""""""""""""""""""""""
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"map<F3> :call rainbow#activate()<cr>

" let g:rainbow_active = 1
" let g:rainbow_operators = 2
" 
" let g:rainbow_load_separately = [
" 	\ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
" 	\ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
" 	\ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
" 	\ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
" 	\ ]
" 
" let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick',]

""""""""""""""""""""""""""""""""""""""""""""""""""
" show number
nnoremap <leader>n :if ShowNumToggle()<Bar>set number<Bar>else<Bar>set nonumber<Bar>endif<CR>
function! ShowNumToggle()
  let @/ = ''
  if exists('#shownum')
    au! shownum
    augroup! shownum
    echo 'shownum current word: off'
    return 0
  else
    augroup shownum
    augroup end
    echo 'shownum current word: ON'
    return 1
  endif
endfunction

