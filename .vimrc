set number                    " Numera as linhas
set linebreak                 " Quebra a linha sem quebrar a palavra
"set nobackup                  " Não salva arquivos de backup~
"set wildmode=longest,list     " Completa o comando com TAB igual o bash
"set ignorecase                " Ignora o case sensitive nas buscas
"set smartcase                 " Se tiver alguma letra maiúscula, ativa o case sensitive
"set gdefault                  " Sempre substitui todas as palavras, não só a primeira
set smartindent               " Auto-indenta
set expandtab                 " Identa com espaços
set tabstop=2                 " Quantidade de espaços por indentação
set shiftwidth=2              " Quantidade de espaços da auto-indentação
"set guioptions-=T             " Deixa a GUI sem a toolbar
set autochdir                 " Vai pro diretório do arquivo aberto
set cursorline                " Mostra linha atual mais clara
set cursorcolumn              " Mostra coluna 
set ai                        " ? 
set hlsearch                  " Termo procurado em destaque
set pumheight=15              " Máximo de palavras no popup de autocomplete
set completeopt=menu,preview  " Como mostrar as possibilidade de inserção
"set spelllang=pt              " Escolhe o dicionário
set foldenable                " Habilita agrupamento de blocos
set foldcolumn=1              " Exibie coluna com + e - para agrupamentos
set foldmethod=marker         " Define agrupamento por marcas
set foldmarker={,}            " Define marcas de agrupamento como { e }
set foldlevel=9999            " Inicia com todos os agrupamentos abertos

filetype plugin indent on

" Permite selecionar com SHIFT + SETA como no Windows
set selectmode=mouse,key
set mousemodel=popup
set keymodel=startsel,stopsel
set selection=exclusive

" Move entrelinhas visíveis, e não somente físicas, quando em WRAP
inoremap <expr><UP> pumvisible() ? "<UP>" : "<C-O>gk"
inoremap <expr><DOWN> pumvisible() ? "<DOWN>" : "<C-O>gj"

" Atalhos
vnoremap <C-C> "+y
vnoremap <C-X> "+x
vnoremap <C-V> "+p
inoremap <C-V> <C-O>:set paste<CR><C-R>+<C-O>:set nopaste<CR>
noremap <C-Z> <C-O>u
inoremap <C-Z> <C-O>u
vnoremap <C-Z> <C-C>ui
inoremap <C-Y> <C-O><C-R> 
inoremap <C-S> <C-O>:update<CR>
vnoremap <C-S> <C-C>:update<CR>i
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
inoremap <C-J> <C-O><S-J>
inoremap <C-F> <C-O>/
inoremap <C-G> <C-O>/<CR>
inoremap <C-O> <C-O>:confirm e .<CR>
inoremap <C-Q> <C-O>:confirm quit<CR>
inoremap <C-A-F> <C-O>:!grep -Hnir "" *<LEFT><LEFT><LEFT>
inoremap <C-H> <C-O>:%s///gg<LEFT><LEFT><LEFT><LEFT>
vnoremap <C-S-F> <C-Q>=
inoremap <A-S-UP> <C-O><C-Q>
inoremap <A-S-DOWN> <C-O><C-Q>
inoremap <A-S-LEFT> <C-O><C-Q>
inoremap <A-S-RIGHT> <C-O><C-Q>
inoremap <C-SPACE> <C-X><C-O>
inoremap <C-SPACE><C-F> <C-X><C-F>
inoremap <C-SPACE><C-L> <C-X><C-L>
inoremap <C-SPACE><C-P> <C-X><C-N>
inoremap <C-SPACE><C-P> <C-X><C-P>

" Copia a linha e apaga a linha
inoremap <C-C> <C-O><S-V>"+y
inoremap <C-X> <C-O><S-V>"+x
inoremap <C-D> <C-O><S-V>d

" Abas
inoremap <C-T> <C-O>:tabnew<CR>
inoremap <C-TAB> <C-O>:tabnext<CR>
inoremap <C-S-TAB> <C-O>:tabprevious<CR>
inoremap <C-F4> <C-O>:x!<CR>

" Divide janela
inoremap <C-W><C-S> <C-O>:split<CR>
inoremap <C-W><C-N> <C-O>:vnew<CR>
inoremap <C-W><C-V> <C-O>:vsplit<CR>
inoremap <C-W><C-Q> <C-O>:confirm quit<CR>
inoremap <C-W><C-W> <C-O>:winc w<CR>
inoremap <C-W><C-UP> <C-O>:winc k<CR>
inoremap <C-W><C-DOWN> <C-O>:winc j<CR>
inoremap <C-W><C-LEFT> <C-O>:winc h<CR>
inoremap <C-W><C-RIGHT> <C-O>:winc l<CR>

noremap <TAB> >
noremap <S-TAB> <

inoremap { {}<LEFT>
inoremap [ []<LEFT>

" Atalhos de função
inoremap <F1> <C-O>:help 
inoremap <F5> <C-O>:ConqueTermSplit bash<CR><C-O>:resize 5<CR>
inoremap <F7> <C-O>:set spell<CR><C-O>z=
