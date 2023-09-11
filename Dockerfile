# Use an official Apache HTTP Server image as the base image
FROM httpd:latest

# Expose port 80 (Apache's default port)
EXPOSE 80

# Start Apache HTTP Server when the container starts
CMD ["httpd", "-D", "FOREGROUND"]
