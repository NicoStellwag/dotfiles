" Plug
call plug#begin(stdpath('data').'/plugged')
	" Make sure you use single quotes
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'tomlion/vim-solidity'
	Plug 'joshdick/onedark.vim'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'lervag/vimtex'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" vimtex config
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

" Set color scheme and activate syntax highlighting
autocmd vimenter * ++nested colorscheme onedark
lua << END
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true
	}
}
END

" Enable status line
lua << END
require'lualine'.setup()
options = {theme = 'onedark'}
END

" highlight matching brackets
set matchpairs+=<:>

" show relative line numbers
set number
set relativenumber

" underline current line
set cursorline
hi clear CursorLine
hi CursorLine gui=underline

" activate syntax highlighting
syntax on

" match tabs to prev line on new line
set autoindent

" nvim use block cursor
set guicursor=i:block

" Use normal clipboard
if !empty(provider#clipboard#Executable())
	set clipboard+=unnamedplus
endif

" smartsearch (case sensitive only if contains upper case
set ignorecase
set smartcase

" keep cursor in the middle of the screen
:set scrolloff=5

" key mappings
imap <M-j> <Esc>
vmap <M-j> <Esc>
tmap <M-j> <Esc>
smap <M-j> <Esc>
nmap <M-k> :CocCommand explorer<CR>
map <M-l> :Files<CR>
nnoremap <CR> :noh<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
        	execute 'h '.expand('<cword>')
	else
		call CocActionAsync('doHover')
	endif
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>r  <Plug>(coc-rename)
nmap <silent> <leader>d :call <SID>show_documentation()<CR>
imap <C-j> <down>
imap <C-k> <up>
