FROM node:17

ENV DEBIAN_FRONTEND=noninteractive

RUN npm config set fetch-retry-maxtimeout 6000000
RUN npm config set fetch-retry-mintimeout 1000000
RUN yarn config set network-timeout 600000

ENV NODE_OPTIONS=--openssl-legacy-provider
RUN yarn install

CMD ["yarn", "serve"]
