set nocompatible		" niekompatybilny z VI => wlacz bajery VIMa
set nobackup			" nie trzymaj kopii zapasowych, u¿ywaj wersji
set backspace=indent,eol,start
set viminfo='20,\"50		" read/write a .viminfo file, don't store more than 50 lines of registers
set history=50			" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch			" do incremental searching
set browsedir=buffer		" To get the File / Open dialog box to default to the current file's directory
set pastetoggle=<F9>		" przelaczanie w tryb wklejania (nie bedzie automatycznych wciec, ...)
set nonumber			" nie wyswietlaj nr linii
set number			" wszystkie bufory maja numery linii
set wildmenu			" wyswietlaj linie z menu podczas dopelniania
set showmatch			" pokaz otwieraj±cy nawias gdy wpisze zamykajacy
set so=5			" przewijaj juz na 5 linii przed koñcem
set statusline=%y[%{&ff}]\ \ ASCII=\%03.3b,HEX=\%02.2B\ %=%m%r%h%w\ %1*%F%*\ %l:%v\ (%p%%)
set laststatus=2		" zawsze pokazuj linie statusu
set fo=tcrqn			" opcje wklejania (jak maja byc tworzone wciecia itp.)
set hidden			" nie wymagaj zapisu gdy przechodzisz do nowego bufora
set foldtext=MojFoldText()	" tekst po zwinieciu zakladki
set ofu=syntaxcomplete#Complete " Default to omni completion using the syntax highlighting files
"set wildmode=longest:full	" dopelniaj jak w BASHu
"set cpoptions="A"
"set keymodel=startsel,stopsel	" zaznaczanie z shiftem
let php_sql_query = 1		" podkreslanie skladni SQL w PHP
let php_htmlInStrings = 1	" podkreslanie skladni HTML w PHP
let python_highlight_all = 1
set spelllang=pl
set background=light
set showtabline=1
colorscheme desert

behave xterm

if &t_Co > 2 || has("gui_running")
	syntax on		" kolorowanie skladni
	set hlsearch		" zaznaczanie szukanego tekstu
endif

set ts=4
set sw=4
set expandtab       " Expand TABs to spaces

"zmainy rozmiarow okien horyzontalny
map - <C-W>-
map + <C-W>+
map = <C-W>=

"zmiany rozmiarow okien verticalny
map - <C-W><
map + <C-W>>

nmap <F3> :Vexplore<CR>
"Wlaczenie Vexplore
"nmap <F3> :call ToggleVExplore()<CR>
"function ToggleVExplore()
"	if exists("t:expl_buf_num")
"		let expl_win_num = bufwinnr(t:expl_buf_num)
"		if expl_win_num != -1
"			let cur_win_nr = winnr()
"			exec expl_win_num . 'wincmd w'
"			close
"			exec cur_win_nr . 'wincmd w'
"			unlet t:expl_buf_num
"		endif
"	else
"		20Vexplore
"		let t:expl_buf_num = bufnr("%")
"	endif
"endfunction

":au BufAdd,BufNewFile * nested tab sball

" automatyczne rozpoznawanie typu pliku, ladowanie specyficznego, dla danego typu, pluginu (ftplugin.vim, indent.vim):
filetype plugin indent on


""""""""""""""""""" AUTO COMMANDS: """"""""""""""""""""""""""""""""""{{{
if has("autocmd")
	autocmd BufEnter * :lcd %:p:h	" cd na katalog, w którym znajduje siê aktualny bufor
	" zaczynaj od ostatniej znanej pozycji kursora:
	autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g`\"" | endif
	" autouzupe³nianie z plików syntax:
	autocmd FileType * execute "setlocal complete+="."k$VIMRUNTIME/syntax/".&ft.".vim"
	autocmd FileType text setlocal textwidth=78	" w plikach tekstowych zawijaj tekst po 78. znakach
	autocmd BufNewFile,Bufread *.php,*.php3,*.php4,*.php5 set keywordprg="help"
	"autocmd BufNewFile * startinsert	" rozpoczyna w trybie INSERT
	" zapamiêtuj zak³adki, itp:
	"autocmd BufWinLeave *.* mkview
	"autocmd BufWinEnter *.* silent loadview
	"autocmd BufReadPost */stl_doc/*.html  :silent execute ":!elinks ".expand("%:p") | bdelete " tip 931
	"autocmd BufNewFile,BufRead muttng-*-\w\+,muttng\w\{6\},ae\d setfiletype mail	" MuttNG
	"autocmd BufRead *.py set foldmethod=indent	" UWAGA: FileType pomija modeline, dlatego detekcja po rozszerzeniu
else
	set autoindent	" automatyczne wciêcia
	set mouse=a	" myszka w konsoli
endif
"}}}

""""""""""""""""""" KLAWISZOLOGIA: """"""""""""""""""""""""""""""""""{{{
map		<silent><C-W>N			<ESC>:tabnew<CR>
imap		<silent><C-W>N			<ESC>:tabnew<CR>
"map		<silent><C-W><backspace><backspace>	<ESC>:e #<CR>
"imap		<silent><C-W><backspace><backspace>	<ESC>:e #<CR>
map             <silent><c-w><space>            :bnext<CR>
imap            <silent><c-w><space>            <ESC>:bnext<CR>
map             <silent><c-w><backspace>        :bprevious<CR>
imap            <silent><c-w><backspace>        <ESC>:bprevious<CR>
map             <silent><c-w><c-space>          :bnext<CR>
imap            <silent><c-w><c-space>          <ESC>:bnext<CR>
map             <silent><c-w><c-backspace>      :bprevious<CR>
imap            <silent><c-w><c-backspace>      <ESC>:bprevious<CR>
map		<C-B>				:!php -l %<CR>		" sprawdzanie sk³adni PHP
nnoremap	<silent><F8>			:Tlist<CR>		" Tag List
map		<leader><leader>		[{V%zf			" \\ wewnatrz bloku {} tworzy fold i go zamyka"{{{
inoremap	<Tab>				<C-R>=InsertTabWrapper("backward")<CR>
inoremap	<S-Tab>				<C-R>=InsertTabWrapper("forward")<CR>
map		<Leader>b			GoZ<ESC>:g/^$/.,/./-j<CR>Gdd			" Collapse multiple contiguous empty lines into a single line
map		<Leader>n			GoZ<ESC>:g/^[ <Tab>]*$/.,/[^ <Tab>]/-j<CR>Gdd	" Collapse multiple contiguous blank lines into a single line
"map		<Leader>c			:%s/[[:cntrl:]]/\r/g				" Replace control characters with a new line separator
map		<Leader>d			:%s/[<Char-128>-<Char-255>]//g			" Delete extended characters (128-255)
map		<Leader>e			:%s/\(.*[^ ][^ ]*\)  *$/\1/c			" Remove trailing spaces at the end of a line
map		<Leader>f			:%s/^  *\(.*\)/\1/c				" Remove leading spaces at the beginning of a line
map		<Leader>g			:%s/   */ /gc					" Collapse multiple contiguous spaces into a single space
map		<Leader>h			:/<code>/+1,/<\/code>/-1s/&/\&amp;/gc		" Convert & to &amp; between CODE tags
map		<Leader>i			:/<code>/+1,/<\/code>/-1s/</\&lt;/gc		" Convert < to &lt; between CODE tags
map		<Leader>j			:/<code>/+1,/<\/code>/-1s/>/\&gt;/gc		" Convert > to &gt; between CODE tags
map		<silent><F12>			<ESC>:ZoomWin<CR>
map		<C-W><C-F>			<ESC>:FirstExplorerWindow<CR>
map		<C-W><C-B>			<ESC>:BottomExplorerWindow<CR>
map		<C-W><C-T>			<ESC>:WMToggle<CR>
" szukanie we wszystkich plikach:
"nmap		<F3>				:while !search( @/, "W") \| bnext \| endwhile<CR>
" szukaj zaznaczonego tekstu z '*' i '#' (a nie tylko wyrazu pod kursorem):
vnoremap	*				y/<C-R>"<CR>
vnoremap	#				y?<C-R>"<CR>
" wyszukiwanie TYLKO w zaznaczonym fragmencie:
vnoremap	/				<ESC>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap	?				<ESC>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
" Make shift-insert work like in Xterm:
map		<S-Insert>			<MiddleMouse>
map!		<S-Insert>			<MiddleMouse>
" sprawdzanie pisowni
"map		<F7>				:w<CR>:!ispell -x -d polish %<CR><CR>:e<CR><CR>
map		<silent><F7>			<ESC>:setlocal spell! spelllang=pl<CR>
imap		<silent><F7>			<ESC>:setlocal spell! spelllang=pl<CR>
"map		<silent><S-F7>			<ESC>:set nospell<CR>
"imap		<silent><S-F7>			<ESC>:set nospell<CR>
" nie traæ zaznaczenia przy < i >
noremap		<				<gv
noremap		>				>gv
"}}}"}}}

""""""""""""""""""" FUNKCJE: """"""""""""""""""""""""""""""""""""""""{{{
" tekst po zwinieciu zakladki:
function! MojFoldText()
	let linia = getline(v:foldstart)
	let linia = substitute(linia, '/\*\|\*/\|{{{\d\=\|//\|<!--\|-->', '', 'g')	"}}}
	return v:folddashes.' '.v:foldend.' (ZWINIETO: '.(v:foldend-v:foldstart+1).') '.linia
endfunction

" Uzupe³nianie wyrazów przez <Tab> - TIP #102:
function! InsertTabWrapper(direction)
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<tab>"
	elseif "backward" == a:direction
		return "\<c-p>"
	else
		return "\<c-n>"
	endif
endfunction

function! s:DiffWithSaved()
	let filetype=&ft
	diffthis
	" new | r # | normal 1Gdd - for horizontal split
	vnew | r # | normal 1Gdd
	diffthis
	execute "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! Diff call s:DiffWithSaved()
"}}}

""""""""""""""""""" PLUGINY: """"""""""""""""""""""""""""""""""""""""{{{
" TOhtml:
	let html_use_css=1	" domyslnie uzywa CSS zamiast <font>
	let use_xhtml=1		" domyslnie tworzy XHTML zamiast HTML
" WinManager:
        let g:miniBufExplMapWindowNavVim = 1
        let g:miniBufExplMapWindowNavArrows = 1
        let g:miniBufExplMapCTabSwitchBuffs = 1
        let g:persistentBehaviour = 1 " nie zamykaj VIMa jezeli zostanie tylko okno exploratora
" TimeStamp:
	let g:timestamp_modelines=20 " przeszukuj pierwsze 20 linii
	let g:timestamp_regexp = '\v\C%(\s+MODYFIKACJA:\s+)@<=.*$'
	let g:timestamp_rep = '%a %d-%m-%Y %R'
" BuffExplorer:
	let g:bufExplorerSortBy='number'
	let g:bufExplorerSplitType='v'
	let g:bufexplorersplitvertsize = 100
	let g:bufExplorerOpenMode=1          " Open using current window
	let g:bufExplorerSplitOutPathName=1
	let g:bufExplorerShowDirectories=1
" Enanced Commentify:
	let g:EnhCommentifyTraditionalMode = "No"
"}}}

" TIP #1149: Returns either the contents of a fold or spelling suggestions. "{{{
function! BalloonExpr() 
	let foldStart = foldclosed(v:beval_lnum ) 
	let foldEnd   = foldclosedend(v:beval_lnum) 
	let lines = [] 
	" If we're not in a fold... 
	if foldStart < 0 
		" If 'spell' is on and the word pointed to is incorrectly spelled, the tool tip will contain a few suggestions. 
		let lines = spellsuggest( spellbadword( v:beval_text )[ 0 ], 5, 0 ) 
	else 
		let numLines = foldEnd - foldStart + 1 
		" Up to 31 lines get shown okay; beyond that, only 30 lines are shown with ellipsis in between to indicate too much. 
		" The reason why 31 get shown okay is that 30 lines plus one of ellipsis is 31 anyway... 
		if ( numLines > 31 ) 
			let lines = getline( foldStart, foldStart + 14 ) 
			let lines += [ '-- Snipped ' . ( numLines - 30 ) . ' lines --' ] 
			let lines += getline( foldEnd - 14, foldEnd ) 
		else 
			let lines = getline( foldStart, foldEnd ) 
		endif 
	endif 
	return join( lines, has( "balloon_multiline" ) ? "\n" : " " ) 
endfunction 

"set balloonexpr=BalloonExpr()
"set ballooneval"}}}

map \c :cclose<CR>:make "%:r"<CR>:copen 8<CR><C-W>x<C-W>w
map \b :make<CR>:copen 8 <CR><C-W>x
map \n :cn<CR>
map \p :cp<CR>

set fdm=marker

"wyswietlanie bialych znakow
"set tw=100
highlight NonText ctermfg=7
highlight SpecialKey ctermfg=7
set listchars=eol:$,tab:>-
map <silent><F2> :set list!<CR>
imap <silent><F2> <ESC>:set list!<CR>
map <silent><F4> :Tlist<CR>
imap <silent><F4> <ESC>:Tlist<CR>

inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" Type script enable
au BufRead,BufNewFile *.ts setfiletype typescript
