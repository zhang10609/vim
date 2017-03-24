"set ctags
set tags=tags;/

" 按F8按钮，在窗口的左侧出现taglist的窗口,像vc的左侧的workpace
nnoremap  <F8> :TlistToggle<CR><CR>
" :Tlist              调用TagList
let Tlist_Show_One_File=0                    " 只显示当前文件的tags
let Tlist_Exit_OnlyWindow=1                  " 如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_Use_Left_Window=1                 " 在右侧窗口中显示
let Tlist_File_Fold_Auto_Close=1             " 自动折叠

set ruler                                    " show the cursor position all the time
set showcmd                                  " display incomplete commands
set cursorline
set number

"与windows共享剪贴板
set clipboard+=unnamed

":set hlsearch
":hi Search term=standout ctermfg=0 ctermbg=3
"highlight TabLineSel term=bold cterm=bold ctermbg=Red ctermfg=yellow
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
 set hlsearch
endif
map <C-n> :nohl <cr>

"设置tab键为4个空格
set ts=4
set expandtab
set autoindent


if filereadable("cscope.out")
   cs add cscope.out
endif

""" -----------------------------------------------------------------------------
"  < 代码折叠 >
" -----------------------------------------------------------------------------
"用空格键来开关折叠
set foldenable
set foldmethod=manual
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

set foldmarker={,}
set foldmethod=marker
set foldmethod=syntax
set foldlevel=100       " Don't autofold anything
set foldopen-=search   " don't open folds when you search into them
set foldopen-=undo     " don't open folds when you undo stuff

" -----------------------------------------------------------------------------
"" -----------------------------------------------------------------------------
"  < 自动补齐>
" -----------------------------------------------------------------------------
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i<Enter><ESC><s-o>
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap < <><ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap ' <c-r>=ClosePair(''')<CR>
":inoremap " <c-r>=ClosePair('"')<CR>
func! ClosePair(char)
    if getline('.')[col('.') -1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


"删除代码中多余的空格
function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\\\@<!\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)
map <space><space><space> :FixWhitespace<cr>
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/


"cscope 与 ctags最新配置"
""set autochdir "自动切换"
""set tags=tags;
""
""set nocst "在cscope数据库添加成功的时候不在命令栏显示提示信息"
""set cspc=6 "cscope的查找结果在格式上最多显示6层目录"
""let g:autocscope_menus=0 "关闭autocscope插件的库卡捷键映射，防止和我们定义的快捷键冲突

"ff映射到ctrl+],这将调用ctags数据库跳转，速度上回快点，如果不行，可以尝试fg，这将调用cscope数据库跳转"
""nmap ff <c-]>
"""ss映射ctrl+t，在通过ff跳转的时候，通过ss跳转回来"
""nmap ss <c-t>
""
"""s:查找即查找C语言符号出现的地方
""nmap fs :cs find s <C-R>=expand("<cword>")<CR><CR>
"""g:查找函数、宏、枚举等定义的位置
""nmap fg :cs find g <C-R>=expand("<cword>")<CR><CR>
"""c:查找光标下的函数被调用的地方
""nmap fc :cs find c <C-R>=expand("<cword>")<CR><CR>
"""t: 查找指定的字符串出现的地方
""nmap ft :cs find t <C-R>=expand("<cword>")<CR><CR>
"""e:egrep模式查找,相当于egrep功能
""nmap fe :cs find e <C-R>=expand("<cword>")<CR><CR>
"""f: 查找文件名,相当于lookupfile
""nmap fn :cs find f <C-R>=expand("<cfile>")<CR><CR>
"""i: 查找当前文件名出现过的地方
""nmap fi :cs find i <C-R>=expand("<cfile>")<CR><CR>
"""d: 查找本当前函数调用的函数
""nmap fd :cs find d <C-R>=expand("<cword>")<CR><CR>
""

"nmap <f12> <esc>:call Go_top()<cr>:!ctags -R --c++-kinds=+p --fields=+iaS
"\ --extra=+q $PWD<cr>:call Do_CsTag()<cr>:!nametags.sh<cr><cr>:call Go_curr()<cr>
"imap <f12> <esc>:call Go_top()<cr>:!ctags -R --c++-kinds=+p --fields=+iaS
"\ --extra=+q $PWD<cr>:call Do_CsTag()<cr>:!nametags.sh<cr><cr>:call Go_curr()<cr>
"nmap <a-f12> <esc>:!ctags -R --fields=+lS $PWD<cr><cr>
"\:!cscope -Rbkq<cr><cr>:!nametags.sh<cr><cr>
"imap <a-f12> <esc>:!ctags -R --fields=+lS $PWD<cr><cr>
"\:!cscope -Rbkq<cr><cr>:!nametags.sh<cr><cr>

""nmap <f12> <esc>:call Go_top()<cr>:!ctags -R --fields=+lS $PWD<cr><cr>
""\:!cscope -Rbkq<cr><cr>:!nametags.sh<cr><cr>:call Go_curr()<cr>
""imap <f12> <esc>:call Go_top()<cr>:!ctags -R --fields=+lS $PWD<cr><cr>
""\:!cscope -Rbkq<cr><cr>:!nametags.sh<cr><cr>:call Go_curr()<cr>
""
""func! Go_top()
""    wall
""    let g:Curr_dir=getcwd()
""    let i = 1
""    while i < 10
""        if filereadable("TOP")
""            return
""        else
""            cd ..
""          let i += 1
""        endif
""    endwhile
""    exec 'cd'.g:Curr_dir
""endfunc
""
""func! Go_curr()
""    exec 'cd'.g:Curr_dir
""endfunc
""
""func! Do_CsTag()
""    silent! exec "!find .-name '*.h' -o -name '*.c' -o -name '*.cpp'
""    \ -o -name 'Makefinle' -o -name 'makefile' -o -name 'make*'
""    \ -o -name '*.cc' -o -name '*.C' -o -name '*.s' -o -name '*.S'>cscope.files"
""    silent! exec"!cscope -Rbkq -i cscope.files"
""    silent! exec"!cscope -Rbkq"
""endfunc

au BufWritePost *.py,*.c,*.cpp,*.h silent! !eval 'ctags -R -o newtags; mv newtags tags' &
map <F5> :!cscope -Rkbq<CR>:cs reset<CR><CR>


:set listchars=tab:>-,trail:-
