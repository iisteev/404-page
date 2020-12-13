# build
FROM node:14.15-alpine as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY . .
RUN yarn install
RUN yarn build

# production
FROM nginx:stable-alpine as production
WORKDIR /app
RUN apk update && apk upgrade

COPY --from=build /app/dist /usr/share/nginx/html
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && \
            nginx -g 'daemon off;'
