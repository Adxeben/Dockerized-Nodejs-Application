# Use specific Alpine variant for minimal size
FROM node:20-alpine AS builder

WORKDIR /usr/src/app

# Copy dependency files first for better layer caching
COPY app/package*.json ./

# Install production dependencies only (no dev dependencies)
RUN npm ci --only=production --no-audit --no-fund

# -----------------------------------------------------------------------------
# Final stage – reduces image size by discarding build-time cruft
FROM node:20-alpine

# Install dumb-init to handle signals properly and avoid zombie processes
RUN apt-get update && apt-get install -y dumb-init


WORKDIR /usr/src/app

# Copy only production dependencies and app source from builder stage
COPY --from=builder --chown=node:node /usr/src/app/node_modules ./node_modules
COPY --chown=node:node app/ ./

# Switch to the built-in non-root user (UID 1000)
USER node

# Expose the application port
EXPOSE 3000

# Use dumb-init to handle signals and avoid orphaned Node.js processes
ENTRYPOINT ["dumb-init", "--"]

# Run the application
CMD ["node", "server.js"]