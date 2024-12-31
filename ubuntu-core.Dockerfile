# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables to prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary plugins
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    make \
    build-essential \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the default command to bash
CMD ["/bin/bash"]

