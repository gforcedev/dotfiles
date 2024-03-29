set nocompatible
call plug#begin('~/.local/share/nvim/site/plugged/')

" ---------- LANGUAGE FEATURES ----------
" --- vim-polyglot for syntax highlighting and autoindent with equals ---
" {{{
    " disable polyglot languages that use other plugins
    let g:polyglot_disabled = ['latex', 'svelte', 'javascript', 'typescript', 'json', 'php', 'yaml', 'perl', 'clojure']
    Plug 'sheerun/vim-polyglot'

    " yes to jsdoc highlighting
    let g:javascript_plugin_jsdoc = 1

    " vimtex instead for latex
    Plug 'lervag/vimtex'
    let g:tex_flavor = 'latex'
    let g:vimtex_quickfix_open_on_warning = 0 " don't open a split to show warnings

    " prisma support
    Plug 'pantharshit00/vim-prisma'

    " instead for svelte
    Plug 'leafOfTree/vim-svelte-plugin'
" }}}

" --- nvim lsp things
" {{{
    " lspconfig for doing the things
    Plug 'neovim/nvim-lspconfig'

    " lspsaga for bonus and prettiness
    Plug 'glepnir/lspsaga.nvim'
    nnoremap <silent> <C-j> <Cmd>Lspsaga diagnostic_jump_next<CR>
    nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
    nnoremap <silent> <F2> <cmd>Lspsaga rename<CR>

    " treesitter for thing parsing
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

    " Cmp for completion
    " Need luasnip apparently
    Plug 'L3MON4D3/LuaSnip'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'PaterJason/cmp-conjure'
    Plug 'hrsh7th/nvim-cmp'
    set completeopt=menu,menuone,noselect
" }}}


" --- vimspector for debugging ---
" {{{
    Plug 'puremourning/vimspector'
    let g:vimspector_enable_mappings = 'HUMAN'
" }}}

" --- repls n stuff
" {{{
    Plug 'tpope/vim-dispatch'
    Plug 'clojure-vim/vim-jack-in'
    Plug 'radenling/vim-dispatch-neovim'
" }}}

" --- other misc language feature plugins ---
" {{{
    " vim-snippets for a collection of useful snippets
    Plug 'honza/vim-snippets'

    " emmet for html expansion
    Plug 'mattn/emmet-vim'

    " Conjure for REPL things
    Plug 'Olical/conjure'
    let g:conjure#log#wrap = 'true'

    " sexp for sexping
    Plug 'guns/vim-sexp'

    let g:sexp_mappings = {
        \ 'sexp_swap_list_backward':        '',
        \ 'sexp_swap_list_forward':         '',
        \ 'sexp_swap_element_backward':     '',
        \ 'sexp_swap_element_forward':      '',
    \ }

    let g:sexp_enable_insert_mode_mappings = 0

    Plug 'tpope/vim-sexp-mappings-for-regular-people'
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
    if !empty($WSLPATH)
        let g:clipboard = {
        \   'name': 'win32yank-wsl',
        \   'copy': {
        \      '+': 'win32yank.exe -i --crlf',
        \      '*': 'win32yank.exe -i --crlf',
        \    },
        \   'paste': {
        \      '+': 'win32yank.exe -o --lf',
        \      '*': 'win32yank.exe -o --lf',
        \   },
        \   'cache_enabled': 0,
        \ }
    endif
    " yank to a linux system clipboard if available
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

    " splits on the other side
    set splitright
    set splitbelow

    " mouse scrolling, but disable the buttons
    set mouse=a
    :nmap <LeftMouse> <nop>
    :imap <LeftMouse> <nop>
    :vmap <LeftMouse> <nop>
    :nmap <2-LeftMouse> <nop>

    " C-j and C-k for quickfix moving
    nnoremap <C-j> :cnext<CR>
    nnoremap <C-k> :cprev<CR>
" }}}

" auto-pairs for auto pairs
" {{{
    Plug 'windwp/nvim-autopairs'
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

" Emmet for emmetting
" {{{
    Plug 'mattn/emmet-vim'
" }}}

" Vim-surround for working with quotes and tags
Plug 'tpope/vim-surround'


" ---------- NAVIGATION AND FILES ----------

" --- Move around windows, integrate with tmux ---
" {{{
    Plug 'christoomey/vim-tmux-navigator'

    " By default it uses ctrl rather than alt
    let g:tmux_navigator_no_mappings = 1

    nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <m-l> :TmuxNavigateRight<cr>

    " TODO _this still doesn't work AAA_
    function DoAltMappings()
        unmap <silent> <m-h>
        unmap <silent> <m-j>
        unmap <silent> <m-k>
        unmap <silent> <m-l>

        nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
        nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
        nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
        nnoremap <silent> <m-l> :TmuxNavigateRight<cr>
    endfunction

    augroup VIM_SEXP_MAPPING
        autocmd!
        autocmd FileType clojure,scheme,lisp,timl,fennel call DoAltMappings()
    augroup END
" }}}

" --- Buffer management ---
" {{{
    Plug 'thekelvinliu/kwbd' " Keep window on buffer delete
    set hidden " Allow switching buffers without :w
    map <silent> <leader>bn :bnext<cr>
    map <silent> <leader>bp :bprevious<cr>
    map <silent> <leader>bc <plug>(kwbd)

    map <silent> <leader>tn :tabnext<cr>
    map <silent> <leader>tp :tabprevious<cr>
    map <silent> <leader>tc :tabclose<cr>
    " fullscreen a buffer by opening it in a new tab

    map <silent> <leader>tt :tab split<cr>
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

" --- Telescope for searching n stuff ---
" {{{
"
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

    nnoremap <C-p> <cmd>Telescope find_files<cr>
    nnoremap <leader>rg <cmd>Telescope grep_string<cr>
    nnoremap <leader>lg <cmd>Telescope live_grep<cr>
    nnoremap <leader>lr <cmd>Telescope lsp_references<cr>
    nnoremap <leader>fb <cmd>Telescope file_browser<cr>
    nnoremap <leader>ls <cmd>Telescope git_status<cr>
    nnoremap <leader>; <cmd>Telescope buffers<cr>
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

    let g:nord_contrast = 0
    Plug 'shaunsingh/nord.nvim'

    Plug 'navarasu/onedark.nvim'

    " colorscheme set and transparency enabled after plug#end
" }}}

" Lualine as a statusline
" {{{
    Plug 'hoob3rt/lualine.nvim'
    " We don't need the mode twice
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

" Gitgutter for seeing VCS changes
Plug 'tpope/vim-fugitive'

" Allows :GBrowse to open file on github
Plug 'tpope/vim-rhubarb'

" Allows :GBrowse to open file on gitlab
Plug 'shumphrey/fugitive-gitlab.vim'
let g:fugitive_gitlab_domains = ['https://gitlab.netcraft.com']

" Devicons - must go last
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()
" Things which need to happen after plug#end

" Colorscheme things
let g:onedark_disable_terminal_colors = 1
let g:onedark_diagnostics_undercurl = 0
let g:onedark_transparent_background = 1
colorscheme onedark
hi Normal guibg=NONE ctermbg=NONE
" Hightlight trailing spaces
" {{{
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
" }}}

lua << EOF
-- Telescope
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        color_devicons = true,

        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,

        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-s>"] = actions.select_vertical,
                ["<C-i>"] = actions.select_horizontal,

                ["<esc>"] = actions.close
            },
        },

        extensions = {
            fzy_native = {
                override_generic_sorter = true,
                override_file_sorter = true,
            }
        }
    }
}

-- LSP things
local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings
    local opts = { noremap = true, silent = true }

    buf_set_keymap('n', 'gd', '<Cmd> lua vim.lsp.buf.definition()<CR>', opts)

    --protocol.SymbolKind = { }
    protocol.CompletionItemKind = {
        '', -- Text
        '', -- Method
        '', -- Function
        '', -- Constructor
        '', -- Field
        '', -- Variable
        '', -- Class
        'ﰮ', -- Interface
        '', -- Module
        '', -- Property
        '', -- Unit
        '', -- Value
        '', -- Enum
        '', -- Keyword
        '﬌', -- Snippet
        '', -- Color
        '', -- File
        '', -- Reference
        '', -- Folder
        '', -- EnumMember
        '', -- Constant
        '', -- Struct
        '', -- Event
        'ﬦ', -- Operator
        '', -- TypeParameter
    }
end

nvim_lsp.diagnosticls.setup {
    filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "css"},
    init_options = {
        filetypes = {
            javascript = "eslint",
            typescript = "eslint",
            javascriptreact = "eslint",
            typescriptreact = "eslint"
        },
        linters = {
            eslint = {
                sourceName = "eslint",
                command = "./node_modules/.bin/eslint",
                rootPatterns = {
                    ".eslitrc.js",
                    "package.json"
                },
                debounce = 100,
                args = {
                    "--cache",
                    "--stdin",
                    "--stdin-filename",
                    "%filepath",
                    "--format",
                    "json"
                },
                parseJson = {
                    errorsRoot = "[0].messages",
                    line = "line",
                    column = "column",
                    endLine = "endLine",
                    endColumn = "endColumn",
                    message = "${message} [${ruleId}]",
                    security = "severity"
                },
                securities = {
                    [2] = "error",
                    [1] = "warning"
                }
            }
        }
    }
}
nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = { 'javascript', 'typescript' },
}
nvim_lsp.svelte.setup {}

local saga = require 'lspsaga'

saga.init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    border_style = 'round',
    finder_action_keys = {
        open = '<CR>', vsplit = '<C-s>', split = '<C-i>', quit = '<esc>', scroll_down = '<C-d>', scroll_up = '<C-u>',
    },
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true
    },
    ensure_installed = {
        'json',
        'javascript',
        'typescript',
        'php',
        'yaml'
    }
}

require('nvim-autopairs').setup {
    enable_check_bracket_line = false
}

-- cmp
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local icons = {
    Text          = "",
    Method        = "",
    Function      = "",
    Constructor   = "",
    Field         = "ﰠ",
    Variable      = "",
    Class         = "ﴯ",
    Interface     = "",
    Module        = "",
    Property      = "ﰠ",
    Unit          = "塞",
    Value         = "",
    Enum          = "",
    Keyword       = "",
    Snippet       = "",
    Color         = "",
    File          = "",
    Reference     = "",
    Folder        = "",
    EnumMember    = "",
    Constant      = "",
    Struct        = "פּ",
    Event         = "",
    Operator      = "",
    TypeParameter = "",
}

cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    formatting = {
        -- Use icons and display completion source
        format = function(entry, vim_item)
            vim_item.kind = string.format(
                '%s %s',
                icons[vim_item.kind],
                vim_item.kind
            )

            return vim_item
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = function(fallback)
             if cmp.visible() then
                    cmp.select_next_item()
             elseif require('luasnip').expand_or_jumpable() then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
             else
                    fallback()
             end
        end,
        ['<S-Tab>'] = function(fallback)
             if cmp.visible() then
                    cmp.select_prev_item()
             elseif require('luasnip').jumpable(-1) then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
             else
                    fallback()
             end
        end,
    },
    sources = {
        { name = 'conjure' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
    },
}

cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done())

-- Lualine
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = {'', ''},
        section_separators = {'', ''},
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {require 'nvim-treesitter'.statusline},
        lualine_z = {'location', 'progress'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
EOF
