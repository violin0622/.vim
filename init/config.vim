vim9script
#======================================================================
#
# init-config.vim - 正常模式下的配置，在 init-basic.vim 后调用
#
# Created by skywind on 2018/05/30
# Last Modified: 2018/05/30 19:20:46
#
#======================================================================

#
# 使 [[ [] ][ ]] 四个映射可以找到位于行末的 { } 符号
#
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

#----------------------------------------------------------------------
# 有 tmux 何没有的功能键超时（毫秒）
#----------------------------------------------------------------------

# 为映射和键码都启用超时
set timeout ttimeout

if $TMUX != ''
	set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
	set ttimeoutlen=30
endif

#----------------------------------------------------------------------
# ALT 相关设置，详见：http://www.skywind.me/blog/archives/2021
# 记得设置 ttimeout （见 init-basic.vim） 和 ttimeoutlen （上面）
#----------------------------------------------------------------------

# MacVim GUI 开启 Option 键映射
# 会自动将 <M-a> 这样的映射翻译为 å，
# 因此在插入模式下依然可以用 Option 组合键输入 UTF-8 字符。
if g:Mac && g:GUI
	set macmeta
endif

# if g:vprof[g:Mac] && g:vprof[g:Term] && !has('nvim')
	def Metacode(key: string)
		exec "set <M-" .. key .. ">=\e" .. key
	enddef
	for i in range(10)
		Metacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		Metacode(nr2char(char2nr('a') + i))
	endfor
# endif
#if !has('nvim') && !has('gui_running')
#	def Metacode(key: string)
#		exec "set <M-" .. key .. ">=\e" .. key
#	enddef
#	for i in range(10)
#		Metacode(nr2char(char2nr('0') + i))
#	endfor
#	for i in range(26)
#		Metacode(nr2char(char2nr('a') + i))
#	endfor
#	for c in [',', '.', '/', ';', "'", '-', '=']
#		Metacode(c)
#	endfor
#endif

#----------------------------------------------------------------------
# 功能键终端码矫正
#----------------------------------------------------------------------

def KeyEscape(name: string, code: string)
	if !has('nvim') && !has('gui_running')
		exec "set " .. name .. "=\e" .. code
	endif
enddef

#KeyEscape('<F1>', 'OP')
#KeyEscape('<F2>', 'OQ')
#KeyEscape('<F3>', 'OR')
#KeyEscape('<F4>', 'OS')
#KeyEscape('<S-F1>', '[1;2P')
#KeyEscape('<S-F2>', '[1;2Q')
#KeyEscape('<S-F3>', '[1;2R')
#KeyEscape('<S-F4>', '[1;2S')
#KeyEscape('<S-F5>', '[15;2~')
#KeyEscape('<S-F6>', '[17;2~')
#KeyEscape('<S-F7>', '[18;2~')
#KeyEscape('<S-F8>', '[19;2~')
#KeyEscape('<S-F9>', '[20;2~')
#KeyEscape('<S-F10>', '[21;2~')
#KeyEscape('<S-F11>', '[23;2~')
#KeyEscape('<S-F12>', '[24;2~')

#----------------------------------------------------------------------
# 防止tmux下vim的背景色显示异常
# Refer: http://sunaku.github.io/vim-256color-bce.html
#----------------------------------------------------------------------

if &term =~ '256color' && $TMUX != ''
# disable Background Color Erase (BCE) so that color schemes
# render properly when inside 256-color tmux and GNU screen.
# see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif

if &term =~ 'xterm-kitty'
	set t_ut=
	# Mouse support
	set mouse=a
	set ttymouse=sgr
	set balloonevalterm
	# Styled and colored underline support
	&t_AU = "\e[58:5:%dm"
	&t_8u = "\e[58:2:%lu:%lu:%lum"
	&t_Us = "\e[4:2m"
	&t_Cs = "\e[4:3m"
	&t_ds = "\e[4:4m"
	&t_Ds = "\e[4:5m"
	&t_Ce = "\e[4:0m"
	# Strikethrough
	&t_Ts = "\e[9m"
	&t_Te = "\e[29m"
	# Truecolor support
	&t_8f = "\e[38:2:%lu:%lu:%lum"
	&t_8b = "\e[48:2:%lu:%lu:%lum"
	&t_RF = "\e]10;?\e\\"
	&t_RB = "\e]11;?\e\\"
	# Bracketed paste
	&t_BE = "\e[?2004h"
	&t_BD = "\e[?2004l"
	&t_PS = "\e[200~"
	&t_PE = "\e[201~"
	# Cursor control
	&t_RC = "\e[?12$p"
	&t_SH = "\e[%d q"
	&t_RS = "\eP$q q\e\\"
	&t_SI = "\e[5 q"
	&t_SR = "\e[3 q"
	&t_EI = "\e[1 q"
	&t_VS = "\e[?12l"
	# Focus tracking
	&t_fe = "\e[?1004h"
	&t_fd = "\e[?1004l"
	execute "set <FocusGained>=\<Esc>[I"
	execute "set <FocusLost>=\<Esc>[O"
	# Window title
	&t_ST = "\e[22;2t"
	&t_RT = "\e[23;2t"
endif

if &term =~ 'xterm-256color'
	set t_ZH=[3m
	set t_Cs="\e[4:3m"
	set t_Ce="\e[4:0m"
endif
#------------------------------------------------------------------
# 配置微调
#----------------------------------------------------------------------

# 修正 ScureCRT/XShell 以及某些终端乱码问题，主要原因是不支持一些
# 终端控制命令，比如 cursor shaping 这类更改光标形状的 xterm 终端命令
# 会令一些支持 xterm 不完全的终端解析错误，显示为错误的字符，比如 q 字符
# 如果你确认你的终端支持，不会在一些不兼容的终端上运行该配置，可以注释
# if has('nvim')
# 	set guicursor=
# elseif (!has('gui_running')) && has('terminal') && has('patch-8.0.1200')
# 	g:termcap_guicursor = &guicursor
# 	g:termcap_t_RS = &t_RS
# 	g:termcap_t_SH = &t_SH
# 	set guicursor=
# 	set t_RS=
# 	set t_SH=
# endif

# 打开文件时恢复上一次光标所在位置
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\	 exe "normal! g`\"" |
	\ endif

# 定义一个 DiffOrig 命令用于查看文件改动
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif



#----------------------------------------------------------------------
# 文件类型微调
#----------------------------------------------------------------------
augroup InitFileTypesGroup

# 清除同组的历史 autocommand
au!

# C/C++ 文件使用 // 作为注释
au FileType c,cpp setlocal commentstring=//\ %s

# markdown 允许自动换行
au FileType markdown setlocal wrap

# lisp 进行微调
au FileType lisp setlocal ts=8 sts=2 sw=2 et

# scala 微调
au FileType scala setlocal sts=4 sw=4 noet

# haskell 进行微调
au FileType haskell setlocal et

# quickfix 隐藏行号
au FileType qf setlocal nonumber

# 强制对某些扩展名的 filetype 进行纠正
au BufNewFile,BufRead *.as setlocal filetype=actionscript
au BufNewFile,BufRead *.pro setlocal filetype=prolog
au BufNewFile,BufRead *.es setlocal filetype=erlang
au BufNewFile,BufRead *.asc setlocal filetype=asciidoc
au BufNewFile,BufRead *.vl setlocal filetype=verilog
augroup END
