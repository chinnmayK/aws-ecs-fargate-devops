FROM node:18-alpine

# Install nginx & pm2
RUN apk add --no-cache nginx \
 && npm install -g pm2

# Set working directory
WORKDIR /app

# Copy app package files
COPY app/package*.json ./app/
RUN cd app && npm install --production

# Copy rest of the app
COPY app ./app

# Copy nginx config
COPY nginx/default.conf /etc/nginx/http.d/default.conf

# Expose HTTP only
EXPOSE 80

# Start PM2 + Nginx
CMD sh -c "cd app && pm2 start ecosystem.config.js && nginx -g 'daemon off;'"
