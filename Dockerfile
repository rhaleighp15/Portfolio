# Simple nginx image – web already built in build/web
FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy your pre-built Flutter web app
COPY build/web /usr/share/nginx/html

# Use nginx's built-in envsubst templating
# Place our config as a template; it will be rendered to conf.d on start
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
