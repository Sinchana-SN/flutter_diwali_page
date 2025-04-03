# Use the official Dart image as a base
FROM dart:stable AS build

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . .

# Install dependencies
RUN dart pub get

# Build the Flutter Web App
RUN flutter build web

# Use Nginx to serve the Flutter Web App
FROM nginx:stable-alpine
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

