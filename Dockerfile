FROM mysql:5.7

# Copy the database schema to the /data directory
COPY ./db.sql /docker-entrypoint-initdb.d/db.sql