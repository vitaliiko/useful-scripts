FROM node:20.6.0-alpine3.18

WORKDIR /server

ARG CACHEBUST=0
RUN npm install -g json-server

EXPOSE 3001

CMD npx json-server db.json  --routes routes.json --port 3001
