# Simple nginx image only – web is already built in build/web
FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy your pre-built Flutter web app
COPY build/web /usr/share/nginx/html

# Basic nginx config for single-page apps
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
