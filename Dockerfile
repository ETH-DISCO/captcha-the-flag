FROM node:16


# FROM ubuntu:20.04

# ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && apt-get install -y git npm curl wget python3 python3-pip
# RUN npm install -g n
# RUN n stable
# RUN npm install -g npm@17
# RUN npm install -g yarn

# RUN yarn global add @vue/cli
# RUN yarn global add @vue/cli-init
# RUN yarn global add @vue/cli-service-global
# RUN yarn global add @vue/cli-plugin-babel
# RUN yarn global add @vue/cli-plugin



CMD ["tail", "-f", "/dev/null"]
