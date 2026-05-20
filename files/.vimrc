"Editor:	Eric_Hong
"Orginal:	Aug 11, 2019
"Date:		Feb 15, 2026 

"Target:	For All (Linux n Window) Mechine
"Note:		vim setting/configuration, collect from internet search...
"Note:		Reload .vimrc by typing ":so $MYVIMRC"

" Install Vundle
" 1) $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" 2) $ touch ~/.vimrc ; Edit or Copy as below
"      PS: Add new text line, ex: Plugin 'will133/vim-dirdiff', between "call vundle#begin()" and "call vundle#end()" 
" 3) Launch vim and run :PluginInstall, To install from command line: vim +PluginInstall +qall

if(has("win32") || has("win95") || has("win64") || has("win7") || has("win10"))
	set backupdir=%HOMEDRIVE%%HOMEPATH%\//
	set directory=%HOMEDRIVE%%HOMEPATH%\//
	set undodir=%HOMEDRIVE%%HOMEPATH%\//
else
	set backupdir=~/.vim//
	set directory=~/.vim//
	set undodir=~/.vim//
endif


set nocompatible
filetype off                  
let NERDTreeHijackNetrw=0

if(has("win32") || has("win95") || has("win64") || has("win7") || has("win10"))
	set rtp+=$VIM\..\Bundle\Vundle.vim
	call vundle#begin('$VIM\..\Bundle')
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif

Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Lokaltog/vim-powerline'
Plugin 'will133/vim-dirdiff'

:" ...

call vundle#end()
filetype plugin indent on 

set splitbelow
set splitright 

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
tnoremap <c-n> <c-w>:bnext<CR>
tnoremap <c-p> <c-w>:bprevious<CR>

nnoremap <C-B> :buffers<CR>
tnoremap <C-B> <C-W>:buffers<CR>
nnoremap <C-B><C-D> :bdelete<CR>

nnoremap <C-W>m :terminal<CR>
tnoremap <C-W>m <c-w>:terminal<CR>
nnoremap <C-W><C-M> :vertical terminal<CR>
tnoremap <C-W><C-M> <c-w>:vertical terminal<CR>
set termwinscroll=168589
nnoremap <C-W><C-N> :vertical new<CR>
tnoremap <C-W><C-N> <c-w>:vertical new<CR>

tnoremap <C-W>gt <c-w>:tabnext<CR>
tnoremap <C-W>gT <c-w>:tabprevious<CR>

nnoremap <F6> "=strftime('%b %d, %Y ')<CR>P
imap <F6> <ESC>l"=strftime('%b %d, %Y ')<CR>Pi
nnoremap <F8> :call ChangeFileencoding_WP()<CR>
imap <F8> <ESC>:call ChangeFileencoding_WP()<CR>i
nnoremap <F9> :%!xxd<CR>
imap <F9> <ESC>:%!xxd<CR>
if (&term =~ '^screen^') || (has("win32") || has("win95") || has("win64") || has("win7") || has("win10"))
	nnoremap <S-F6> "=strftime('%b %d, %Y ')<CR>R<C-R>=<CR><ESC>
	imap <S-F6> <ESC>"=strftime('%b %d, %Y ')<CR>lR<C-R>=<CR><ESC>i
	nnoremap <S-F1> :e<CR>
	imap <S-F1> <ESC>:e<CR>i
	nnoremap <S-F8> :call ChangeFileencoding(" ")<CR>
	imap <S-F8> <ESC>:call ChangeFileencoding("i")<CR>
	nnoremap <S-F9> :%!xxd -r<CR>
	imap <S-F9> <ESC>:%!xxd -r<CR>
else
	nnoremap <ESC>[17;2~ "=strftime('%b %d, %Y ')<CR>R<C-R>=<CR><ESC>
	imap <ESC>[17;2~ <ESC>"=strftime('%b %d, %Y ')<CR>lR<C-R>=<CR><ESC>i
	nnoremap <ESC>[1;2P :e<CR>
	imap <ESC>[1;2P <ESC>:e<CR>i
	nnoremap <ESC>[19;2~ :call ChangeFileencoding(" ")<CR>
	imap <ESC>[19;2~ <ESC>:call ChangeFileencoding("i")<CR>
	nnoremap <ESC>[20;2~ :%!xxd -r<CR>
	imap <ESC>[20;2~ <ESC>:%!xxd -r<CR>
endif

nnoremap <C-W><C-T> <C-W>T
tnoremap <C-W><C-T> <C-W>T

if(has("win32") || has("win95") || has("win64") || has("win7") || has("win10"))
	nnoremap <F7> :!echo Not support in Windows mechine...<CR>
else
	nnoremap <F7> :!date --date @<C-R><C-W><CR>
endif

if (&term =~ '^screen^') || (has("win32") || has("win95") || has("win64") || has("win7") || has("win10"))
	nnoremap <C-Left> gT
	nnoremap <C-Right> gt
	tnoremap <C-Left> <c-w>:tabprevious<CR>
	tnoremap <C-Right> <c-w>:tabnext<CR>
else
	nnoremap <ESC>[1;5D gT
	nnoremap <ESC>[1;5C gt
	tnoremap <ESC>[1;5D <c-w>:tabprevious<CR>
	tnoremap <ESC>[1;5C <c-w>:tabnext<CR>
	nnoremap <ESC>[D gT
	nnoremap <ESC>[C gt
	tnoremap <ESC>[D <c-w>:tabprevious<CR>
	tnoremap <ESC>[C <c-w>:tabnext<CR>
endif

if (&term =~ '^screen^') || (has("win32") || has("win95") || has("win64") || has("win7") || has("win10"))
	nnoremap <S-Down>	<c-w>j
	nnoremap <S-Up>		<c-w>k 
	nnoremap <S-Left>	<c-w>h
	nnoremap <S-Right>	<c-w>l
	tnoremap <S-Down>	<c-w>j
	tnoremap <S-Up>		<c-w>k
	tnoremap <S-Left>	<c-w>h
	tnoremap <S-Right>	<c-w>l
else
	nnoremap <ESC>[1;2B <c-w>j
	nnoremap <ESC>[1;2A <c-w>k
	nnoremap <ESC>[1;2D <c-w>h
	nnoremap <ESC>[1;2C <c-w>l
	tnoremap <ESC>[1;2B <c-w>j
	tnoremap <ESC>[1;2A <c-w>k
	tnoremap <ESC>[1;2D <c-w>h
	tnoremap <ESC>[1;2C <c-w>l
endif


set foldmarker={,}
set foldmethod=marker
set foldlevel=0

nnoremap <space> za
nnoremap fdo zR
nnoremap fdc zM

let g:SimpylFold_docstring_preview=1


au BufNewFile,BufRead *.py set
 \ tabstop=4
 \ softtabstop=4
 \ shiftwidth=4
 \ textwidth=0
 \ expandtab
 \ autoindent


au BufReadCmd *.whl call zip#Browse(expand("<amatch>"))
let g:netrw_sizestyle="H"
let g:netrw_keepdir=0
au BufReadCmd *.egg call zip#Browse(expand("<amatch>"))

let g:ycm_autoclose_preview_window_after_completion=1

map <F4> :call Switch_YCM_Mode()<CR>
nmap <silent> <leader>a :call Switch_YCM_Mode()<CR>
function Switch_YCM_Mode()
	if (g:ycm_auto_trigger == "0")
		let g:ycm_auto_trigger=1
		echo "Switch YCM on  (:let g:ycm_auto_trigger=1)"
	else
		let g:ycm_auto_trigger=0
		echo "Switch YCM off (:let g:ycm_auto_trigger=0)"
	endif
endfunction

" Eric_H:026215
map <S-F4> :call Switch_FileFormat_UnD()<CR>
nmap <silent> <leader>ff :call Switch_FileFormat_UnD()<CR>
function Switch_FileFormat_UnD()
	if &fileformat == 'unix' 
		exec "e ++ff=dos"
		echo "Switch FileFormat to DOS (:e ++ff=dos)"
	else
		exec "e ++ff=unix"
		echo "Switch FileFormat to UNIX (:e ++ff=unix)"
	endif
endfunction

map <F3> :NERDTreeToggle<CR>
let NERDTreeChDirMode=1
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.swp$']
let NERDTreeShowHidden=1
let NERDTreeWinSize=22                           
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 1  


set guioptions-=r
set guioptions-=L
set guioptions-=b


set guifont=Courier:h12 

set wrap
set binary 
set tabstop=8
set shiftwidth=8
set showmatch
set scrolloff=6
set laststatus=2 


au BufNewFile,BufRead *.js,*.html,*.css
 \ set tabstop=2 |
 \ set softtabstop=2 |
 \ set shiftwidth=2 |
 \ set textwidth=0 |
 \ set noexpandtab

au BufNewFile,BufRead *.h,*.c,*.cpp,*.java
 \ set tabstop=4 |
 \ set softtabstop=4 |
 \ set shiftwidth=4 |
 \ set textwidth=0 |
 \ set noexpandtab |
 \ set cindent


set encoding=utf-8
set fileformats=unix,dos

if(has("win32") || has("win95") || has("win64") || has("win7") || has("win10"))
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
endif

syntax on        
set noignorecase


set number
set ruler
set cursorline
set cursorcolumn 

if(has("win32") || has("win95") || has("win64") || has("win7") || has("win10"))
	colorscheme darkblue
	set background=light "After set "colorscheme darkblue", and must to set light background, then set dark background (in below) finally... 
	set t_Co=256 "For vim.exe / DOS mode...
endif

hi CursorLine cterm=none ctermbg=238 ctermfg=White
hi CursorColumn cterm=none ctermbg=238 ctermfg=White
set background=dark     

set hlsearch
set incsearch

set confirm

set history=100  

set laststatus=2
set showmode     

set mouse=c      

map <F5> : call CompileRun()<CR>
nmap <silent> <leader>cplrun :call CompileRun()<CR>
command Cplrun :call CompileRun()
func! CompileRun()

	let current_work_DIR = getcwd()
	if expand("%:p:h") != current_work_DIR
		echo "Change working directory to:" expand('%:p:h') 
		lcd %:p:h
	endif

	if &filetype == 'c'
		exec "!g++ -Wall -g -Dlinux % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ -Wall -g -Dlinux % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java'
		exec "!time javac_ECJorJAVAC % ansi"
		exec "!time java_DVKorJAVA %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python3 %"
	elseif &filetype == 'html'
		exec "!firefox % &"
	elseif &filetype == 'go'
		exec "!go build %<"
		exec "!time go run %"
	elseif &filetype == 'mkd'
		exec "!~/.vim/markdown.pl % > %.html &"
		exec "!firefox %.html &"
	endif
endfunction


nmap <silent> <leader>jcode :call Set_JAVA_Title_classNmain()<CR>

function Set_JAVA_Title_classNmain()

	let current_work_DIR = getcwd()
	if expand("%:p:h") != current_work_DIR
		echo "Change working directory to:" expand('%:p:h') 
		lcd %:p:h
	endif

	call setline(1,           "/*")
	call append(line("."),    " *   Copyright (C) ".strftime("%Y")." All rights reserved.")
	call append(line(".")+1,  " *")
	call append(line(".")+2,  " *   FileName      ：".expand('%:t'))
	call append(line(".")+3,  " *   Author        ：Eric Hong")
	call append(line(".")+4,  " *   Email         ：Eric_Hong@hcc.comm")
	call append(line(".")+5,  " *   Date          ：".strftime("%Y年%m月%d日"))
	call append(line(".")+6,  " *   Description   ：")
	call append(line(".")+7,  " */")

	call append(line(".")+8,  "public class ".expand('%<'))
	call append(line(".")+9,  "{")
	call append(line(".")+10, "\tpublic static void main(String[] args)")
	call append(line(".")+11, "\t{")
	call append(line(".")+12, "\t\tSystem.out.println(\"Hello, Start Your JAVA Code Here...\");")
	call append(line(".")+13, "\t}")
	call append(line(".")+14, "}")
endfunction


nmap <silent> <leader>ccode :call Set_C_Title_classNmain()<CR>

function Set_C_Title_classNmain()

	let current_work_DIR = getcwd()
	if expand("%:p:h") != current_work_DIR
		echo "Change working directory to:" expand('%:p:h') 
		lcd %:p:h
	endif

	call setline(1,           "/*")
	call append(line("."),    " *   Copyright (C) ".strftime("%Y")." All rights reserved.")
	call append(line(".")+1,  " *")
	call append(line(".")+2,  " *   FileName      ：".expand('%:t'))
	call append(line(".")+3,  " *   Author        ：Eric Hong")
	call append(line(".")+4,  " *   Email         ：Eric_Hong@hcc.comm")
	call append(line(".")+5,  " *   Date          ：".strftime('%b %d, %Y'))
	call append(line(".")+6,  " *   Description   ：")
	call append(line(".")+7,  " *   Reference     ：")
	call append(line(".")+8,  " */")
	call append(line(".")+9,  "")
	call append(line(".")+10,  "#include <stdio.h>")
	call append(line(".")+11,  "")
	call append(line(".")+12,  "int main()")
	call append(line(".")+13,  "{")
	call append(line(".")+14, "\tprintf(\"\\r\\nHello, Start Your C Code Here...\\r\\n\");")
	call append(line(".")+15, "}")
endfunction

cnoremap sudow w !sudo tee % > /dev/null
command Sudow :w !sudo tee % > /dev/null

map <F2> :w<CR>
imap <F2> <ESC><F2>li

	nnoremap <ESC>[1;3D :call TabMove(-1)<CR>
	nnoremap <ESC>[1;3C :call TabMove(+1)<CR>
	tnoremap <ESC>[1;3D <c-w>:call TabMove(-1)<CR>
	tnoremap <ESC>[1;3C <c-w>:call TabMove(+1)<CR>
function! TabMove(direction)
    let ntp=tabpagenr("$")
    if ntp > 1
        let ctpn=tabpagenr()
        if a:direction < 0
            let index=((ctpn-1+ntp-1)%ntp)
        else
            let index=((ctpn)%ntp+1)
        endif
        execute "tabmove ".index
    endif
endfunction

function! ChangeFileencoding(mode)
	let encodings = ['utf8', 'big5', 'euc-tw', 'gb18030', 'euc-cn', 'euc-jp', 'sjis', 'euc-kr', 'utf16', 'utf16le', 'utf32', 'utf32le', 'cp1253', 'koi8-r', 'latin1']
	let encodings_TXT = [' --> 32 bit UTF-8 encoded Unicode (ISO/IEC 10646-1)', ' --> Traditional Chinese (on Windows alias for cp950)', ' --> Traditional Chinese (Unix only)', ' --> Simplified Chinese (formaer is GB2312)', ' --> Simplified Chinese (Unix only)', ' --> Japanese (Unix only)', ' --> Japanese (Unix only)', ' --> Korean (Unix only)', ' --> ucs-2 extended with double-words for more characters', ' --> like utf-16, little endian', ' --> 32 bit UCS-4 encoded Unicode (ISO/IEC 10646-1)', ' --> like ucs-4, little endian', ' --> Greek', ' --> Russian', ' --> 8-bit characters (ISO 8859-1, also used for cp1252)']
	let prompt_encs = []
	let index = 0
	while index < len(encodings)
		call add(prompt_encs, index.'. '.encodings[index].encodings_TXT[index])
		let index = index + 1
	endwhile
	let choice = inputlist(prompt_encs)
	if choice >= 0 && choice < len(encodings)
		execute 'e ++enc='.encodings[choice].' %:p'
	endif
	if a:mode == "i"
		execute 'startinsert'
	endif
endf

let g:enc_index = 0
function! ChangeFileencoding_WP()
	let encodings = ['utf8', 'big5', 'euc-tw', 'gb18030', 'euc-cn', 'euc-jp', 'sjis', 'euc-kr', 'utf16', 'utf16le', 'utf32', 'utf32le', 'cp1253', 'koi8-r', 'latin1']
	execute 'e ++enc='.encodings[g:enc_index].' %:p'
	if g:enc_index >=14
		let g:enc_index = 0
	else
		let g:enc_index = g:enc_index + 1
	endif
endf

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

au CursorHold * checktime
au FocusGained,BufEnter * :checktime
set updatetime=1000
set noautoread

tnoremap <C-W>/ <c-w>:call ClearCurrentTerminalBuffer('')<CR>
tnoremap <C-W>// <c-w>:call ClearCurrentTerminalBuffer('/')<CR>
tnoremap <C-W>/1 <c-w>:call ClearCurrentTerminalBuffer('1')<CR>
tnoremap <C-W>/9 <c-w>:call ClearCurrentTerminalBuffer('9')<CR>
function! ClearCurrentTerminalBuffer(type)
	let scroll_size = &scroll
	let termwinscroll_size = &termwinscroll
	setlocal scroll=1
	setlocal termwinscroll=1
	let CurrentTermWinHeight = winheight(0) + 1
	for i in range(1, CurrentTermWinHeight)
		call term_sendkeys(bufnr('%'), "\<CR>")
		sleep 1m
	endfor
	if(has("win32") || has("win95") || has("win64") || has("win7") || has("win10"))
		call term_sendkeys(bufnr('%'), "cls\<CR>")
	else
		call term_sendkeys(bufnr('%'), "clear\<CR>")
	endif
	execute "setlocal scroll=" . scroll_size
	if a:type ==# ''
		execute "setlocal termwinscroll=" . termwinscroll_size
	else
		if a:type ==# '/'
			setlocal termwinscroll=99
		endif
		if a:type ==# '1'
			setlocal termwinscroll=168
		endif
		if a:type ==# '9'
			setlocal termwinscroll=999
		endif
	endif
endf

" End Line
