# Use the official Flutter image
FROM ghcr.io/flutter/flutter:latest

# Set the working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies using Flutter (not Dart)
RUN flutter pub get

# Build the Flutter Web App
RUN flutter build web

# Use Nginx to serve the app
FROM nginx:stable-alpine
COPY --from=0 /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


