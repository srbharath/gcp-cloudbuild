# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy your Python application code into the container
COPY . /app/

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variables for the database connection
ENV DB_HOST 34.134.206.146
ENV DB_USER your-db-user
ENV DB_PASS your-db-password
ENV DB_NAME example-database

# Run app.py when the container launches
CMD ["python", "app.py"]
