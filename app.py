import psycopg2
from flask import Flask

app = Flask(__name__)

# Define a route to display "Hello, Bharath" when accessed
@app.route('/')
def hello_bharath():
    return 'Hello, Bharath32'

# Replace with your Cloud SQL instance connection details
db_config = {
    'dbname': 'my-instance',
    'user': 'username',
    'password': 'Password@123',
    'port': '5432'  # Default PostgreSQL port
}

# Connect to the Cloud SQL instance
try:
    connection = psycopg2.connect(**db_config)
    cursor = connection.cursor()
    
    # Execute SQL queries or perform database operations here

    # Example: Creating a table
    create_table_query = """
    CREATE TABLE IF NOT EXISTS example_table (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255)
    )
    """
    cursor.execute(create_table_query)
    connection.commit()

except Exception as e:
    print(f"Error: {str(e)}")

finally:
    if 'cursor' in locals():
        cursor.close()
    if 'connection' in locals():
        connection.close()

if __name__ == '__main__':
    # Run the Flask app on host '0.0.0.0' and port 8080
    app.run(host='0.0.0.0', port=8080)
