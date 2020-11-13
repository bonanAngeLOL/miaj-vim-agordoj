set nocompatible
syntax on
colorscheme monokai
" ĉu mi ĉi tion bezonas? xD
echo 'Kio okazas fiulo, ĉu vi jam feke pretiĝas? xDxDxd'
set encoding=UTF-8
set autoindent
set number
" Confortably to navigate between lines
set relativenumber
set hlsearch
set noerrorbells
set title
set ruler   
set splitbelow
set cursorline
set textwidth=0

" Ruler to 80 column
set colorcolumn=80

" Shift config
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

call plug#begin('~/.vim/plugged')
	Plug 'vim-airline/vim-airline'
    let g:airline#extensions#ale#enabled = 1
    let g:ale_disable_lsp = 1
	Plug 'ryanoasis/vim-devicons'
	Plug 'preservim/nerdtree'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'dense-analysis/ale'
    let g:ale_sign_column_always = 1 
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-fugitive'
	let g:airline#extensions#nerdtree_statusline = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:monokai_term_italic = 1
    let g:monokai_gui_italic = 1
    let NERDTreeQuitOnOpen=1
    Plug 'vim-airline/vim-airline-themes'
    " Nice theme
    let g:airline_theme='wombat'
    let g:airline_powerline_fonts = 1
    let NERDTreeShowHidden=1
    " Need to translate mode names to Esperanto just for fun UwU for airline
    let g:airline_mode_map = {
    \   'i':'ENMETO',
    \   'n':'NORMALA',
    \   '^V':'VIDUMA BLOKO'
    \}
call plug#end()

" Nice font for gVIM
set guifont=Fantasque\ Sans\ Mono\ 10

" To close terminal with two Esc keystrokes
tnoremap <C-[><C-[> <C-w>:bd!<CR>

" Open NERDTree when no file was opened
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif 

"running python
autocmd filetype python nnoremap <F10> :w<bar>cd %:p:h<bar>let f=expand('%')<bar>let p=expand('%:p:h')<bar>let b=expand('%:r')<bar>15new<bar>execute 'read !python3 '.%:p<CR>
autocmd filetype python nnoremap <F9> :w<bar>term ++shell python3 %:p<CR>

"running c++
" <F10> to run in new file in an splited buffer so it can be saved as a output file, somethimes useful
" <F9> to run in terminal 
autocmd filetype cpp nnoremap <F10> :w<bar>cd %:p:h<bar>let f=expand('%')<bar>let p=expand('%:p:h')<bar>let b=expand('%:r')<bar>15new<bar>execute 'read !g++ '.f.' -o '.b.' && ./'.b<CR>
autocmd filetype cpp nnoremap <F9> :w<bar>term ++shell g++ %:p -o %:p:r && %:p:r<CR>

"running C
autocmd filetype c nnoremap <F10> :w<bar>cd %:p:h<bar>let f=expand('%')<bar>let p=expand('%:p:h')<bar>let b=expand('%:r')<bar>15new<bar>execute 'read !gcc '.f.' -o '.b.' && ./'.b<CR>
autocmd filetype c nnoremap <F9> :w<bar>term ++shell gcc %:p -o %:p:r && %:p:r<CR>

"Don't remember what is was for jajajaja
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

"This is just a test to work with Python Venv
function! Venv()
    let curline = getline('.')
    call inputsave()
    let name = input('Enter name: ')
    if(empty(name)) | return | endif 
    let cwd = getcwd()
    execute ':term ++close ++shell mkdir -p '.name.' && cd "$_" && python3 -m venv venv  && touch main.py && mkdir -p .vim && echo "{\"python.jediEnabled\": false, \"python.pythonPath\": \"'.cwd.'/'.name.'/venv/bin/python\"}" >> .vim/coc-settings.json'
    execute ':cd '.name.' | tabnew main.py '
    :<CR>
    call popup_dialog('New '.name.' venv created!!!', #{line: 0, col: 0, highlight: 'WildMenu', close: 'click', time:4000, })
    call inputrestore()
endfunction
"Command to create Venv
command NPYV :call Venv()


