# Use a Node.js base image
FROM node:18

# Set the maintainer label
LABEL maintainer="miiro@getintodevops.com"

# Switch to root user to install Docker
USER root

# Install Docker
RUN apt-get update && apt-get install -y \
    docker.io \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install curl for the health check
RUN apt-get install -y curl

# Switch back to the Node user
USER node

# Set a health check for the container
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8000 || exit 1

# Tell Docker what port to expose
EXPOSE 8000

# Set the working directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the application files
COPY . .

# Command to run the application
CMD ["npm", "start"]
