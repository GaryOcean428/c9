#!/bin/bash

# Database connection script for C9 IDE
# This script helps connect to the Postgres-8xv service

echo "=== Database Connection Setup ==="

# Check if PostgreSQL environment variables are set
if [ -n "$DATABASE_URL" ]; then
    echo "DATABASE_URL detected: Using Railway PostgreSQL connection"
    export PGURL="$DATABASE_URL"
elif [ -n "$POSTGRES_HOST" ] && [ -n "$POSTGRES_USER" ] && [ -n "$POSTGRES_PASSWORD" ] && [ -n "$POSTGRES_DATABASE" ]; then
    echo "Individual PostgreSQL variables detected"
    export PGHOST="$POSTGRES_HOST"
    export PGPORT="${POSTGRES_PORT:-5432}"
    export PGDATABASE="$POSTGRES_DATABASE"
    export PGUSER="$POSTGRES_USER"
    export PGPASSWORD="$POSTGRES_PASSWORD"
    export PGURL="postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:${POSTGRES_PORT:-5432}/$POSTGRES_DATABASE"
else
    echo "No PostgreSQL connection variables found"
    echo "Please set DATABASE_URL or individual POSTGRES_* environment variables"
fi

# Create a convenient psql alias
if [ -n "$PGURL" ]; then
    echo "Creating database connection alias..."
    echo "alias db='psql \$PGURL'" >> /root/.bashrc
    echo "alias dbconnect='psql \$PGURL'" >> /root/.bashrc
    
    # Test connection
    echo "Testing database connection..."
    if psql "$PGURL" -c "SELECT version();" > /dev/null 2>&1; then
        echo "✅ Database connection successful!"
        echo "Use 'db' or 'dbconnect' command to connect to PostgreSQL"
    else
        echo "❌ Database connection failed. Please check your credentials."
    fi
fi

echo "=== Database Setup Complete ==="