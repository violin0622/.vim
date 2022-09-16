setlocal sw=2 ts=2 sts=2 et
setlocal indentexpr=GetYAMLIndent(v:lnum)
setlocal indentkeys=!^Fo,O,0#,<:>,-
setlocal nosmartindent

function GetYAMLIndent(lnum)
  let prevlnum = prevnonblank(a:lnum - 1)
  if prevlnum == 0
    return 0
  endif
  let prevline = getline(prevlnum)

  let indent = indent(prevlnum)
  let increase = indent + &sw

  " Do not adjust indentation for comments
  if prevline =~ '\%(^\|\s\)#'
    return indent
  elseif prevline =~ ':\s*[>|]?$'
    return increase
  elseif prevline =~ ':$'
    return increase
  elseif prevline =~ '^\s*-\s*$'
    return increase
  elseif prevline =~ '^\s*-\s\+[^:]\+:\s*\S'
    return increase
  else
    return indent
  endif
endfunction
