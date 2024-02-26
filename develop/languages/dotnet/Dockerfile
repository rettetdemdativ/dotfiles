FROM ubuntu:22.04

RUN useradd -m vscode

RUN apt-get -y update && \
    apt-get install -y wget gpg && \
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && \
    sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    rm -f packages.microsoft.gpg

RUN apt -y install apt-transport-https && \
    apt -y update && \
    apt -y install code

RUN apt -y install libasound2 libxshmfence1 libx11-xcb1

RUN apt-get update && \
    apt-get install -y dotnet-sdk-8.0

USER vscode

RUN code --install-extension ms-dotnettools.csdevkit && \
    code --install-extension vscodevim.vim && \
    code --install-extension vscode-icons-team.vscode-icons

COPY ./settings.json /home/vscode/.config/Code/User/settings.json

RUN echo 'alias code="code --user-data-dir /home/vscode/.config/Code --extensions-dir /home/vscode/.vscode/extensions"' >> ~/.zshrc
