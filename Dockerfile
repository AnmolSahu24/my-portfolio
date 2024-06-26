FROM node:alpine

RUN mkdir /app

WORKDIR '/app'

COPY package*.json yarn.lock ./


RUN npm install -g npm@10.5.2

RUN yarn install


COPY . ./

EXPOSE 3000

CMD ["yarn","start"]
