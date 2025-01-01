# Makefile for installing DevOps tools with colored output
# Color definitions
BLUE := \033[1;34m
GREEN := \033[1;32m
RED := \033[1;31m
YELLOW := \033[1;33m
NC := \033[0m # No Color

INFO := @echo "$(BLUE)INFO:$(NC)"
SUCCESS := @echo "$(GREEN)SUCCESS:$(NC)"
ERROR := @echo "$(RED)ERROR:$(NC)"
WARN := @echo "$(YELLOW)WARN:$(NC)"

INFO_T := echo "$(BLUE)INFO:$(NC)"
SUCCESS_T := echo "$(GREEN)SUCCESS:$(NC)"
ERROR_T := echo "$(RED)ERROR:$(NC)"
WARN_T := echo "$(YELLOW)WARN:$(NC)"

# Variables
DOCKER_INSTALL_URL := https://get.docker.com
KUBECTL_VERSION := $(shell curl -L -s https://dl.k8s.io/release/stable.txt)
HELM_VERSION := v3.14.0
KIND_VERSION := v0.20.0
TERRAFORM_VERSION := 1.7.0

.PHONY: all clean install-docker verify-docker install-kubectl install-helm install-kind install-terraform verify-all uninstall-all

# Default target: install and verify all tools
all: install-all verify-all

install-all: install-docker install-kubectl install-helm install-kind install-terraform
	$(SUCCESS) All tools installed successfully

# Install Docker
install-docker:
	$(INFO) Installing Docker...
	@curl -fsSL $(DOCKER_INSTALL_URL) -o get-docker.sh
	@sh get-docker.sh
	@rm -f get-docker.sh
	$(SUCCESS) Docker installed successfully

# Install kubectl
install-kubectl:
	$(INFO) Installing kubectl $(KUBECTL_VERSION)...
	@curl -LO "https://dl.k8s.io/release/$(KUBECTL_VERSION)/bin/linux/amd64/kubectl"
	@chmod +x kubectl
	@mv kubectl /usr/local/bin/
	$(SUCCESS) kubectl installed successfully

# Install Helm
install-helm:
	$(INFO) Installing Helm $(HELM_VERSION)...
	@curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
	@chmod +x get_helm.sh
	@./get_helm.sh --version $(HELM_VERSION)
	@rm -f get_helm.sh
	$(SUCCESS) Helm installed successfully

# Install KIND
install-kind:
	$(INFO) Installing KIND $(KIND_VERSION)...
	@curl -Lo ./kind https://kind.sigs.k8s.io/dl/$(KIND_VERSION)/kind-linux-amd64
	@chmod +x kind
	@mv kind /usr/local/bin/
	$(SUCCESS) KIND installed successfully

# Install Terraform
install-terraform:
	$(INFO) Installing Terraform $(TERRAFORM_VERSION)...
	@curl -fsSL -o terraform.zip https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_linux_amd64.zip
	@unzip -o terraform.zip
	@mv terraform /usr/local/bin/
	@rm -f terraform.zip
	$(SUCCESS) Terraform installed successfully

# Verify all installations
verify-all:
	$(INFO) "Verifying all installations..."
	@if command -v docker >/dev/null 2>&1; then \
		$(SUCCESS_T) "Docker verification passed"; \
	else \
		$(ERROR_T) "Docker verification failed"; \
		exit 1; \
	fi
	@if command -v kubectl >/dev/null 2>&1; then \
		$(SUCCESS_T) "kubectl verification passed"; \
	else \
		$(ERROR_T) "kubectl verification failed"; \
		exit 1; \
	fi
	@if command -v helm >/dev/null 2>&1; then \
		$(SUCCESS_T) "Helm verification passed"; \
	else \
		$(ERROR_T) "Helm verification failed"; \
		exit 1; \
	fi
	@if command -v kind >/dev/null 2>&1; then \
		$(SUCCESS_T) "KIND verification passed"; \
	else \
		$(ERROR_T) "KIND verification failed"; \
		exit 1; \
	fi
	@if command -v terraform >/dev/null 2>&1; then \
		$(SUCCESS_T) "Terraform verification passed"; \
	else \
		$(ERROR_T) "Terraform verification failed"; \
		exit 1; \
	fi
	$(SUCCESS) "All tools verified successfully!"


# Uninstall all tools
uninstall-all:
	$(WARN) Starting complete uninstallation...
	# Uninstall Docker and dependencies
	$(INFO) Uninstalling Docker...
	@if command -v docker > /dev/null; then \
		for svc in docker.socket docker.service containerd.service; do \
			systemctl stop $$svc 2>/dev/null || true; \
		done; \
		apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; \
		apt-get autoremove -y; \
		rm -rf /var/lib/docker /var/lib/containerd /etc/docker; \
		$(SUCCESS_T) Docker uninstalled; \
	else \
		$(WARN_T) Docker not found; \
	fi

	# Uninstall kubectl
	$(INFO) Uninstalling kubectl...
	@if [ -f /usr/local/bin/kubectl ]; then \
		rm -f /usr/local/bin/kubectl; \
		rm -rf ~/.kube; \
		$(SUCCESS_T) kubectl uninstalled; \
	else \
		$(WARN_T) kubectl not found; \
	fi

	# Uninstall Helm
	$(INFO) Uninstalling Helm...
	@if command -v helm > /dev/null; then \
		rm -f /usr/local/bin/helm; \
		rm -rf ~/.helm; \
		$(SUCCESS_T) Helm uninstalled; \
	else \
		$(WARN_T) Helm not found; \
	fi

	# Uninstall KIND
	$(INFO) Uninstalling KIND...
	@if command -v kind > /dev/null; then \
		kind delete clusters --all 2>/dev/null || true; \
		rm -f /usr/local/bin/kind; \
		$(SUCCESS_T) KIND uninstalled; \
	else \
		$(WARN_T) KIND not found; \
	fi

	# Uninstall Terraform
	$(INFO) Uninstalling Terraform...
	@if command -v terraform > /dev/null; then \
		rm -f /usr/local/bin/terraform; \
		rm -rf ~/.terraform.d; \
		$(SUCCESS_T) Terraform uninstalled; \
	else \
		$(WARN_T) Terraform not found; \
	fi

# Clean up temporary files and uninstall all tools
clean: uninstall-all
	$(WARN) Cleaning up temporary files...
	@rm -f get-docker.sh get_helm.sh terraform.zip terraform kind kubectl
	$(SUCCESS) Cleanup completed

# Clean only temporary files without uninstalling
clean-files:
	$(WARN) Cleaning up temporary files...
	@rm -f get-docker.sh get_helm.sh terraform.zip terraform kind kubectl
	$(SUCCESS) File cleanup completed
