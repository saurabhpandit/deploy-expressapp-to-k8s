FROM node:10-alpine AS build
WORKDIR /opt/deploy-expressapp-to-k8s
COPY package*.json ./

# install dep modules
RUN npm install

# Bundle app source
FROM node:10-alpine
WORKDIR /opt/deploy-expressapp-to-k8s
# Capture SHA and persist it env
ARG SHA
ENV SHA=${SHA}
COPY --from=build /opt/deploy-expressapp-to-k8s .
COPY . .
EXPOSE 8080

CMD ["node", "src/app.js"]
