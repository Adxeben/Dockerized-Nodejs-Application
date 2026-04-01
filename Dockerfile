# Use lightweight Node.js base image
FROM node:20-alpine

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY app/package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy the rest of the app
COPY app/ ./

# Expose port your server listens on
EXPOSE 3000

# Default command to run the app
CMD ["node", "server.js"]