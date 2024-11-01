FROM node:18
RUN npm install -g @nestjs/cli
RUN apt update && apt-get install -y sqlite3
RUN apt update && apt-get install -y nano
RUN npm install -g sqlite-web
RUN useradd -ms /bin/bash vscode
RUN mkdir -p /workspace && chown -R vscode:vscode /workspace
USER vscode
WORKDIR /workspace