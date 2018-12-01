source ~/dotfiles/zsh/antigen/bin/antigen.zsh

for directory in ~/dotfiles/zsh/{config,aliases,functions,extra}; do
        for file in `find $directory/*.zsh`; do
                [ -r "$file" ] && [ -f "$file" ] && source "$file";
        done;
done;
unset file;
unset directory;
