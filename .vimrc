" Encoding related
set encoding=UTF-8
set showtabline=2
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8

set autoindent
set syntax=on
set nocp
set softtabstop=4
set ts=4
set expandtab
set nu
filetype plugin on
set omnifunc=syntaxcomplete#Complete
colorscheme IDLE
let g:pydiction_location='~/.vim/vimfile/pydiction/complete-dict'
let g:user_zen_leader_key = '<c-l>'
let g:use_zen_complete_tag = 1

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window = 1

set tags=tags;
    set autochdir

imap <silent> jj <ESC>:w<CR>k "保存
imap <silent> ff <ESC> " 退出状态
map <silent> ww :wq<CR> "关闭

map <silent> <F5> mz?(*)<CR>yyggpA;<ESC>'z  " 创建函数原型
imap <silent> <F5> <ESC>mz?(*)<CR>yyggpA;<ESC>'zA

map <F6> :call Test()<CR>		    " 调试
imap <F6> <ESC>:call Test()<CR>

map <silent> <F7> :Grep<CR><CR><CR>	    " 全局搜索
imap <silent> <F7> <ESC>:Grep<CR><CR><CR>

map <F2> :silent! NERDTreeToggle <CR>       "文件窗口
map <F3> :silent! Tlist<CR>                 "函数窗口

map <F8> i#<ESC>j0			    " 注释
imap <F8> <ESC>i#<ESC>j0

map <F9> 0Ji<CR><ESC>			    "对齐 平级
imap <F9> <ESC>0Ji<CR><ESC>

map <F10> 0Ji<CR>    <ESC>		    "对齐 增加缩进
imap <F10> <ESC>0Ji<CR>    <ESC>

map <F11> 0Ji<CR><ESC>XXXX<ESC>		    "对齐 减少缩进
imap <F11> <ESC>0Ji<CR><ESC>XXXX<ESC>

"CS 快捷键
nmap <C-k>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-k>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-k>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-k>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-k>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-k>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-k>i :cs find i ^<C-R>=expand("<cfile>")<CR><CR>
nmap <C-k>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"CS 快捷键 END

for i in range(1,9) 
    exec 'map <A-'i'>' i 'gt'
"exec 'nnoremap <silent> <M-' i '>' i 'gt' 
endfor


map <1> 1gt

"关于tab的快捷键
map tn :tabnext<cr>
map tp :tabprevious<cr>
map td :tabclose<cr>
map te :tabedit 
"map tc :tabnew<cr>


function Python_Test()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python\ -u
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    copen
    let &makeprg     = mp
    let &errorformat = ef
endfunction

function C_Test()
    let cmd = "!gcc "
    let option = "-O2 "
    if search("math\.h") != 0
	let option .= " -lm "
    endif
    exec cmd. " % " .option
    endif

    exec "!./a.out"
    copen
endfunction

function Test()
    exec "w"
    if	&filetype == "c"
	exec "call C_Test()"
    elseif &filetype == "python"
	exec "call Python_Test()"
    endif
endfunction

function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
      let path = strpart(db, 0, match(db, "/cscope.out$"))
      set nocscopeverbose " suppress 'duplicate connection' error
      exe "cs add " . db . " " . path
      set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

    
