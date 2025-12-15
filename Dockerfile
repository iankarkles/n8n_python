# 1. Base Image
FROM n8nio/n8n:latest

# 2. Switch to Root
USER root

# 3. Install Python 3, PIP, and Dev Tools (Crucial for venv creation)
RUN apk add --update --no-cache \
    python3 \
    py3-pip \
    python3-dev \
    build-base \
    bash

# 4. Create symlink so 'python' points to 'python3'
RUN ln -sf /usr/bin/python3 /usr/bin/python

# 5. Pre-create the n8n directory and give 'node' user ownership
# This prevents permission errors when n8n tries to write the venv
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# 6. Switch back to node user
USER node

# 7. Force the Python path for n8n
ENV N8N_PYTHON_BINARY=/usr/bin/python3
