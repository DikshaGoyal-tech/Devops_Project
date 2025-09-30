FROM node:20-alpine AS build
 
# Create non-root user and group for build stage (UID 1001)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup -u 1001
 
WORKDIR /usr/src/app
# copy package files first for better caching
COPY package*.json ./
# Install only production deps later — here install build deps
RUN npm ci --legacy-peer-deps
 
COPY . .
 
# Build (if you have a build step, e.g., TypeScript or bundler)
# RUN npm run build
 
# Remove dev deps to reduce image size (if using npm ci, and NODE_ENV=production later)
# Stage 2 — Runtime (minimal)
FROM node:20-alpine AS runtime
 
# Create non-root user in runtime image (same UID)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup -u 1001

WORKDIR /usr/src/app
 
# Copy only necessary artifacts from build stage
COPY --from=build --chown=appuser:appgroup /usr/src/app/package*.json ./
COPY --from=build --chown=appuser:appgroup /usr/src/app/node_modules ./node_modules
COPY --from=build --chown=appuser:appgroup /usr/src/app/dist ./dist
COPY --from=build --chown=appuser:appgroup /usr/src/app/src ./src
COPY --from=build --chown=appuser:appgroup /usr/src/app/.env ./
 
# Set NODE_ENV explicitly
ENV NODE_ENV=production
ENV PORT=3000
 
# Use an unprivileged port (>=1024 recommended); we set app to listen on PORT env var
USER appuser
 
# Drop capabilities (done by running non-root user; for extra hardening you could add a small wrapper)
# Expose only minimal port
EXPOSE 3000
 
CMD ["node", "dist/index.js"]
