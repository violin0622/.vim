if has('win32') || has('win64') || has('win32unix')
	let plug_position = '$VIM/vimfiles/plugs'
	let plug_copy_command = 'copy "'.$VIM.'\vimfiles\plugs\vim-plug\plug.vim" "'.$VIM.'\vimfiles\autoload\"'
elseif has('unix') || has('mac') || has ('macunix')
	let plug_position = '~/.vim/plugs'
	let plug_copy_command = 'cp ~/.vim/plugs/vim-plug/plug.vim ~/.vim/autoload/'
endif

" automatically install Plug.vim
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin(plug_position)
"Plug 'junegunn/vim-plug',{'do': plug_copy_command}

" Language support """"""""""""""""""""""""""
"Plug 'sheerun/vim-polyglot'

" Chinese Document""""""""""""""""""""""""""""
Plug 'yianwillis/vimcdoc'

" Key mapping suggestion
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

"colorschemes""""""""""""""""""""
Plug 'crusoexia/vim-monokai'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'joshdick/onedark.vim'

" status line""""""""""""""""""""
Plug 'vim-airline/vim-airline'

" Markdown""""""""""""""""""""
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" aligin""""""""""""""""""""""
Plug 'junegunn/vim-easy-align'

"Plug 'wakatime/vim-wakatime'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'

" start up""""""""""""""""""""
Plug 'mhinz/vim-startify'

" popup window""""""""""""""""""""
Plug 'skywind3000/vim-quickui'

" fuzzy finder""""""""""""""""""""
Plug 'liuchengxu/vim-clap'

" buffer manage""""""""""""""""""""
Plug 'Asheq/close-buffers.vim'

" smooth scrolling"""""""""""""""""
"Plug 'psliwka/vim-smoothie'

"code enhance""""""""""""""""""""
Plug 'Dimercel/todo-vim'

" outliner
Plug 'liuchengxu/vista.vim'

"completion and lsp support
Plug 'neoclide/coc.nvim', {'branch':'release'}

"comment
Plug 'tpope/vim-commentary'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-easymotion configration"""""""""""""""""""""""

" disable all default mappings
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ:;'
let g:EasyMotion_startofline = 0

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
"map <Leader>w <Plug>(easymotion-w)
"map <Leader>e <Plug>(easymotion-e)
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

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Vista """""""""""""""""""""""""""""""""""""""""""
let g:vista_default_executive = 'coc'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
	\ 'markdown': 'toc',
	\ 'go': 'coc',
	\ }

let g:vista_blink = [1,100]
if has('mac') || has('macunix')
	nnoremap <silent><D-7> :Vista!!<CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc exlorer """""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'coc.nvim')
" window mappings
	noremap <silent><d-1> :CocCommand explorer<CR>

	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gD <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references-used)
	nmap <silent> gy :call CocActionAsync('jumpDefinition', v:false)<CR>
	nmap <silent> gn <Plug>(coc-rename)

" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		elseif (coc#rpc#ready())
			call CocActionAsync('doHover')
		else
			execute '!' . &keywordprg . " " . expand('<cword>')
		endif
	endfunction

	"" highlight symbol under the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Witch-Key """""""""""""""""""""""""""""""""""""""
autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" AirLine """""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'vim-airline')
	let g:airline_experimental = 1
	let g:airline_detect_iminsert=0
	let g:airline_exclude_preview = 0
	let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
	let g:airline_stl_path_style = 'short'
	let g:airline_left_sep = ''
	let g:airline_right_sep = ''
	let g:airline#extensions#tabline#fnamemod = ':p:.'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commentary """""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'vim-commentary')
	silent! unmap gc
	silent! unmap gcc
	silent! unmap gcu
	map <Leader>/ <Plug>Commentary
	map <Leader>// <Plug>CommentaryLine
endif
