FROM ubuntu:24.04 AS base

WORKDIR /home/jaimedgp
ENV HOME="/home/jaimedgp"
RUN mkdir -p /home/jaimedgp/.config/zsh/
RUN mkdir -p /home/jaimedgp/projects/
ENV ZSH_CUSTOM="/home/jaimedgp/.config/zsh/ohitsmyzsh"
RUN apt update && apt upgrade -y
RUN apt install -y curl cmake unzip python3 python3-venv

# GIT
# ------------------------------
RUN apt install -y git

# NEOVIM
# ------------------------------
RUN apt update && apt install -y npm fd-find

RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract

RUN git clone https://github.com/Jaimedgp/ohitsmynvim.git $HOME/.config/nvim/ && \
    cd $HOME/.config/nvim/ && git checkout docker && \
    /home/jaimedgp/squashfs-root/usr/bin/nvim -c "MasonToolsInstall" -c "sleep 40" +qall

# ZSH
# ------------------------------
RUN apt install -y zsh

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN mv $HOME/.oh-my-zsh/ $HOME/.config/zsh/

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.config/fzf \
  && ~/.config/fzf/install --key-bindings --update-rc --completion --no-bash --no-fish --all --xdg

RUN git clone https://github.com/Jaimedgp/ohitsmyzsh.git $ZSH_CUSTOM
# COPY . $ZSH_CUSTOM
RUN cp $ZSH_CUSTOM/templates/zshrc.zsh-template $HOME/.zshrc

RUN git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

RUN $SHELL

# TMUX
# ------------------------------
RUN apt install -y tmux
RUN git clone https://github.com/Jaimedgp/ohitsmytmux.git $HOME/.config/tmux/ohitsmytmux/
RUN cp $HOME/.config/tmux/ohitsmytmux/.tmux.conf $HOME/.tmux.conf

WORKDIR /home/jaimedgp/projects

ENTRYPOINT [ "/bin/zsh" ]


FROM ubuntu:24.04

WORKDIR /home/jaimedgp
ENV HOME="/home/jaimedgp"
ENV ZSH_CUSTOM="/home/jaimedgp/.config/zsh/ohitsmyzsh"
RUN rm -rf /home/ubuntu/ && \
    mkdir -p /home/jaimedgp/.config/zsh/ && \
    mkdir -p /home/jaimedgp/projects/

RUN apt update && apt install -y git zsh tmux tcc python3 python3-venv

COPY --from=base /home/jaimedgp/squashfs-root /opt/nvim
COPY --from=base /home/jaimedgp/.local/share/nvim/lazy /home/jaimedgp/.local/share/nvim/lazy
COPY --from=base /home/jaimedgp/.local/share/nvim/mason /home/jaimedgp/.local/share/nvim/mason
COPY --from=base /home/jaimedgp/.config/nvim /home/jaimedgp/.config/nvim
RUN ln -s /opt/nvim/usr/bin/nvim /usr/local/bin/nvim

COPY --from=base $HOME/.zshrc $HOME/.zshrc
COPY --from=base $ZSH_CUSTOM $ZSH_CUSTOM
COPY --from=base $HOME/.config/zsh/.oh-my-zsh/ $HOME/.config/zsh/.oh-my-zsh/

COPY --from=base $HOME/.config/fzf $HOME/.config/fzf

COPY --from=base $HOME/.config/tmux/ohitsmytmux/ $HOME/.config/tmux/ohitsmytmux/
COPY --from=base $HOME/.tmux.conf $HOME/.config/tmux/ohitsmytmux/

ENTRYPOINT [ "/bin/zsh" ]
