FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# nodejs
RUN apt-get update && apt-get install -y git npm curl wget python3 python3-pip
RUN npm install -g n
RUN n stable
RUN apt-get purge -y nodejs npm

# vue
RUN npm install -g @vue/cli


CMD ["tail", "-f", "/dev/null"]
