# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the Python script into the container
COPY app.py /app/

# Install any necessary dependencies (e.g., psycopg2 and gunicorn)
RUN pip install psycopg2-binary gunicorn
RUN pip install Flask

# Run your Python application using Gunicorn on port 8080
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
