#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e
# Wait for the database to be ready
if [ "$DATABASE" = "mysql" ]; then
    echo "Waiting for MySQL..."

    while ! nc -z $DATABASE_HOST 3306; do
        sleep 0.1
    done

    echo "MySQL started"
fi

# Apply database migrations
echo "Applying database migrations..."
python3 manage.py migrate
python3 manage.py makemigrations
# Collect static files
echo "Collecting static files..."
python3 manage.py collectstatic --noinput
cd /project

# Start Django server
exec "$@"