# Stage 1: Build the Flutter web app
FROM debian:stable-slim AS build

# Install dependencies for Flutter + web build
RUN apt-get update && apt-get install -y \
  curl unzip xz-utils git ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Set up Flutter SDK
WORKDIR /opt
RUN git clone https://github.com/flutter/flutter.git -b stable
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Pre-download Flutter dependencies
RUN flutter precache
RUN flutter config --enable-web

# Copy your Flutter project into the container
WORKDIR /app
COPY . .

# Get packages & build web release
RUN flutter pub get
RUN flutter build web --release

# Stage 2: Use nginx to serve the built web app
FROM nginx:alpine

# Remove default nginx static content
RUN rm -rf /usr/share/nginx/html/*

# Copy Flutter web build to nginx html folder
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy a basic nginx config (optional but recommended)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
