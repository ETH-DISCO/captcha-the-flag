FROM node:21

ENV DEBIAN_FRONTEND=noninteractive

# don't time out on large packages
RUN npm config set fetch-retry-maxtimeout 6000000
RUN npm config set fetch-retry-mintimeout 1000000

# cd captcha
# npm install




CMD ["tail", "-f", "/dev/null"]
