#------------------------------------------------------------------------------------------------------
FROM ubuntu:24.04 AS build-nvim

RUN apt update && apt install -y curl cmake python3 python3-venv git

RUN curl -o /root/nvim.appimage -L https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.appimage && \
    chmod u+x /root/nvim.appimage && \
    cd /root && \
    /root/nvim.appimage --appimage-extract

RUN git clone https://github.com/Jaimedgp/ohitsmynvim.git $HOME/.config/nvim/ && \
    cd $HOME/.config/nvim/ && git checkout docker && \
    /root/squashfs-root/usr/bin/nvim -c "MasonToolsInstall" -c "sleep 40" -c "echo stdpath('data')" -c "sleep 20" +qall && \
    mkdir -p /root/nvim/ && \
    mv $HOME/.config/nvim/lua/ /root/nvim/ && \
    mv $HOME/.config/nvim/init.lua /root/nvim/


#------------------------------------------------------------------------------------------------------
FROM ubuntu:24.04 AS build-term

RUN apt update && apt install -y curl git zsh tmux

WORKDIR /zsh

RUN cd /zsh && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    ls && \
    mv $HOME/.oh-my-zsh/ /zsh/

# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /fzf \
  && /fzf/install --key-bindings --update-rc --completion --no-bash --no-fish --all --xdg

# custom zsh
RUN git clone https://github.com/Jaimedgp/ohitsmyzsh.git /zsh_custom && \
    mv /zsh_custom/templates/zshrc.zsh-template /zsh/.zshrc && \
    rmdir /zsh_custom/templates && rm -rf .git/ .gitignore

# zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-autosuggestions /zshasgg && \
    mkdir -p /zsh_custom/plugins/zsh-autosuggestions && \
    mv /zshasgg/src /zsh_custom/plugins/zsh-autosuggestions/src && \
    mv /zshasgg/spec /zsh_custom/plugins/zsh-autosuggestions/spec && \
    mv /zshasgg/zsh-autosuggestions.*zsh /zsh_custom/plugins/zsh-autosuggestions/

# zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /zshsynt && \
    mkdir -p /zsh_custom/plugins/zsh-syntax-highlighting/ && \
    mv /zshsynt/highlighters/ /zsh_custom/plugins/zsh-syntax-highlighting/highlighters/ && \
    mv /zshsynt/images/ /zsh_custom/plugins/zsh-syntax-highlighting/images/ && \
    mv /zshsynt/.revision-hash /zsh_custom/plugins/zsh-syntax-highlighting/.revision-hash && \
    mv /zshsynt/.version /zsh_custom/plugins/zsh-syntax-highlighting/.version && \
    mv /zshsynt/zsh-syntax-highlighting*.zsh /zsh_custom/plugins/zsh-syntax-highlighting/

RUN git clone https://github.com/Jaimedgp/ohitsmytmux.git /tmux_conf && \
    cd /tmux_conf && git checkout dev && \
    rm -rf /tmux_conf/.git /tmux_conf/README.md && \
    mv /tmux_conf/.tmux.conf /.tmux.conf

#------------------------------------------------------------------------------------------------------
FROM python:3.12-slim AS build-python

RUN python -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir pandas

#------------------------------------------------------------------------------------------------------
FROM docker.nexus.predictia.es/iglesiasd/torch:12.0.0 AS base

ENV HOME="/home/jaimedgp"
ENV ZSH_CUSTOM="/home/jaimedgp/.config/zsh/ohitsmyzsh"
WORKDIR $HOME

# Install locales if not already installed
RUN apt update && apt install -y locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV TERM="xterm-256color"

RUN apt update && apt install -y git zsh tmux tcc tree

RUN rm -rf /home/ubuntu/ && \
    mkdir -p /home/jaimedgp/.config/zsh/ && \
    mkdir -p /home/jaimedgp/projects/

# COPY --from=build-python /usr/local/lib/ /usr/local/lib/
# COPY --from=build-python /usr/local/bin/python /usr/local/bin/python
# COPY --from=build-python /opt/venv /opt/venv
# ENV PATH="/opt/venv/bin:$PATH"
#
COPY --from=build-nvim /root/squashfs-root /opt/nvim
COPY --from=build-nvim /root/.local/share/nvim/lazy /home/jaimedgp/.local/share/nvim/lazy
COPY --from=build-nvim /root/.local/share/nvim/mason /home/jaimedgp/.local/share/nvim/mason
COPY --from=build-nvim /root/nvim /home/jaimedgp/.config/nvim/
RUN ln -s /opt/nvim/usr/bin/nvim /usr/local/bin/nvim

COPY --from=build-term /zsh/.zshrc $HOME/.zshrc
COPY --from=build-term /zsh_custom $ZSH_CUSTOM
COPY --from=build-term /zsh/.oh-my-zsh/ $HOME/.config/zsh/.oh-my-zsh/

COPY --from=build-term /fzf/bin/fzf $HOME/.config/fzf/bin/fzf
COPY --from=build-term /fzf/src $HOME/.config/fzf/src
COPY --from=build-term /fzf/plugin $HOME/.config/fzf/plugin
COPY --from=build-term /fzf/shell/*.zsh $HOME/.config/fzf/shell/

COPY --from=build-term /tmux_conf/ $HOME/.config/tmux/ohitsmytmux/
COPY --from=build-term /.tmux.conf $HOME/.tmux.conf

ENTRYPOINT [ "/bin/zsh" ]

#------------------------------------------------------------------------------------------------------
FROM base AS base-python

RUN /opt/venv/bin/pip install --no-cache-dir pandas xarray jupyterlab
