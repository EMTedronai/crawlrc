" Replace all comments which are of the pattern
"
"     --@@@ FILENAME
"
" with the contents of that file.

silent g/--@@@/normal Wy$"_dd:r "
x
