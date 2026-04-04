FROM node:20-alpine 

# Set the working directory inside the container.
# All subsequent commands (COPY, RUN) will use this directory.
WORKDIR /usr/src/app

# Copy only dependency files first.
# This helps Docker cache the install step and avoid reinstalling on every build.
COPY ./app/package*.json ./

# Install only production dependencies (exclude devDependencies).
RUN npm ci --omit=dev

# Copy the rest of the application source code into the container.
COPY ./app ./

# Expose the port the app runs on.
EXPOSE 3000

# Start the application.
CMD ["node", "server.js"]