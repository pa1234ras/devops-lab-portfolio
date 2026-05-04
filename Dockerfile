# Use an official lightweight web server
FROM nginx:alpine

# Copy your portfolio files into the web server directory
COPY . /usr/share/nginx/html

# Expose port 80 for the web traffic
EXPOSE 80
