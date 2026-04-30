# Stage 1: Build the static website
FROM node:18-alpine AS builder
WORKDIR /app

# Copy dependency manifests and install
COPY package*.json ./
RUN npm install

# Copy all files and run the Parcel build script
COPY . .
RUN npm run build

# Stage 2: Serve the website
FROM nginx:alpine
# Copy the built assets from the 'dist' folder to Nginx's web folder
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 and start Nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]