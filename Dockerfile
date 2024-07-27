FROM node:lts AS build
RUN git clone https://github.com/n4mlz/blog.git app
WORKDIR /app
RUN npm install
COPY ./*.md ./src/content/posts/
COPY ./images/* ./src/content/posts/images/
RUN npm run build

FROM nginx:alpine AS runtime
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
