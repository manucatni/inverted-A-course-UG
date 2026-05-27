FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install standard dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Switch to the non-root devcontainer user
USER vscode

# Install elan (Lean Version Manager) non-interactively
RUN curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y

# Add elan binaries to vscode user path
ENV PATH="/home/vscode/.elan/bin:${PATH}"

# Pre-fetch the Lean 4 toolchain (using standard version from the toolchain file)
WORKDIR /workspace
