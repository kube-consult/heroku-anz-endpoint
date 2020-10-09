FROM node:lts-alpine3.10
WORKDIR /usr/src/app
COPY package*.json ./
ARG SOURCE_COMMIT
ENV COMMIT_SHA=$SOURCE_COMMIT
RUN npm install
COPY . .
EXPOSE 3000
CMD [ "node", "server.js" ]
LABEL anz=yes
