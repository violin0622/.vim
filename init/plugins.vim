vim9script

#if has('win32') || has('win64') || has('win32unix')
var plug_pos = ''
if g:vprof[g:Win]
	plug_pos = '$VIM/vimfiles/plugs'
	# var plug_copy_command = 'copy "'.$VIM.'\vimfiles\plugs\vim-plug\plug.vim" "'.$VIM.'\vimfiles\autoload\"'
#elseif has('unix') || has('mac') || has('macunix')
elseif g:vprof[g:Unix] || g:vprof[g:Mac]
	plug_pos = '~/.vim/plugs'
	# var plug_copy_command = 'cp ~/.vim/plugs/vim-plug/plug.vim ~/.vim/autoload/'
endif

# automatically install Plug.vim
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

plug#begin(plug_pos)
# Chinese Document""""""""""""""""""""""""""""
Plug 'yianwillis/vimcdoc'

# Key mapping suggestion
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'crusoexia/vim-monokai'
#Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'

# status line""""""""""""""""""""
Plug 'vim-airline/vim-airline'

# Markdown""""""""""""""""""""
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

# aligin""""""""""""""""""""""
Plug 'junegunn/vim-easy-align'

#Plug 'wakatime/vim-wakatime'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'

# start up""""""""""""""""""""
Plug 'mhinz/vim-startify'

# popup window""""""""""""""""""""
Plug 'skywind3000/vim-quickui'

# fuzzy finder""""""""""""""""""""
Plug 'liuchengxu/vim-clap'

# buffer manage""""""""""""""""""""
Plug 'Asheq/close-buffers.vim'

# smooth scrolling"""""""""""""""""
#Plug 'psliwka/vim-smoothie'

#code enhance""""""""""""""""""""
Plug 'Dimercel/todo-vim'

# outliner
Plug 'liuchengxu/vista.vim'

#completion and lsp support
Plug 'neoclide/coc.nvim', {'branch':'release'}

#comment
Plug 'tpope/vim-commentary'

plug#end()

#""""""""""""""""""""""""""""""""""""""""""""""""""
#" vim-easymotion configration"""""""""""""""""""""""

# disable all default mappings
g:EasyMotion_do_mapping = 0
g:EasyMotion_smartcase = 1
g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ:;'
g:EasyMotion_startofline = 0

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

#""""""""""""""""""""""""""""""""""""""""""""""""""
# Vista """""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'vista.vim')
	g:vista_default_executive = 'coc'

	# Set the executive for some filetypes explicitly. Use the explicit executive
	# instead of the default one for these filetypes when using `:Vista` without
	# specifying the executive.
	g:vista_executive_for = {
		'markdown': 'toc',
		'go': 'coc',
	}

	g:vista_blink = [1, 100]
	if g:vprof[g:Mac]
		nmap <silent><D-2> :Vista!!<CR>
	else
		nmap <silent><M-2> :Vista!!<CR>
	endif
# if has('mac') || has('macunix')
# 	nmap <silent><D-2> :Vista!!<CR>
# elseif has('unix')
# 	if has('gui_running')
# 		nmap <silent><M-2> :Vista!!<CR>
# 	else
# 		nmap <silent>2 :Vista!!<CR>
# 	endif
# endif
endif
#""""""""""""""""""""""""""""""""""""""""""""""""""""
# Coc exlorer """""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'coc.nvim')
# window mappings

	if g:vprof[g:Mac]
		nmap <silent><D-1> :CocCommand explorer<CR>
	else
		nmap <silent><M-1> :CocCommand explorer<CR>
	endif

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

	#function! s:show_documentation()
	#	if (index(['vim','help'], &filetype) >= 0)
	#		execute 'h '.expand('<cword>')
	#	elseif (coc#rpc#ready())
	#		call CocActionAsync('doHover')
	#	else
	#		execute '!' . &keywordprg . " " . expand('<cword>')
	#	endif
	#endfunction

	def CheckBackspace(): bool
		var col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	enddef

	#function! CheckBackspace() abort
	#  let col = col('.') - 1
	#  return !col || getline('.')[col - 1]  =~# '\s'
	#endfunction

	# highlight symbol under the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

	# Add `:Format` command to format current buffer
	command! -nargs=0 Format :call CocActionAsync('format')

	# Add `:Fold` command to fold current buffer
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	# Add `:OR` command for organize imports of the current buffer
	command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
endif

#""""""""""""""""""""""""""""""""""""""""""""""""""""
#" Vim-Witch-Key """""""""""""""""""""""""""""""""""""""
autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

#""""""""""""""""""""""""""""""""""""""""""""""""""""
#" AirLine """""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'vim-airline')
	g:airline_experimental = 1
	g:airline_detect_iminsert = 0
	g:airline_exclude_preview = 0
	g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
	g:airline_stl_path_style = 'short'
	g:airline_left_sep = ''
	g:airline_right_sep = ''
	g:airline#extensions#tabline#fnamemod = ':p:.'
endif

#""""""""""""""""""""""""""""""""""""""""""""""""""""
#" Commentary """""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'vim-commentary')
	silent! unmap gc
	silent! unmap gcc
	silent! unmap gcu
	map <Leader>/ <Plug>Commentary
	map <Leader>// <Plug>CommentaryLine
endif

if has_key(g:plugs, 'todo-vim')
	if has('mac') || has('macunix')
		nnoremap <silent><D-3> :TODOToggle<CR>
	elseif has('unix')
		if has('gui_running')
			nnoremap <silent><M-3> :TODOToggle<CR>
		else
			nnoremap <silent>3 :TODOToggle<CR>
		endif
	endif
endif

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# OneDark """"""""""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'onedark.vim')
	g:onedark_terminal_italics = 1
endif
