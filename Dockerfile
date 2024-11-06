# Using Ubuntu as the base image
FROM ubuntu:latest

# Installation of server
RUN apt update && \
    apt install -y apache2

# Working directory
WORKDIR /app

# Copying the bash script into the container
COPY server.sh /app/server.sh

# Making the script executable
RUN chmod +x /app/server.sh

# Exposing the port that the script will use
EXPOSE 4499

# Setting entry point to run the script
ENTRYPOINT ["/app/server.sh"]