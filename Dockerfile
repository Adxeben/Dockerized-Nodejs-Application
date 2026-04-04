# Build stage
FROM node:20-alpine AS builder

# working dir for container- this is where copying goes to and command execution happens
WORKDIR /usr/src/app

# copying dependency file to container dir and installing dependencies inside it
COPY ./app/package*.json ./
RUN npm ci --only=production

# copying source file to container
COPY ./app ./

# --------------------------------
# Run stage
FROM node:20-alpine

WORKDIR /usr/src/app

# Copy files from the builder stage into the current stage.
COPY --from=builder /usr/src/app .

EXPOSE 3000

CMD ["node", "server.js"]