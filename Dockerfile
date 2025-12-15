FROM n8nio/n8n:latest

USER root

# 1. Install Python3 and PIP
# We also verify no cache is kept to keep image small
RUN apk add --update --no-cache python3 py3-pip

# 2. CRITICAL: Create a symlink for 'python' -> 'python3'
# Some internal n8n scripts call 'python' directly
RUN ln -sf /usr/bin/python3 /usr/bin/python

# 3. CRITICAL: Pre-create the directory n8n uses for python envs
# and give ownership to the 'node' user to prevent permission errors
RUN mkdir -p /home/node/.n8n/python_env \
    && chown -R node:node /home/node/.n8n

USER node
