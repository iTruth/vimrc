"====================插件配置开始====================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin('~/.vim/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'
" colorscheme
Plugin 'itruth/molokai'
Plugin 'itruth/auto-pairs'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-latex/vim-latex'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'gko/vim-coloresque'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

" Markdown
Plugin 'tamlok/vim-markdown.git'
Plugin 'kannokanno/previm'
Plugin 'tyru/open-browser.vim'

" 部分插件需要python支持
if has('python3')
Plugin 'sirver/ultisnips'
Plugin 'itruth/vim-snippets'
Plugin 'ycm-core/YouCompleteMe'
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"====================插件配置结束====================

" 语法高亮
syntax on
" 配色方案
colorscheme molokai
" 启动不显示提示 
set shortmess=atI
" 窗口位置
"winpos 100 100
" 窗口大小
set lines=30 columns=110
" 设置字体
set guifont=Courier\ New\ 11
" 显示行号
set nu
" 显示标尺
set ruler
" 不显示图形按钮
set go=
" 突出显示当前行
set cursorline
" 显示输入的命令
set showcmd
" 设置编码格式
set encoding=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
" 代码补全 
set completeopt=preview,menu 
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
"搜索逐字符高亮
set hlsearch
set incsearch
" 使退格键(backspace)正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 设置手动折叠
set foldenable
set foldmethod=manual
" 去掉vi一致性模式
set nocompatible
" 字符间插入的像素行数目
set linespace=0
" 自动读取和保存
set autoread
set autowrite
" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 不要用空格代替制表符
set noexpandtab
" 为C程序提供自动缩进
set smartindent
" 在行和段开始处使用制表符
set smarttab
" 不生成临时文件(这样做VIM将无法撤销上次文件的修改)
set nobackup
set noswapfile
" 设置匹配括号高亮时间
set showmatch
set matchtime=1
" 设置魔术
set magic
" 共享剪贴板
set clipboard+=unnamed
" 允许使用鼠标
set mouse=a
set selection=exclusive
set selectmode=mouse,key

"""""""""""Alt+n快捷切换Tab"""""""""""""""""""""""""""""""
function! TabPos_ActivateBuffer(num)
	let s:count = a:num
	exe "tabfirst"
	exe "tabnext" s:count
endfunction
function! TabPos_Initialize()  
	for i in range(1, 9)
		exe "map <M-" . i . "> :call TabPos_ActivateBuffer(" . i . ")<CR>"
	endfor
	exe "map <M-0> :call TabPos_ActivateBuffer(10)<CR>"
endfunction
autocmd VimEnter * call TabPos_Initialize()

""""""""""""""""""""""""""""""""""""""""""""""""""""
"新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.cpp,.java,.bat文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.java,*.bat exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	if &filetype == 'bat'
		call append(0, "@echo off")
		call append(1, "")
	elseif &filetype == 'java'
		call append(0, "import java.util.*;")
		call append(1, "")
	elseif expand('%:e') == 'cpp'
		"set dictionary+=cpp_h.dic
		call append(0, "#include <iostream>")
		call append(1, "using namespace std;")
		call append(2, "")
	elseif expand('%:e') == 'h'
		if filereadable(expand('%:r').'.c')
			call append(0, "#ifndef ".toupper(expand("%:r"))."_H")
			call append(1, "#define ".toupper(expand("%:r"))."_H")
			call append(2, "")
			call append(3, "#endif")
			exec "normal 3G"
		else
			call append(0, "#ifndef ".toupper(expand("%:r"))."_H")
			call append(1, "#define ".toupper(expand("%:r"))."_H")
			call append(2, "")
			call append(3, "class ".expand("%:r")."{")
			call append(4, "	public:")
			call append(5, "		".expand("%:r")."();")
			call append(6, "		")
			call append(7, "};")
			call append(8, "")
			call append(9, "#endif")
			exec "normal 7G$"
		endif
	elseif &filetype == 'c'
		call append(0, "#include <stdio.h>")
		call append(1, "")
	endif
	"新建文件后，自动定位到文件末尾
	autocmd BufNewFile * normal G
endfunc 

""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""
" 映射全选 ctrl+a
nnoremap <C-A> ggvG$
"自动对齐
nnoremap <F12> gg=G
"窗口间切换  
nnoremap <F2> <C-w>w 
"去空行  
nnoremap <C-F2> :g/^\s*$/d<CR>
"新建标签  
nnoremap <M-F3> :tabnew<CR>
"列出当前目录文件  
noremap <F3> :tabnew .<CR>

"Alt+o/O以命令模式插入行
noremap <M-o> o<Esc>
noremap <M-O> O<Esc>

"insert模式emacs快捷键
inoremap <C-L> <ESC>zza
inoremap <C-F> <ESC>la
inoremap <C-N> <ESC>ja
inoremap <C-P> <ESC>ka
inoremap <C-B> <ESC>i
inoremap <C-A> <ESC>I
inoremap <C-E> <ESC>A
inoremap <C-K> <ESC>C
inoremap <M-<> <ESC>ggi
inoremap <M->> <ESC>GA

"\ 命令定义
nnoremap \im :call SetNewLine()<CR>Simport 
nnoremap \inc :call SetNewLine()<CR>S#include 
nnoremap \ins :call SetNewLine()<CR>S#include <><Esc>i
nnoremap \de :call SetNewLine()<CR>S#define 
function! SetNewLine()
	if len(getline('.')) != 0
		exec "normal! o"
	endif
endfunction

nnoremap \main :call AddMain()<CR>o
function! AddMain()
	if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'h'
		exec "normal! Iint main(int argc, char* argv[])\<CR>{\<CR>}\<ESC>k"
	elseif &filetype == 'python'
		exec "normal! Iif __name__ == '__main__':\<CR>\<Tab>main();\<Esc>kO\<Esc>O\<Esc>Idef main():"
	elseif &filetype == 'java'
		exec "normal! Spublic static void main(String[] args){\<CR>}\<ESC>k"
	endif
endfunction

nnoremap \f :call AddFunc()<CR>i
function! AddFunc()
	if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'h'
		exec "normal! S()\<CR>{\<CR>}\<ESC>kkI"
	elseif &filetype == 'python'
		exec "normal! Sdef ():\<ESC>$F("
	elseif &filetype == 'java'
		exec "normal! a(){\<CR>}\<ESC>k$F("
	endif
endfunction

nnoremap \0f :call AddFrontFunc()<CR>i
function! AddFrontFunc()
	if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'h'
		exec "normal! I()\<CR>{\<CR>}\<ESC>kkI"
	elseif &filetype == 'python'
		exec "normal! Idef ():\<ESC>$F("
	elseif &filetype == 'java'
		exec "normal! a(){\<CR>}\<ESC>k$F("
	endif
endfunction

"函数调用
nnoremap \cf :call FunctionCall()<CR>F(i
function! FunctionCall()
	if len(getline('.')) == 0
		exec "normal! S();"
	else
		exec "normal! a();"
	endif
endfunction

"切换C/C++相关联的头文件
nnoremap <F4> :call CPPAutoSwitch()<CR>
func CPPAutoSwitch()
	if expand('%:e') == 'c'
		let s:cpp_e = 'c'
		call SwitchSourceAndHeader('c', 'h')
	elseif expand('%:e') == 'cpp'
		let s:cpp_e = 'cpp'
		call SwitchSourceAndHeader('cpp', 'h')
	elseif expand('%:e') == 'h'
		if exists("s:cpp_e")
			call SwitchSourceAndHeader(s:cpp_e, 'h')
		elseif filereadable(expand('%:r').'.c')
			call SwitchSourceAndHeader('c', 'h')
		else
			call SwitchSourceAndHeader('cpp', 'h')
		endif
	endif
endfunc
func SwitchSourceAndHeader(src, header)
	if expand('%') == expand('%:r').'.'.a:src
		let s:n = TabID(expand('%:r').'.'.a:header)
		if(s:n == -1)
			exec "tabe %<.".a:header
		else
			exec (s:n+1)."tabn"
		endif
	elseif expand('%') == expand('%:r').'.'.a:header
		let s:n = TabID(expand('%:r').'.'.a:src)
		if(s:n == -1)
			exec "tabe %<.".a:src
		else
			exec (s:n+1)."tabn"
		endif
	endif
endfunc
func TabID(TabName)
	for n in range(tabpagenr('$'))
		if MyTabLabel(n+1) == a:TabName
			return n
		endif
	endfor
	return -1
endfunc
function MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	return bufname(buflist[winnr - 1])
endfunction

" 按F5编译
nnoremap <F5> :call CompileBuildGcc()<CR>
func! CompileBuildGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc -Wall % -o %<"
	elseif &filetype == 'cpp'
		exec "!g++ -Wall % -o %<"
	elseif &filetype == 'java' 
		exec "!javac -encoding UTF-8 %"
	elseif &filetype == 's'
		exec "!gcc -o %< %<.s"
	elseif &filetype == 'sh'
		:!./%
	elseif &filetype == 'asm'
		exec "!nasm -f bin % -o %<.bin"
	endif
endfunc

" 按F6运行
noremap <F6> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 's'
		exec "! %<"
	elseif &filetype == 'c'
		exec "! %<"
	elseif &filetype == 'cpp'
		exec "! %<"
	elseif &filetype == 'java' 
		exec "!java %<"
	elseif &filetype == 'asm' 
		exec "!qemu-system-arm %<.bin"
	elseif &filetype == 'python'
		exec "!python %"
	elseif &filetype == 'sh'
		:! %
	endif
endfunc

" C,C++按F8调试
noremap <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	if &filetype == 'c'
		exec "!gcc -g % -o %<"
	elseif &filetype == 'cpp'
		exec "!g++ -g % -o %<"
	endif
	exec "!gdb ./%<"
endfunc

"====================vimtex配置====================
let g:tex_flavor='latex'
"let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
" \lx使用xelatex编译
" \lc删除临时文件
function ComplieWithXeTeX()
	let oldRule = g:Tex_CompileRule_pdf
	let g:Tex_CompileRule_pdf = 'latexmk --synctex=-1 -src-specials -interaction=nonstopmode $*'
	call Tex_RunLaTeX()
	let g:Tex_CompileRule_pdf = oldRule
endfunction
map <Leader>lx :<C-U>call ComplieWithXeTeX()<CR>

function CleanTempFiles()
	execute '!latexmk -c'
endfunction
map <Leader>lc :<C-U>call CleanTempFiles()<CR>
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

"====================tagbar配置====================
"设置tagbar使用的ctags的插件,必须要设置对
let g:tagbar_ctags_bin='ctags'
"设置tagbar的窗口宽度
let g:tagbar_width=26
"设置tagbar的窗口显示的位置到左边
let g:tagbar_left = 1
"设置标签不排序,默认排序
let g:tagbar_sort = 0
"打开文件自动 打开
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"映射tagbar的快捷键
map <silent> <F9> :TagbarToggle<CR>

"====================airline配置====================
" 这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts = 1   
" 打开tabline功能
let g:airline#extensions#tabline#enabled = 1
" 显示tab序号
let g:airline#extensions#tabline#tab_nr_type = 1
" 设置主题
let g:airline_theme="distinguished"
" 设置字体
set guifont=Noto\ Mono\ for\ Powerline\ 11
" 正常模式下TAB键切换Tabs
nnoremap <TAB> :tabn<CR>
nnoremap <S-TAB> :tabp<CR>

"====================NERDTree配置====================
""将F10设置为开关NERDTree的快捷键
map <F10> :NERDTreeToggle<cr>
""修改树的显示图标
" let g:NERDTreeDirArrowExpandable = '+'
" let g:NERDTreeDirArrowCollapsible = '-'
""窗口位置
let g:NERDTreeWinPos='right'
""窗口尺寸
let g:NERDTreeSize=30
" 新tab中打开文件
" let g:NERDTreeCustomOpenArgs = {'file': {'reuse': 'all', 'where': 't'}, 'dir': {}}

"====================CtrlP配置====================
" 防止按键冲突
let g:ctrlp_prompt_mappings = {'PrtClearCache()': ['<C-F5>'], 'PrtDeleteEnt()': ['<C-F7>']}

"====================需要Python3支持的插件的配置====================
if has('python3')
	"====================ultisnips配置====================
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

	" 解决和YCM的按键冲突
	function! g:UltiSnips_Complete()
		call UltiSnips#ExpandSnippet()
		if g:ulti_expand_res == 0
			call UltiSnips#JumpForwards()
			if g:ulti_jump_forwards_res == 0
				return "\<TAB>"
			endif
		endif
		return ""
	endfunction

	function! g:UltiSnips_Reverse()
		call UltiSnips#JumpBackwards()
		return ""
	endfunction


	if !exists("g:UltiSnipsJumpForwardTrigger")
		let g:UltiSnipsJumpForwardTrigger = "<tab>"
	endif
	if !exists("g:UltiSnipsJumpBackwardTrigger")
		let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
	endif

	au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
	au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

	"====================YCM配置====================
	" 寻找全局配置文件
	" 需要GCC支持且不需要clang支持
	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
	" 禁用syntastic来对python检查
	let g:syntastic_ignore_files=[".*\.py$"] 
	" 使用ctags生成的tags文件
	let g:ycm_collect_identifiers_from_tag_files = 1
	" 修改对C语言的补全快捷键，默认是CTRL+space，修改为ALT+/未测出效果
	let g:ycm_key_invoke_completion = '<M-/>'
	" 设置转到定义处的快捷键为ALT+G，未测出效果
	"nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR> 
	"关键字补全
	let g:ycm_seed_identifiers_with_syntax=1
	" 在接受补全后不分裂出一个窗口显示接受的项
	set completeopt-=preview
	" 让补全行为与一般的IDE一致
	set completeopt=longest,menu
	" 不显示开启vim时检查ycm_extra_conf文件的信息
	let g:ycm_confirm_extra_conf=0
	" 每次重新生成匹配项，禁止缓存匹配项
	let g:ycm_cache_omnifunc=0
	" 在注释中也可以补全
	let g:ycm_complete_in_comments=1
	" 输入第一个字符就开始补全
	let g:ycm_min_num_of_chars_for_completion=1
	" 错误标识符
	let g:ycm_error_symbol='E>'
	" 警告标识符
	let g:ycm_warning_symbol='W>'
	" 不查询ultisnips提供的代码模板补全
	let g:ycm_use_ultisnips_completer=0
endif
