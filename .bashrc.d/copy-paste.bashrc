if command -v xclip &> /dev/null
then
    alias xcopy="xclip -selection c"
    alias xpaste="xclip -selection clipboard -o"
elif command -v pbcopy &> /dev/null
then
    alias xcopy="pbcopy"
    alias xpaste="pbpaste"
fi
