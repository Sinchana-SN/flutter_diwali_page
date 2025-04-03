# First stage: Build the Flutter web app
FROM cirrusci/flutter:latest AS build

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . .

# Get dependencies
RUN flutter pub get

# Build the Flutter web app
RUN flutter build web

# Second stage: Serve the built app with Nginx
FROM nginx:stable-alpine

# Copy the built web app from the build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose the port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]




