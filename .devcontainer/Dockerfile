FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install additional packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    vim \
    nano \
    tree \
    htop \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Install Make
RUN apt-get update && apt-get install -y make

# Set up workspace
WORKDIR /workspace

# Create a non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN if ! getent group $USERNAME > /dev/null 2>&1; then \
        groupadd --gid $USER_GID $USERNAME; \
    fi \
    && if ! getent passwd $USERNAME > /dev/null 2>&1; then \
        useradd --uid $USER_UID --gid $USER_GID -m $USERNAME; \
    fi \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Switch to non-root user
USER $USERNAME

# Set up shell
RUN echo 'export PATH=$PATH:/home/vscode/go/bin' >> /home/vscode/.bashrc
RUN echo 'export PATH=$PATH:/home/vscode/go/bin' >> /home/vscode/.zshrc

# Default command
CMD ["sleep", "infinity"]
