# Use Ubuntu as the base image
FROM ubuntu:latest

# Install cowsay, fortune, and netcat
RUN apt update && \
    apt install -y cowsay fortune netcat && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the bash script into the container and name it server.sh
COPY server.sh /app/server.sh

# Make the script executable
RUN chmod +x /app/server.sh

# Expose the port that the script will use
EXPOSE 4499

# Set the entry point to run the script
ENTRYPOINT ["/app/server.sh"]