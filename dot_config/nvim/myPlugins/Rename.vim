vim9script

# Rename.vim  -  Rename a buffer within Vim and on the disk
#
# Copyright June 2007-2022 by Christian J. Robinson <heptite@gmail.com>
#
# Distributed under the terms of the Vim license.  See ":help license".
#
# Usage:
#
# :Rename[!] {newname}

command! -nargs=1 -complete=file -bang Rename {
		g:Rename(<q-args>, '<bang>')
	}

def g:Rename(name: string, bang: string): bool
	var oldfile = expand('%:p')
	var status: bool

	if bufexists(fnamemodify(name, ':p'))
		if (bang ==# '!')
			silent exe ':' .. bufnr(fnamemodify(name, ':p')) .. 'bwipe!'
		else
			echohl ErrorMsg
			echomsg 'A buffer with that name already exists (use ! to override).'
			echohl None
			return false
		endif
	endif

	status = true

	v:errmsg = ''
	silent! exe 'silent! saveas' .. bang .. ' ' .. name

	if v:errmsg =~# '^$\|^E329'
		var lastbufnr = bufnr('$')

		if expand('%:p') !=# oldfile && filewritable(expand('%:p'))
			if fnamemodify(bufname(lastbufnr), ':p') ==# oldfile
				silent exe ':' .. lastbufnr .. 'bwipe!'
			else
				echohl ErrorMsg
				echomsg 'Could not wipe out the old buffer for some reason.'
				echohl None
				status = false
			endif

			if delete(oldfile) != 0
				echohl ErrorMsg
				echomsg 'Could not delete the old file: ' .. oldfile
				echohl None
				status = false
			endif
		else
			echohl ErrorMsg
			echomsg 'Rename failed for some reason.'
			echohl None
			status = false
		endif
	else
		echoerr v:errmsg
		status = false
	endif

	return status
enddef
