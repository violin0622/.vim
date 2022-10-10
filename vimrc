"======================================================================
"
" init.vim - initialize config
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 18:26:34
"
"======================================================================

" 防止重复加载
"if get(g:, 'vimrc_loaded', 0) != 0
"	finish
"endif

" 探测并设定 Vim 运行环境
let g:vim_env = 
            \{ 
            \'os':'',
            \'running':'',
            \'version': v:version,
            \}

if has("win32") || has("win64") || has ("win32unix")
	let g:vim_env.os = 'win'
elseif has('mac') || has('macunix')
	let g:vim_env.os = 'mac'
elseif has('unix')
	let g:vim_env.os = 'unix'
endif

if has('gui_running')
	let g:vim_env.running = 'gui'
else
	let g:vim_env.running = 'terminal'
endif

" 取得本文件所在的目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" 将 vim-init 目录加入 runtimepath
exec 'set rtp+='.s:home
" 将 ~/.vim 目录加入 runtimepath (有时候 vim 不会自动帮你加入）
set rtp+=~/.vim

if has('autocmd') " Remain compatible with earlier versions
	augroup vimrc     " Source vim configuration upon save
		autocmd! BufWritePost $MYVIMRC,~/.vim/init/*.vim source $MYVIMRC | echom "重新载入 " . $MYVIMRC | redraw
	augroup END
endif " has autocmd


"----------------------------------------------------------------------
" 模块加载
"----------------------------------------------------------------------

"" 定义一个命令用来加载文件
command! -nargs=1 LoadScript exec 'so '.s:home.'/'.'<args>'
"
"" 加载基础配置
LoadScript init/init-basic.vim
"
"" 加载扩展配置
LoadScript init/init-config.vim
"
"" 设定 tabsize
"LoadScript init/init-tabsize.vim
"
"" 插件加载
LoadScript init/init-plugins.vim
"
"" 界面样式
LoadScript init/init-style.vim
"
"" 自定义按键
LoadScript init/init-keymaps.vim
