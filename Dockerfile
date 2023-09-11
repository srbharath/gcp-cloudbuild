# Use an official Nginx image as the base image
FROM nginx:latest

# Expose port 80
EXPOSE 80

# Copy custom configuration file (if needed)
# COPY nginx.conf /etc/nginx/nginx.conf

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
