FROM node:slim

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y make build-essential g++ gcc python2.7 tmux git --no-install-recommends
RUN npm install -g forever

RUN git clone https://github.com/c9/core.git /cloud9
RUN /cloud9/scripts/install-sdk.sh
RUN mkdir /workspace
RUN git init /workspace
ADD project.settings /workspace/.c9/project.settings
ADD user.settings /root/.c9/user.settings

EXPOSE 8181
CMD forever /cloud9/server.js -w /workspace --listen 0.0.0.0 --auth dev:dev

