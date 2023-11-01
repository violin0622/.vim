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

if g:vprof[g:Mac]
	nnoremap <D-0> :bo term<CR>
	tnoremap <D-0> exit<CR>
else
	nnoremap <M-0> <Cmd>bo term<CR>
	tnoremap <M-0> exit<CR>
endif

#----------------------------------------------------------------------
# 插件的键映射
#----------------------------------------------------------------------

# Coc.nvim -------------------- 
if has_key(g:plugs, 'coc.nvim')
	nmap <silent><M-1> <Cmd>CocCommand explorer<CR>
	inoremap <silent><expr> <TAB>
		\ coc#pum#visible() ? coc#pum#next(1) :
		\ CheckBackspace() ? '<Tab>' :
		\ coc#refresh()
	inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : '\<C-h>'

	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gD <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references-used)
	nmap <silent> gy :call CocActionAsync('jumpDefinition', v:false)<CR>
	nmap <silent> gn <Plug>(coc-rename)
	# Use K to show documentation in preview window.
	nmap <silent> K :call <SID>ShowDocument()<CR>
	# Apply the most preferred quickfix action to fix diagnostic on the current line
	nmap <leader>qf  <Plug>(coc-fix-current)

	def ShowDocument()
		if index(['vim', 'help'], &filetype) >= 0
			execute 'h ' .. expand('<cword>')
		elseif coc#rpc#ready()
			leg call CocActionAsync('doHover')
		else
			execute '!' .. &keywordprg .. " " .. expand('<cword>')
		endif
	enddef

	def CheckBackspace(): bool
		var col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	enddef

endif

#" Commentary """""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'vim-commentary')
	silent! unmap gc
	silent! unmap gcc
	silent! unmap gcu
	map <Leader>/ <Plug>Commentary
	map <Leader>// <Plug>CommentaryLine
endif

# Todo """"""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'todo-vim')
	nnoremap <silent><M-3> <Cmd>TODOToggle<CR>
endif


# Vim Spector """"""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'vimspector')
	# for normal mode - the word under the cursor
	nmap <Leader>di <Plug>VimspectorBalloonEval
	# for visual mode, the visually selected text
	xmap <Leader>di <Plug>VimspectorBalloonEval
endif

# EasyMotion """"""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'easymotion')
	map <Leader>j <Plug>(easymotion-j)
	map <Leader>k <Plug>(easymotion-k)
	#map <Leader>w <Plug>(easymotion-w)
	#map <Leader>e <Plug>(easymotion-e)
	map <Leader>w <Plug>(easymotion-w)
	map <Leader>W <Plug>(easymotion-W)
	map <Leader>b <Plug>(easymotion-b)
	map <Leader>B <Plug>(easymotion-B)
	map <Leader>e <Plug>(easymotion-e)
	map <Leader>E <Plug>(easymotion-E)
	map <Leader>ge <Plug>(easymotion-ge)
	map <Leader>gE <Plug>(easymotion-gE)
	map <Leader>n <Plug>(easymotion-n)
	map <Leader>N <Plug>(easymotion-N)
	map <Leader>s <Plug>(easymotion-s)
	map <Leader>f <Plug>(easymotion-fl)
	map <Leader>F <Plug>(easymotion-Fl)
	map <Leader>t <Plug>(easymotion-tl)
	map <Leader>T <Plug>(easymotion-Tl)
	map <Leader>; <Plug>(easymotion-next)
	map <Leader>, <Plug>(easymotion-prev)
	nmap <Leader><Leader>j <Plug>(easymotion-overwin-line)
endif

# Vista.vim """"""""""""""""""""""""""""""""""""""""""""""

if has_key(g:plugs, 'vista.vim')
	nmap <silent><M-2> <Cmd>Vista!!<CR>
endif
