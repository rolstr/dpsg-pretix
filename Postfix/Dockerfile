# Dockerfile for Postfix with custom entrypoint
FROM debian:bookworm

# Install Postfix and necessary utilities
RUN apt-get update && \
    apt-get install -y postfix sasl2-bin mailutils && \
    apt-get clean

# Create directory for Postfix SASL password
RUN mkdir -p /etc/postfix/sasl

# Copy the entrypoint script into the container
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Open port 25 for Postfix
EXPOSE 25

# Use the entrypoint script to handle everything
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
