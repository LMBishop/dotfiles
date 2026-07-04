FROM archlinux:base

ARG UID="1000"
ARG GID="1000"
ARG USERNAME="leonardo"

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        base-devel pacman-contrib pkgconf \
        git \
	vim \
	man-db \
        zip unzip p7zip gzip bzip2 zstd \
	less wget curl jq ripgrep tree \
        python \
	zsh bc fzf exa \
	zsh-autosuggestions zsh-syntax-highlighting 

RUN groupadd --gid ${GID} $USERNAME && \
	useradd --uid ${UID} --gid ${GID} -ms /bin/zsh $USERNAME

USER $USERNAME

WORKDIR /home/$USERNAME

RUN mkdir -p ~/.local/share ~/.local/state ~/.config ~/.cache

