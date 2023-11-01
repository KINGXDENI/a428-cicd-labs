# Gunakan image Node.js
FROM node:16-buster-slim

# Pindahkan direktori kerja ke /app
WORKDIR /app

# Salin package.json dan package-lock.json (atau yarn.lock jika Anda menggunakan Yarn)
COPY package*.json ./

# Instal dependensi
RUN npm install

# Salin seluruh proyek ke direktori kerja dalam kontainer
COPY . .

# Build aplikasi React
RUN npm run build

# Expose port yang akan digunakan (misalnya, port 3000)
EXPOSE 3000

# Jalankan aplikasi React
CMD ["npm", "start"]
