#!/bin/bash
set -e

# Function to initialize the application database
initialize_app_database() {
  # Wait for SQL Server to start up fully
  echo "Waiting for SQL Server to start..."
  sleep 30s

   /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P $SA_PASSWORD -d master -i /docker-setup.sql \
    -v DB_NAME="$DB_NAME" \
    -v DB_USER_LOGIN="$DB_USER_LOGIN" \
    -v DB_USER_PASSWORD="$DB_USER_PASSWORD"

  # Run setup script to create database, user, and set permissions
#   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i /docker-setup.sql
}

# If this is the container's first run, initialize the application database
if [ ! -f /tmp/app-initialized ]; then
  initialize_app_database &
fi

# Start the SQL Server process
exec /opt/mssql/bin/sqlservr

