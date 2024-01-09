vim9script

g:Mac = 0
g:Win = 0
g:Unix = 0
g:GUI = 0
g:Term = 0

if has('win32') || has('win64') || has('win32unix')
	g:Win = 1
elseif has('mac') || has('macunix')
	g:Mac = 1
elseif has('linux') || has('unix')
	g:Unix = 1
endif
if has('gui_running')
	g:GUI = 1
else
	g:Term = 1
endif

# 防止重复加载
if get(s:, 'loaded', 0)
	finish
else
	var loaded = 1
endif

# 取得本文件所在的目录
var home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

# 定义一个命令用来加载文件
def LoadScript(file: string)
	exec "source " .. home .. "/" .. file
enddef

LoadScript("init/basic.vim")
LoadScript("init/tabsize.vim")
LoadScript("init/config.vim")
LoadScript("init/plugins.vim")
LoadScript("init/keymaps.vim")
LoadScript("init/style.vim")


