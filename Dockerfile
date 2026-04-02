FROM node:20-alpine

WORKDIR /usr/src/app

# Copy package files first for caching
COPY app/package*.json ./
RUN npm ci --only=production

# Copy the rest of the app
COPY app/ ./

# Expose port
EXPOSE 3000

# Run server
CMD ["node", "server.js"]