# 1️⃣ Base Image (Lightweight Linux + Node)
FROM node:18-alpine

# 2️⃣ Set working directory inside container
WORKDIR /app

# 3️⃣ Copy dependency files first (layer caching)
COPY package*.json ./

# 4️⃣ Install dependencies
RUN npm install --production

# 5️⃣ Copy application code
COPY . .

# 6️⃣ Expose application port
EXPOSE 3000

# 7️⃣ Start the application
CMD ["npm", "start"]
