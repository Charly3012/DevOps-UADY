FROM nginx:1.17.1-alpine

COPY /PaginaWeb /usr/share/nginx/html

EXPOSE 80