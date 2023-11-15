vim9script
scriptencoding utf-8

var plug_pos = ''
if g:Win
	plug_pos = '$VIM/vimfiles/plugs'
	# var plug_copy_command = 'copy "'.$VIM.'\vimfiles\plugs\vim-plug\plug.vim" "'.$VIM.'\vimfiles\autoload\"'
elseif g:Unix || g:Mac
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
Plug 'luochen1990/rainbow'

# start up""""""""""""""""""""
Plug 'mhinz/vim-startify'

# popup window""""""""""""""""""""
Plug 'skywind3000/vim-quickui'

# fuzzy finder""""""""""""""""""""
Plug 'liuchengxu/vim-clap' #, { 'do': ':Clap install-binary' }
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

# Interactive Debugger
Plug 'puremourning/vimspector'

#comment
Plug 'tpope/vim-commentary'

# filetypes
Plug 'solarnz/thrift.vim'
Plug 'wfxr/protobuf.vim'
Plug 'florentc/vim-tla'

# Spell Check
Plug 'psliwka/vim-dirtytalk', { 'do': ':DirtytalkUpdate' }

Plug 'github/copilot.vim'

plug#end()

#""""""""""""""""""""""""""""""""""""""""""""""""""
# Easymotion """"""""""""""""""""""""""""""""""""""

if has_key(g:plugs, 'vim-easymotion')
	# disable all default mappings
	g:EasyMotion_do_mapping = 0
	g:EasyMotion_smartcase = 1
	g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ:;'
	g:EasyMotion_startofline = 0
endif

#""""""""""""""""""""""""""""""""""""""""""""""""""
# Vista """""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'vista.vim')
	g:vista_default_executive = 'coc'
	g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
	g:vista_blink = [1, 100]
	# Set the executive for some filetypes explicitly. Use the explicit executive
	# instead of the default one for these filetypes when using `:Vista` without
	# specifying the executive.
	g:vista_executive_for = {
		'markdown': 'toc',
		'go': 'coc',
	}

	g:vista#renderer#icons = {
      'var': "\uf0ae7",
      'variable': "\uf0ae7",
      'variables': "\uf0ae7",
      'const': "\uf0400",
      'constant': "\uf0400",
      'constructor': "\uf0476",
      'method': "\uf01a8",
      'module': "\uf1b3",
      'modules': "\uf1b3",
      'type': "\uf0b1b",
      'typedef': "\uf0b1b",
      'types': "\uf0b1b",
      'macro': "\uf0f6d",
      'macros': "\uf0f6d",
      'class': "\uf01a7",
      'struct': "\uf01a6",
      'member': "\uf02b",
      'target': "\uf04fe",
      'property': "\uf05b7",
	}

endif

#""""""""""""""""""""""""""""""""""""""""""""""""""""
# Coc.nvim """""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'coc.nvim')
	# highlight symbol under the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

	# Add `:Format` command to format current buffer
	command! -nargs=0 Format :call CocActionAsync('format')

	# Add `:Fold` command to fold current buffer
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	# Add `:OR` command for organize imports of the current buffer
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
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

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# OneDark """"""""""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'onedark.vim')
	g:onedark_terminal_italics = 1
endif

# Vimspector """"""""""""""""""""""""""""""""""""""""""""""
g:vimspector_enable_mappings = 'HUMAN'


# Rainbow """""""""""""""""""""""""""""""""""""""""""""""""""
g:rainbow_active = 1
g:rainbow_conf = {
	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	'guis': [''],
	'cterms': [''],
	'operators': '_,_',
	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	'separately': {
		'*': {},
		'markdown': {
			'parentheses_options': 'containedin=markdownCode contained', # enable rainbow for code blocks only
		},
		'lisp': {
			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'], # lisp needs more colors for parentheses :)
		},
		'haskell': {
			'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'], #the haskell lang pragmas should be excluded
		},
		'vim': {
			'parentheses_options': 'containedin=vimFuncBody', #enable rainbow inside vim function body
		},
		'perl': {
			'syn_name_prefix': 'perlBlockFoldRainbow', #solve the [perl indent-depending-on-syntax problem](https://github.com/luochen1990/rainbow/issues/20)
		},
		'stylus': {
			'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'], # [vim css color](https://github.com/ap/vim-css-color) compatibility
		},
		'css': 0, #disable this plugin for css files
		'nerdtree': 0, #rainbow is conflicting with NERDTree, creating extra parentheses
	}
}
