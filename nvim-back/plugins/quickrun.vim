"nnoremap <C-u> :QuickRun<in.txt<CR>

let g:quickrun_config = {
\ '_' : {
\   'outputter/buffer/split' : ':botright 8sp',
\   'outputter/buffer/close_on_empty' : 1,
\   'hook/time/enable' : 1,
\ },
\ 'tex' : {
\   'command' : 'uplatex',
\   'exec' : ['%c --kanji=utf8 -output-directory %s:h %s', '%c --kanji=utf8 -output-directory %s:h %s', 'dvipdfmx -d 5 -o %s:r.pdf %s:r.dvi', 'nohup apvlv %s:r.pdf &'],
\   'hook/sweep/files' : [
\     '%S:p:r.aux',
\     '%S:p:r.log',
\     '%S:p:r.dvi',
\    ],
\ },
\ 'haskell': {'type': 'haskell/runghc'},
\ 'haskell/runghc': {
\   'command': 'stack',
\   'exec': ['%c runhaskell %s:r'],
\   'tempfile': '%{tempname()}.hs',
\   'hook/eval/template': 'main = print \$ %s',
\   'hook/sweep/files' : [
\     '%S:p:r',
\     '%S:p:r.hi',
\     '%S:p:r.o',
\    ],
\ },
\}
