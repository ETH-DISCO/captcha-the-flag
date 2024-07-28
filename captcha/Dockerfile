FROM node:14-alpine

# ENV NODE_OPTIONS=--openssl-legacy-provider
RUN npm config set fetch-retry-maxtimeout 6000000
RUN npm config set fetch-retry-mintimeout 1000000

WORKDIR /workspace/captcha
COPY package*.json ./
RUN npm install
RUN npm install --only=dev
RUN npm install -g @vue/cli-service

COPY . .

RUN npm run build

CMD ["npm", "run", "serve"]
