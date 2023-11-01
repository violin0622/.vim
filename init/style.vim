vim9script
#======================================================================
#
# init-style.vim - 显示样式设置
#
# Created by skywind on 2018/05/30
# Last Modified: 2018/05/30 20:29:07
#
#======================================================================


#----------------------------------------------------------------------
# 显示设置
#----------------------------------------------------------------------

# 总是显示状态栏
set laststatus=2

# 总是显示行号
set number

# 显示光标位置
set ruler

# 显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set signcolumn=number

# 智能显示标签栏
set showtabline=1

# 设置显示制表符等隐藏字符
set list

# 右下角显示命令
set showcmd

# 插入模式在状态栏下面显示 -- INSERT --，
# 先注释掉，默认已经为真了，如果这里再设置一遍会影响 echodoc 插件
# set showmode

# 水平切割窗口时，默认在右边显示新窗口
set splitright

# 垂直切割窗口时，默认在下边显示新窗口
set splitbelow

# 设置分隔符可视
set listchars=tab:│\ ,leadmultispace:\|\ \ \ ,trail:·,extends:>,precedes:<

# 窗口分割符
# set fillchars+=vert:‖
set fillchars+=vert:\ 

if has('win32') || has('win64') || has('win32unix')
	set guifont=Consolas:h12	# 设置字体字号
elseif has('mac') || has('macunix')
	set macligatures

	# set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h13
	# set guifont=FiraCodeNerdFontComplete-Regular:h16
	set guifont=JetBrainsMonoNF-Regular:h13
elseif has('unix')
	# 设置连字显示
	set guiligatures=!\"$%&\'()*+,-./:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{\|}~

	# set guifont=FiraCode\ Nerd\ Font\ 11
	set guifont=JetBrainsMono\ Nerd\ Font\ 11
	# set guifont=VictorMono\ Nerd\ Font\ 11
endif


#----------------------------------------------------------------------
# 颜色主题：色彩文件位于 colors 目录中
#----------------------------------------------------------------------

# 设置黑色背景
set background=dark

# enable true color
if has("termguicolors")
	set termguicolors
	&t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
	&t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif

# 设置颜色主题，会在所有 runtimepaths 的 colors 目录寻找同名配置
try
	colorscheme onedark
catch
	try
		colorscheme tomorrow
	catch
		try
			colorscheme monokai
		catch
			colorscheme default
		endtry
	endtry
endtry

#----------------------------------------------------------------------
# 状态栏设置
#----------------------------------------------------------------------

set statusline=											# 清空状态栏
set statusline+=\ %t									# 文件名
set statusline+=\ [%M%n%R%H]							# buffer 编号和状态
set statusline+=%=										# 向右对齐
set statusline+=\ %0([%Y,%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %v:%l/%L%)		# 文件类型

#----------------------------------------------------------------------
# 图形界面设置
#----------------------------------------------------------------------

if has('gui_running')
	set guioptions-=T		 # 关闭工具栏
	set guioptions-=m		 # 关闭菜单栏
	set guioptions-=r		 # 关闭右侧滚动条
	set guioptions-=R		 # 关闭右侧智能滚动条
	set guioptions-=l		 # 关闭左侧滚动条
	set guioptions-=L		 # 关闭左侧智能滚动条
endif

#----------------------------------------------------------------------
# 更改样式
#----------------------------------------------------------------------

# 更清晰的错误标注：默认一片红色背景，语法高亮都被搞没了
# 只显示红色或者蓝色下划线或者波浪线

hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! clear SpellLocal
if has('gui_running')
	hi! SpellBad gui=undercurl guisp=red
	hi! SpellCap gui=undercurl guisp=blue
	hi! SpellRare gui=undercurl guisp=magenta
	hi! SpellRare gui=undercurl guisp=cyan
else
	hi! SpellBad term=standout ctermfg=1 term=underline cterm=underline
	hi! SpellCap term=underline cterm=underline
	hi! SpellRare term=underline cterm=underline
	hi! SpellLocal term=underline cterm=underline
endif

if g:colors_name == 'monokai'
	hi LineNr				guibg=#1b1c17
	hi SpecialKey		guibg=NONE
	hi EndOfBuffer	guifg=#272822 guibg=#272822
	hi Error				guifg=pink    guibg=NONE
	hi ErrorMsg			guifg=pink    guibg=NONE
	hi WarnningMsg	guifg=pink    guibg=NONE

	# hi! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
	# hi! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray
elseif g:colors_name == 'dessert'
	# 去掉 sign column 的白色背景
	hi! SignColumn guibg=NONE ctermbg=NONE

	# 修改行号为浅灰色，默认主题的黄色行号很难看，换主题可以仿照修改
	highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
		\ gui=NONE guifg=DarkGrey guibg=NONE
	# 修正补全目录的色彩：默认太难看
	hi! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
	hi! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray
elseif g:colors_name == 'onedark'
	# 将默认青色的 virtual text 设置为一个低调点的颜色
	hi CocInlayHint guifg=#5F789A
endif


#----------------------------------------------------------------------
# 终端设置，隐藏行号和侧边栏
#----------------------------------------------------------------------
if has('terminal') && exists(':terminal') == 2
	if exists('##TerminalOpen')
		augroup VimUnixTerminalGroup
			au! 
			au TerminalOpen * setlocal nonumber signcolumn=no
		augroup END
	endif
endif


#----------------------------------------------------------------------
# quickfix 设置，隐藏行号
#----------------------------------------------------------------------
augroup VimInitStyle
	au!
	au FileType qf setlocal nonumber
augroup END


#----------------------------------------------------------------------
# 标签栏文字风格：默认为零，GUI 模式下空间大，按风格 3显示
# 0: filename.txt
# 1: 1 - filename.txt
# 2: [1] filename.txt
#----------------------------------------------------------------------
if has('gui_running')
	var config_vim_tab_style = 0
endif


# 终端下的 tabline
def Vim_NeatTabLine(): string
	var s = ''
	for i in range(tabpagenr('$'))
		# select the highlighting
		if i + 1 == tabpagenr()
			s .= '%#TabLineSel#'
		else
			s .= '%#TabLine#'
		endif

		# set the tab page number (for mouse clicks)
		s .= '%' . (i + 1) . 'T'

		# the label is made by MyTabLabel()
		s .= ' %{Vim_NeatTabLabel(' . (i + 1) . ')} '
	endfor

	# after the last tab fill with TabLineFill and reset tab page nr
	s .= '%#TabLineFill#%T'

	# right-align the label to close the current tab page
	if tabpagenr('$') > 1
		s .= '%=%#TabLine#%999XX'
	endif

	return s
enddef

# 需要显示到标签上的文件名
def Vim_NeatBuffer(bufnr: any, fullname: any): string
	var name = bufname(bufnr)
	if getbufvar(a:bufnr, '&modifiable')
		if name == ''
			return '[No Name]'
		endif
		if fullname 
			return fnamemodify(name, ':p')
		endif
		var aname = fnamemodify(name, ':p')
		var sname = fnamemodify(aname, ':t')
		if sname == ''
			var test = fnamemodify(aname, ':h:t')
			if test
				return '<' .. test .. '>'
			endif
		endif
		return sname
	endif

	# var buftype = getbufvar(bufnr, '&buftype')
	if getbufvar(bufnr, '&buftype') == 'quickfix'
		return '[Quickfix]'
	if name != ''
		if fullname 
			return '-' .. fnamemodify(name, ':p')
		else
			return '-' .. fnamemodify(name, ':t')
		endif
	# else
	endif
	return '[No Name]'
enddef

# GUI 下的标签文字，使用 [1] filename 的模式
def Vim_NeatGuiTabLabel(): string
	var num = v:lnum
	var buflist = tabpagebuflist(num)
	var winnr = tabpagewinnr(num)
	var bufnr = buflist[winnr - 1]
	var fname = Vim_NeatBuffer(bufnr, 0)
	var style = get(s:, 'config_vim_tab_style', 0)
	if style == 0
		return fname
	elseif style == 1
		return "[" .. num .. "] " .. fname
	elseif style == 2
		return "" .. num .. " - " .. fname
	endif
	if getbufvar(bufnr, '&modified')
		return "[" .. num .. "] " .. fname .. " +"
	endif
	return "[" .. num .. "] " .. fname
enddef

# 设置 GUI 标签的 tips: 显示当前标签有哪些窗口
def Vim_NeatGuiTabTip(): string
	var tip = ''
	for bufnr in tabpagebuflist(v:lnum)
		# Separate buffer entries
		if tip != ''
			tip .= " \n"
		endif
		# Add name of buffer
		tip .= Vim_NeatBuffer(bufnr, 1)
		# Add modified/modifiable flags
		if getbufvar(bufnr, "&modified")
			tip .= ' [+]'
		endif
		if !getbufvar(bufnr, "&modifiable")
			tip .= ' [-]'
		endif
	endfor
	return tip
enddef

#----------------------------------------------------------------------
# 标签栏最终设置
#----------------------------------------------------------------------

# set tabline=%!Vim_NeatTabLine()
# if has('gui_running')
# 	set guitablabel=%{Vim_NeatGuiTabLabel()}
# 	set guitabtooltip=%{Vim_NeatGuiTabTip()}
# endif

#----------------------------------------------------------------------
# 光标显示设置
#----------------------------------------------------------------------

if has('gui_running')	 # 更改光标显示方式
	set guicursor=n-v-ve-o:block-Cursor/lCursor-blinkwait0,
		\i-c-ci:ver25-Cursor/lCursor-blinkwait500-blinkoff500-blinkon900,
		\r-cr:hor30-Cursor/lCursor-blinkwait500-blinkoff500-blinkon900,
		\sm:block-Cursor/lCursor-blinkwait500-blinkoff500-blinkon900
else
	# set guicursor=n-v-c-o-sm:block,i-ci:hor15,r-cr:hor40
	&t_SR = "\e[4 q"
	&t_SI = "\e[6 q"
	&t_EI = "\e[2 q"
endif

def g:SynGroup()
	var s = synID(line('.'), col('.'), 1)
	echo synIDattr(s, 'name') .. ' -> ' .. synIDattr(synIDtrans(s), 'name')
enddef
