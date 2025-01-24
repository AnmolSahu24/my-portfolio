# Use a smaller base image
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy only package files first to optimize caching
COPY package*.json yarn.lock ./

# Install dependencies without unnecessary cache files
RUN npm install -g npm@10.5.2 && yarn install --frozen-lockfile --production

# Copy application files
COPY . .

# Use a lightweight production base image
FROM node:18-alpine AS runtime

WORKDIR /app

# Copy only necessary files from builder stage
COPY --from=builder /app /app

EXPOSE 3000

CMD ["yarn", "start"]

