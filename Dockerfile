# Use specific Alpine variant for minimal size
FROM node:20-alpine AS builder

WORKDIR /usr/src/app

# Copy dependency files first for better layer caching
COPY app/package*.json ./

# Install production dependencies only (no dev dependencies)
RUN npm ci --only=production --no-audit --no-fund

# -----------------------------------------------------------------------------
# Final stage – reduces image size by discarding build-time cruft
# (Single-stage is fine here; multi-stage shown for demonstration & future builds)
FROM node:20-alpine

# Install dumb-init to handle signals properly and avoid zombie processes
RUN apk add --no-cache dumb-init

# Create a non-root user and group
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 -G nodejs

WORKDIR /usr/src/app

# Copy only production dependencies and app source from builder stage
COPY --from=builder --chown=nodejs:nodejs /usr/src/app/node_modules ./node_modules
COPY --chown=nodejs:nodejs app/ ./

# Expose the application port
EXPOSE 3000

# Switch to non-root user
USER nodejs

# Health check – verify that the app responds on port 3000
# Adjust the endpoint if your app uses a specific health route (e.g., /health)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Use dumb-init to handle signals and avoid orphaned Node.js processes
ENTRYPOINT ["dumb-init", "--"]

# Run the application
CMD ["node", "server.js"]