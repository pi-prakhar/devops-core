# Makefile to install Docker in the container

# Variables
DOCKER_INSTALL_URL := https://get.docker.com

.PHONY: all clean install-docker verify-docker

# Default target: install Docker and verify installation
all: install-docker verify-docker

# Install Docker
install-docker:
	@echo "Installing Docker..."
	@curl -fsSL $(DOCKER_INSTALL_URL) -o get-docker.sh
	@sh get-docker.sh
	@rm -f get-docker.sh

# Verify Docker installation
verify-docker:
	@echo "Verifying Docker installation..."
	@docker --version || (echo "Docker installation failed!" && exit 1)

# Clean up
clean:
	@echo "Cleaning up..."
	@rm -f get-docker.sh

