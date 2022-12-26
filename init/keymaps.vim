vim9script

noremap <CR> :

nnoremap 0 ^
nnoremap ^ 0

#----------------------------------------------------------------------
# 设置 CTRL+HJKL 移动光标（INSERT 模式偶尔需要移动的方便些）
# 使用 SecureCRT/XShell 等终端软件需设置：Backspace sends delete
# 详见：http://www.skywind.me/blog/archives/2021
#----------------------------------------------------------------------

inoremap <C-o> <Esc>o
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Esc>^i
inoremap <C-e> <End>
inoremap <C-h> <BS>
inoremap <C-d> <Del>


#----------------------------------------------------------------------
# 命令模式的快速移动, 与terminal中映射相同。
#----------------------------------------------------------------------

cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <BS>
# Ctrl+K 删除光标到行末
cnoremap <C-k> <C-\>e(strpart(getcmdline(), 0, getcmdpos() - 1))<CR>
# 光标在行末时补全，在中间时删除右侧字符
cnoremap <expr> <C-d> (getcmdpos() == len(getcmdline()) + 1 ? '<C-d>' : '<Del>')

# if has('terminal')
# 	nnoremap <M-0> :bo term<CR>
# 	tnoremap <Esc> <C-w>:q!<CR>
# 	if !has('gui_running')
# 		nnoremap 0 :bo term<CR>
# 	endif
# endif

# if !has('gui_running')
# 	set <M-3>=\e3
# endif
