packadd! dracula
syntax on
colorscheme dracula


set nu
set autoindent
set hlsearch
set ts=4
set sw=4
set guifont=Monospace\16
set smartindent
set smarttab
set expandtab

inore ii <Esc>

iab filein 
\freopen("input.txt", "r", stdin);<CR>

iab fileout 
\freopen("output.txt", "w", stdout);<CR>

iab strt 
\#include<bits/stdc++.h><CR>
\using namespace std;<CR>
\<CR>
\int main() {<CR>
\ios::sync_with_stdio(false), cin.tie(0), cout.tie(0);<CR>
\<CR>
\return 0;<CR>
\}<CR>
