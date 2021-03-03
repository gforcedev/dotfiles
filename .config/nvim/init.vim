set nocompatible
call plug#begin('~/.local/share/nvim/site/plugged/')

" ---------- LANGUAGE FEATURES ----------

" --- vim-polyglot for syntax highlighting and autoindent with equals ---
" {{{
	let g:polyglot_disabled = ['latex'] " vimtex for latex instead
	Plug 'sheerun/vim-polyglot'

	" vimtex instead for latex
	Plug 'lervag/vimtex'
	let g:tex_flavor = 'latex'
	let g:vimtex_quickfix_open_on_warning = 0 " don't open a split to show warnings
"}}}

" --- coc.nvim for lsp integration ---
"  {{{
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" install coc extensions for various languages
	let g:coc_global_extensions = [
		\'coc-snippets',
		\'coc-pairs',
		\'coc-tsserver',
		\'coc-eslint',
	\]

	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup

	set updatetime=300 " update diagnostic messages more regularly than 4s

	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	if has("patch-8.1.1564")
		" Recently vim can merge signcolumn and number column into one
		set signcolumn=number
	else
		set signcolumn=yes
	endif
	
	" K to show documentation
	nnoremap <silent> K :call <SID>show_documentation()<CR>
	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use tab for trigger completion with characters ahead and navigate.
	" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" Use <c-l> to expand snippet
	imap <C-l> <Plug>(coc-snippets-expand)

	" GoTo definition
	nmap <silent> gd <Plug>(coc-definition)

	nnoremap <silent> <C-.> <Plug>(coc-fix-current)

	nnoremap <silent> <F2> <Plug>(coc-rename)

	" Highlight symbol under cursor on CursorHold
	autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}

" --- other misc language feature plugins ---
" {{{
	" vim-snippets for a collection of useful snippets
	Plug 'honza/vim-snippets'

	" emmet for html expansion
	Plug 'mattn/emmet-vim'
" }}}


" ---------- GENERAL ----------

" --- Misc general ---
" {{{
	" Change the terminal title
	set title

	" Map leader to space
	nnoremap <SPACE> <Nop>
	let mapleader=" "
	let maplocalleader=" "
" }}}

" --- Formatting and indentation ---
" {{{
	set showmatch           " Show matching brackets.
	set number              " Show the line numbers on the left side.
	set formatoptions+=o    " Continue comment marker in new lines.
	set tabstop=4           " Render TABs using this many spaces.
	set shiftwidth=4        " 4 spaces to a tab
" }}}

" --- Yank modifications ---
" {{{
	" yank to xclip
	set clipboard+=unnamedplus
	" make x yank somewhere else irrelevant
	nnoremap x "_x
	vnoremap x "_x
" }}}


" ---------- EDITOR BEHAVIOUR ----------

" --- Misc behaviour config
" {{{
	" Map for entering paste mode which will stop continue
	" comment when pasting code through a terminal emulator
	map <silent> <leader>p :set paste!<cr>
" }}}

" vim-lion for vertical alignment (eg of multiple variable assignments)
" {{{
	Plug 'tommcdo/vim-lion'

	" Make alignment as compact as possible
	let g:lion_squeeze_spaces = 1
" }}}

" Nerdcommenter for handling of comments
" {{{
	Plug 'scrooloose/nerdcommenter'

	" Add spaces after comment delimiters by default
	let g:NERDSpaceDelims = 1

	" Use compact syntax for prettified multi-line comments
	let g:NERDCompactSexyComs = 1

	" Enable trimming of trailing whitespace when uncommenting
	let g:NERDTrimTrailingWhitespace = 1
" }}}

" Vim-surround for working with quotes and tags
Plug 'tpope/vim-surround'


" ---------- NAVIGATION AND FILES ----------

" --- Move around windows, integrate with tmux ---
" {{{
	Plug 'christoomey/vim-tmux-navigator'

	" By default it uses ctrl rather than alt
	let g:tmux_navigator_no_mappings = 1

	noremap <silent> <m-h> :TmuxNavigateLeft<cr>
	noremap <silent> <m-j> :TmuxNavigateDown<cr>
	noremap <silent> <m-k> :TmuxNavigateUp<cr>
	noremap <silent> <m-l> :TmuxNavigateRight<cr>
" }}}

" --- Buffer management ---
" {{{
	Plug 'thekelvinliu/kwbd' " Keep window on buffer delete
	set hidden " Allow switching buffers without :w
	map <silent> <leader>bn :bnext<cr>
	map <silent> <leader>bp :bprevious<cr>
	map <silent> <leader>bc <plug>(kwbd)
" }}}

" --- NERDTree as a file window ---
" {{{
	Plug 'scrooloose/nerdtree'
	
	" To make it l to open and h to close
	Plug 'flw-cn/vim-nerdtree-l-open-h-close'

	let g:NERDTreeMapActivateNode = 'l'
	let NERDTreeMinimalUI = 1         " Disable help message
	let NERDTreeMouseMode = 3         " Single click to open any dir/file

	" Open nerdtree if vim is opened in a directory
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

	map <silent> <c-n> :NERDTreeToggle<cr>
" }}}

" --- FZF for fuzzy matching ---
" {{{
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" default fzf command: use rg --files to exclude gitignore but keep everything else
	let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
	nnoremap <C-p> :Files<CR>
	" currently open buffers
	nnoremap <leader>; :Buffers<CR>
	" fzf keybinds to open in splits, same as nerdtree's
	let g:fzf_action = {
		\'ctrl-i': 'split',
		\'ctrl-s': 'vsplit',
	\}
" }}}

" Fugitive for many many git tools
Plug 'airblade/vim-gitgutter'


" ---------- INTERFACE ----------

" --- Misc interface config ---
" {{{
	" Wrap on words, not characters
	set wrap linebreak nolist

	" Don't highlight all occurences of the most recent serach
	set nohlsearch
" }}}

" --- Colors and transparency ---
" {{{
	" From joshdick/onedark.vim readme:

	" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
	" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
	" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)

	" if (empty($TMUX))
	if (has("nvim"))
		" For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
		let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	endif
	" For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
	" Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
	" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
	if (has("termguicolors"))
		set termguicolors
	endif
	" endif

	syntax on

	Plug 'joshdick/onedark.vim'

	" colorscheme set and transparency enabled after plug#end
" }}}

" Vim-airline for a pretty status bar
" {{{
	Plug 'vim-airline/vim-airline'
	let g:airline_theme='onedark'

	" Don't show the mode because airline has it already
	set noshowmode
" }}}

" --- Line Numbers: relative in normal, absolute in insert ---
" {{{
	set number relativenumber

	:augroup linehighlight
	:  autocmd InsertEnter * set cursorline
	:  autocmd InsertLeave * set nocursorline
	:augroup END

	augroup numbertoggle
	  autocmd!
	  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
	augroup END
" }}}

" Hightlight trailing spaces
" {{{
	highlight ExtraWhitespace ctermbg=red guibg=red
	match ExtraWhitespace /\s\+$/
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()
" }}}

" Gitgutter for seeing VCS changes
Plug 'tpope/vim-fugitive'

" Devicons - must go last
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Set colorscheme and transparency
colorscheme onedark
hi Normal guibg=NONE ctermbg=NONE
