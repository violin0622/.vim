"======================================================================
"
" init-style.vim - 显示样式设置
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 20:29:07
"
"======================================================================


"----------------------------------------------------------------------
" 显示设置
"----------------------------------------------------------------------

" 总是显示状态栏
set laststatus=2

" 总是显示行号
set number

" 显示光标位置
set ruler

" 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set signcolumn=auto

" 智能显示标签栏
set showtabline=1

" 设置显示制表符等隐藏字符
set list

" 右下角显示命令
set showcmd

" 插入模式在状态栏下面显示 -- INSERT --，
" 先注释掉，默认已经为真了，如果这里再设置一遍会影响 echodoc 插件
" set showmode

" 水平切割窗口时，默认在右边显示新窗口
set splitright

" 垂直切割窗口时，默认在下边显示新窗口
set splitbelow

if has('win32') || has('win64') || has('win32unix')
	set guifont=Consolas:h12	"设置字体字号
elseif has('mac') || has('macunix')
		"set macligatures
		"set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h13
		set guifont=FiraCodeNerdFontComplete-Regular:h16
elseif has('unix')
	set guifont=FiraCode\ Nerd\ Font\ 11
endif

" 设置连字显示
set guiligatures=!\"$%&\'()*+,-./:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{\|}~

"----------------------------------------------------------------------
" 颜色主题：色彩文件位于 colors 目录中
"----------------------------------------------------------------------

" 设置黑色背景
set background=dark

if has("termguicolors")
    	" enable true color
    	set termguicolors
endif

" 设置颜色主题，会在所有 runtimepaths 的 colors 目录寻找同名配置
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
" colorscheme monokai

"----------------------------------------------------------------------
" 状态栏设置
"----------------------------------------------------------------------
set statusline=											" 清空状态栏
set statusline+=\ %t										" 文件名
set statusline+=\ [%M%n%R%H]									" buffer 编号和状态
set statusline+=%=										" 向右对齐
set statusline+=\ %0([%Y,%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %v:%l/%L%)		" 文件类型

"----------------------------------------------------------------------
" 图形界面设置
"----------------------------------------------------------------------
if has('gui_running')
	set guioptions-=T		 "关闭工具栏
	set guioptions-=m		 "关闭菜单栏
	set guioptions-=r		 "关闭右侧滚动条
	set guioptions-=R		 "关闭右侧智能滚动条
	set guioptions-=l		 "关闭左侧滚动条
	set guioptions-=L		 "关闭左侧智能滚动条
endif

"----------------------------------------------------------------------
" 更改样式
"----------------------------------------------------------------------

" 更清晰的错误标注：默认一片红色背景，语法高亮都被搞没了
" 只显示红色或者蓝色下划线或者波浪线

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

	" hi! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
	" hi! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray
elseif g:colors_name == 'dessert'
	" 去掉 sign column 的白色背景
	hi! SignColumn guibg=NONE ctermbg=NONE

	" 修改行号为浅灰色，默认主题的黄色行号很难看，换主题可以仿照修改
	highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
		\ gui=NONE guifg=DarkGrey guibg=NONE
	" 修正补全目录的色彩：默认太难看
	hi! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
	hi! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray
endif


"----------------------------------------------------------------------
" 终端设置，隐藏行号和侧边栏
"----------------------------------------------------------------------
if has('terminal') && exists(':terminal') == 2
	if exists('##TerminalOpen')
		augroup VimUnixTerminalGroup
			au! 
			au TerminalOpen * setlocal nonumber signcolumn=no
		augroup END
	endif
endif


"----------------------------------------------------------------------
" quickfix 设置，隐藏行号
"----------------------------------------------------------------------
augroup VimInitStyle
	au!
	au FileType qf setlocal nonumber
augroup END


"----------------------------------------------------------------------
" 标签栏文字风格：默认为零，GUI 模式下空间大，按风格 3显示
" 0: filename.txt
" 1: 1 - filename.txt
" 2: [1] filename.txt
"----------------------------------------------------------------------
if has('gui_running')
	let g:config_vim_tab_style = 0
endif


"----------------------------------------------------------------------
" 终端下的 tabline
"----------------------------------------------------------------------
function! Vim_NeatTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		" select the highlighting
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif

		" set the tab page number (for mouse clicks)
		let s .= '%' . (i + 1) . 'T'

		" the label is made by MyTabLabel()
		let s .= ' %{Vim_NeatTabLabel(' . (i + 1) . ')} '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'

	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let s .= '%=%#TabLine#%999XX'
	endif

	return s
endfunc


"----------------------------------------------------------------------
" 需要显示到标签上的文件名
"----------------------------------------------------------------------
function! Vim_NeatBuffer(bufnr, fullname)
	let l:name = bufname(a:bufnr)
	if getbufvar(a:bufnr, '&modifiable')
		if l:name == ''
			return '[No Name]'
		else
			if a:fullname 
				return fnamemodify(l:name, ':p')
			else
				let aname = fnamemodify(l:name, ':p')
				let sname = fnamemodify(aname, ':t')
				if sname == ''
					let test = fnamemodify(aname, ':h:t')
					if test != ''
						return '<'. test . '>'
					endif
				endif
				return sname
			endif
		endif
	else
		let l:buftype = getbufvar(a:bufnr, '&buftype')
		if l:buftype == 'quickfix'
			return '[Quickfix]'
		elseif l:name != ''
			if a:fullname 
				return '-'.fnamemodify(l:name, ':p')
			else
				return '-'.fnamemodify(l:name, ':t')
			endif
		else
		endif
		return '[No Name]'
	endif
endfunc


"----------------------------------------------------------------------
" 标签栏文字，使用 [1] filename 的模式
"----------------------------------------------------------------------
function! Vim_NeatTabLabel(n)
	let l:buflist = tabpagebuflist(a:n)
	let l:winnr = tabpagewinnr(a:n)
	let l:bufnr = l:buflist[l:winnr - 1]
	let l:fname = Vim_NeatBuffer(l:bufnr, 0)
	let l:num = a:n
	let style = get(g:, 'config_vim_tab_style', 0)
	if style == 0
		return l:fname
	elseif style == 1
		return "[".l:num."] ".l:fname
	elseif style == 2
		return "".l:num." - ".l:fname
	endif
	if getbufvar(l:bufnr, '&modified')
		return "[".l:num."] ".l:fname." +"
	endif
	return "[".l:num."] ".l:fname
endfunc


"----------------------------------------------------------------------
" GUI 下的标签文字，使用 [1] filename 的模式
"----------------------------------------------------------------------
function! Vim_NeatGuiTabLabel()
	let l:num = v:lnum
	let l:buflist = tabpagebuflist(l:num)
	let l:winnr = tabpagewinnr(l:num)
	let l:bufnr = l:buflist[l:winnr - 1]
	let l:fname = Vim_NeatBuffer(l:bufnr, 0)
	let style = get(g:, 'config_vim_tab_style', 0)
	if style == 0
		return l:fname
	elseif style == 1
		return "[".l:num."] ".l:fname
	elseif style == 2
		return "".l:num." - ".l:fname
	endif
	if getbufvar(l:bufnr, '&modified')
		return "[".l:num."] ".l:fname." +"
	endif
	return "[".l:num."] ".l:fname
endfunc



"----------------------------------------------------------------------
" 设置 GUI 标签的 tips: 显示当前标签有哪些窗口
"----------------------------------------------------------------------
function! Vim_NeatGuiTabTip()
	let tip = ''
	let bufnrlist = tabpagebuflist(v:lnum)
	for bufnr in bufnrlist
		" separate buffer entries
		if tip != ''
			let tip .= " \n"
		endif
		" Add name of buffer
		let name = Vim_NeatBuffer(bufnr, 1)
		let tip .= name
		" add modified/modifiable flags
		if getbufvar(bufnr, "&modified")
			let tip .= ' [+]'
		endif
		if getbufvar(bufnr, "&modifiable")==0
			let tip .= ' [-]'
		endif
	endfor
	return tip
endfunc


"----------------------------------------------------------------------
" 标签栏最终设置
"----------------------------------------------------------------------
set tabline=%!Vim_NeatTabLine()
if has('gui_running')
	set guitablabel=%{Vim_NeatGuiTabLabel()}
	set guitabtooltip=%{Vim_NeatGuiTabTip()}
endif

"----------------------------------------------------------------------
" 光标显示设置
"----------------------------------------------------------------------
if has('gui_running')	 "更改光标显示方式
	set guicursor=n-v-ve-o:block-Cursor/lCursor-blinkwait0,
				\i-c-ci:ver25-Cursor/lCursor-blinkwait500-blinkoff500-blinkon900,
				\r-cr:hor30-Cursor/lCursor-blinkwait500-blinkoff500-blinkon900,
				\sm:block-Cursor/lCursor-blinkwait500-blinkoff500-blinkon900
else 
	set guicursor=n-v-c-o-sm:block,i-ci:hor15,r-cr:hor40
endif


function! SynGroup()
	let l:s = synID(line('.'), col('.'), 1)
	echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
