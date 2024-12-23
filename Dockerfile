FROM ubuntu:24.04 AS base-nvim

RUN apt update && apt install -y curl cmake python3 python3-venv git

RUN curl -o /root/nvim.appimage -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x /root/nvim.appimage && \
    cd /root/ && \
    /root/nvim.appimage --appimage-extract

RUN git clone https://github.com/Jaimedgp/ohitsmynvim.git $HOME/.config/nvim/ && \
    cd $HOME/.config/nvim/ && git checkout docker && \
    /root/squashfs-root/usr/bin/nvim -c "MasonToolsInstall" -c "sleep 40" -c "echo stdpath('data')" -c "sleep 20" +qall && \
    mv $HOME/.config/nvim/lua /root/nvim/ && \
    mv $HOME/.config/nvim/init.lua /root/nvim/


FROM ubuntu:24.04 AS base-zsh

RUN apt update && apt install -y curl git zsh

WORKDIR /zsh

RUN cd /zsh && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    ls && \
    mv $HOME/.oh-my-zsh/ /zsh/

RUN git clone --depth 1 https://github.com/junegunn/fzf.git /fzf \
  && /fzf/install --key-bindings --update-rc --completion --no-bash --no-fish --all --xdg

RUN git clone https://github.com/Jaimedgp/ohitsmyzsh.git /zsh_custom && \
    mv /zsh_custom/templates/zshrc.zsh-template /zsh/.zshrc && \
    rmdir /zsh_custom/templates && rm -rf .git/ .gitignore

RUN git clone https://github.com/zsh-users/zsh-autosuggestions /zshasgg && \
    mkdir -p /zsh_custom/plugins/zsh-autosuggestions && \
    mv /zshasgg/src /zsh_custom/plugins/zsh-autosuggestions/src && \
    mv /zshasgg/spec /zsh_custom/plugins/zsh-autosuggestions/spec && \
    mv /zshasgg/zsh-autosuggestions.*zsh /zsh_custom/plugins/zsh-autosuggestions/

RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /zshsynt && \
    mkdir -p /zsh_custom/plugins/zsh-syntax-highlighting/ && \
    mv /zshsynt/highlighters/ /zsh_custom/plugins/zsh-syntax-highlighting/highlighters/ && \
    mv /zshsynt/images/ /zsh_custom/plugins/zsh-syntax-highlighting/images/ && \
    mv /zshsynt/zsh-syntax-highlighting*.zsh /zsh_custom/plugins/zsh-syntax-highlighting/

FROM ubuntu:24.04 AS base-tmux

RUN apt update && apt install -y tmux git
RUN git clone https://github.com/Jaimedgp/ohitsmytmux.git /tmux_conf && \
    cd /tmux_conf && git checkout dev && \
    rm -rf /tmux_conf/.git /tmux_conf/README.md && \
    mv /tmux_conf/.tmux.conf /.tmux.conf


FROM ubuntu:24.04

ENV HOME="/home/jaimedgp"
ENV ZSH_CUSTOM="/home/jaimedgp/.config/zsh/ohitsmyzsh"
WORKDIR $HOME

RUN apt update && apt install -y git zsh tmux tcc python3 python3-venv

RUN rm -rf /home/ubuntu/ && \
    mkdir -p /home/jaimedgp/.config/zsh/ && \
    mkdir -p /home/jaimedgp/projects/

COPY --from=base-nvim /root/squashfs-root /opt/nvim
COPY --from=base-nvim /root/.local/share/nvim/lazy /home/jaimedgp/.local/share/nvim/lazy
COPY --from=base-nvim /root/.local/share/nvim/mason /home/jaimedgp/.local/share/nvim/mason
COPY --from=base-nvim /root/nvim /home/jaimedgp/.config/nvim
RUN ln -s /opt/nvim/usr/bin/nvim /usr/local/bin/nvim

COPY --from=base-zsh /zsh/.zshrc $HOME/.zshrc
COPY --from=base-zsh /zsh_custom $ZSH_CUSTOM
COPY --from=base-zsh /zsh/.oh-my-zsh/ $HOME/.config/zsh/.oh-my-zsh/

COPY --from=base-zsh /fzf/bin/fzf $HOME/.config/fzf/bin/fzf
COPY --from=base-zsh /fzf/src $HOME/.config/fzf/src
COPY --from=base-zsh /fzf/plugin $HOME/.config/fzf/plugin
COPY --from=base-zsh /fzf/shell/*.zsh $HOME/.config/fzf/shell/

COPY --from=base-tmux /tmux_conf/ $HOME/.config/tmux/ohitsmytmux/
COPY --from=base-tmux /.tmux.conf $HOME/.tmux.conf

ENTRYPOINT [ "/bin/zsh" ]
