if [ "$DISTROFAMILY" = "Solus" ]; then
    alias ospkg='eopkg'
    alias ospkgs='eopkg search'
    alias ospkgi='sudo eopkg install'
    alias ospkgu='sudo eopkg remove'
    alias osup='sudo eopkg upgrade'
fi

if [ "$DISTROFAMILY" = "RedHat" ]; then
    alias ospkg='dnf'
    alias ospkgs='dnf search'
    alias ospkgi='sudo dnf install'
    alias ospkgu='sudo dnf remove'
    alias osup='sudo dnf update'
fi

if [ "$DISTROFAMILY" = "Debian" ]; then
    alias ospkg='apt'
    alias ospkgs='apt search'
    alias ospkgi='sudo apt install'
    alias ospkgu='sudo apt remove'
    alias osup='sudo apt update; sudo apt upgrade'
fi
