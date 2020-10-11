FROM node:14-alpine as base

WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.19.0-alpine as prod-stage

COPY --from=base /app/dist/three-monkeys-ui /usr/share/nginx/html
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD [ "nginx","-g","daemon off;" ]
