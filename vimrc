vim9script

# 防止重复加载
if get(s:, 'loaded', 0) != 0
	finish
else
	var loaded = 1
endif

# 取得本文件所在的目录
var home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

# 定义一个命令用来加载文件
#command! -nargs=1 LoadScript exec 'source ' .. home .. '/' .. <args>

def LoadScript(file: string)
	exec "source " .. home .. "/" .. file
enddef

LoadScript("init/basic.vim")
#LoadScript("init/config.vim")
LoadScript("init/tabsize.vim")
LoadScript("init/keymaps.vim")
LoadScript("init/plugins.vim")
LoadScript("init/style.vim")

g:node_client_debug = 1
$NODE_CLIENT_LOG_FILE = '~/Workspace/log'
