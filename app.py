# app.py
import os
import mysql.connector

# Retrieve environment variables for database configuration
db_host = os.environ['DB_HOST']
db_user = os.environ['DB_USER']
db_pass = os.environ['DB_PASS']
db_name = os.environ['DB_NAME']

# Create a database connection
try:
    connection = mysql.connector.connect(
        host=db_host,
        user=db_user,
        password=db_pass,
        database=db_name
    )

    if connection.is_connected():
        print("Connected to the database")
        cursor = connection.cursor()

        # Execute database operations here
        # For example, you can fetch data from a table
        cursor.execute("SELECT * FROM your_table")
        for row in cursor.fetchall():
            print(row)

except Exception as e:
    print("Error:", e)

finally:
    if 'connection' in locals():
        connection.close()
        print("Database connection closed")
