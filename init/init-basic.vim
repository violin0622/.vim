"======================================================================
"
" init-basic.vim - 基础配置，该配置需要兼容 vim tiny 模式
"
" 所有人都能接受的配置，不掺渣任何 keymap, 和偏好设置
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 16:53:18
"
"======================================================================

"----------------------------------------------------------------------
" 基础设置
"----------------------------------------------------------------------

" 禁用 vi 兼容模式
set nocompatible

" 禁用报警铃
set noerrorbells
set belloff=all

" 自动载入文件变更
set autoread

" 处理未保存或只读文件时弹出确认
set noconfirm

" 可以不保存即切换buff
set hidden

" 自动切换工作路径
set autochdir

" Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
set winaltkeys=no

" 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
set ttimeout

" 功能键超时检测 50 毫秒
set ttimeoutlen=50

" 使用鼠标定位
set mouse+=a

"----------------------------------------------------------------------
" 编辑设置
"----------------------------------------------------------------------

" 错误格式
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m

" 设置分隔符可视
set listchars=tab:\|\ ,trail:·,extends:>,precedes:<

" 合并两行中文时，不在中间加空格
set formatoptions+=B

" 文件换行符，默认使用 unix 换行符
set ffs=unix,dos,mac

" 与系统剪贴板兼容
if vim_env.os == 'windows' || vim_env.os == 'mac'
	set clipboard+=unnamed
endif

" 显示匹配的括号
set showmatch

" 匹配高亮尖括号
set mps+=<:>

" 显示括号匹配的时间
set matchtime=2

" 关闭自动折行
set nowrap

" 单词折行
set linebreak

"光标移动可以跨行（仅限 Normal 和 Visual 模式）
set whichwrap+=>,h,l,<

"退格键可以跨行
set backspace=indent,eol,start

" 设置缩进宽度
"set sw=4

" 设置 TAB 宽度
"set ts=4

" 禁止展开 tab (noexpandtab)
"set noexpandtab

" 如果后面设置了 expandtab 那么展开 tab 为多少字符
"set softtabstop=4

"----------------------------------------------------------------------
" 备份设置
"----------------------------------------------------------------------

" 禁止备份
set nobackup

" 保存时备份
"set writebackup

" 备份文件地址，统一管理
"set backupdir=~/.vim/tmp

" 备份文件扩展名
"set backupext=.bak

" 禁用交换文件
"set noswapfile

" 禁用 undo文件
"set noundofile

" 创建目录，并且忽略可能出现的警告
"silent! call mkdir(expand('~/.vim/tmp'), "p", 0755)

"----------------------------------------------------------------------
" 搜索设置
"----------------------------------------------------------------------

" 搜索时忽略大小写
set ignorecase

" 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase

" 高亮搜索内容
set hlsearch

" 查找输入时动态增量显示查找结果
set incsearch

"----------------------------------------------------------------------
" 编码设置
"----------------------------------------------------------------------
if has('multi_byte')
	" 内部工作编码
	set encoding=utf-8

	" 文件默认编码
	set fileencoding=utf-8

	" 打开文件时自动尝试下面顺序的编码
	set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1
endif


"----------------------------------------------------------------------
" 缩进设置
"----------------------------------------------------------------------

" 打开 C/C++ 语言缩进优化
set cindent

" 自动缩进
set autoindent

set smarttab

if has('autocmd')
	filetype plugin indent on
endif


"----------------------------------------------------------------------
" 语法高亮设置
"----------------------------------------------------------------------
if has('syntax')
	syntax enable
	syntax on
endif


"----------------------------------------------------------------------
" 其他设置
"----------------------------------------------------------------------

" 显示最后一行
set display=lastline

" 允许下方显示目录
set wildmenu

" 延迟绘制（提升性能）
set lazyredraw


" 设置 tags：当前文件所在目录往上向根目录搜索直到碰到 .tags 文件
" 或者 Vim 当前目录包含 .tags 文件
set tags=./.tags;,.tags

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m


"----------------------------------------------------------------------
" 设置代码折叠
"----------------------------------------------------------------------
if has('folding')
	" 允许代码折叠
	set foldenable

	" 代码折叠默认使用缩进
	set fdm=indent

	" 默认打开所有缩进
	set foldlevel=99
endif


"----------------------------------------------------------------------
" 文件搜索和补全时忽略下面扩展名
"----------------------------------------------------------------------
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
