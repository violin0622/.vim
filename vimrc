vim9script

g:Win = '__win__'
g:Mac = '__mac__'
g:Unix = '__unix__'
g:GUI = '__gui__'
g:Term = '__term__'
g:vprof = {
'__win__': 0,
'__mac__': 0,
'__unix__': 0,
'__gui__': 0,
'__term__': 0,
}
if has('win32') || has('win64') || has('win32unix')
	g:vprof[g:Win] = 1
elseif has('mac') || has('macunix')
	g:vprof[g:Mac] = 1
elseif has('linux') || has('unix')
	g:vprof[g:Unix] = 1
endif
if has('gui_running')
	g:vprof[g:GUI] = 1
else
	g:vprof[g:Term] = 1
endif

# 防止重复加载
if get(s:, 'loaded', 0)
	finish
else
	var loaded = 1
endif

if g:vprof[g:Mac] && g:vprof[g:GUI]
	set shell=/bin/zsh\ -i
endif

# 取得本文件所在的目录
var home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

# 定义一个命令用来加载文件
def LoadScript(file: string)
	exec "source " .. home .. "/" .. file
enddef

LoadScript("init/basic.vim")
LoadScript("init/tabsize.vim")
LoadScript("init/keymaps.vim")
LoadScript("init/config.vim")
LoadScript("init/plugins.vim")
LoadScript("init/style.vim")


