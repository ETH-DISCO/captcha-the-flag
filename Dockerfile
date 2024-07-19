FROM node:17

ENV DEBIAN_FRONTEND=noninteractive

# don't time out on large packages
RUN npm config set fetch-retry-maxtimeout 6000000
RUN npm config set fetch-retry-mintimeout 1000000

RUN npm install -g npm@latest
RUN npm install -g yarn@latest
RUN npm upgrade --global yarn 

# cd captcha
# yarn install


CMD ["tail", "-f", "/dev/null"]
