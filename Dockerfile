FROM node:18-alpine

ENV NODE_ENV=production \
    DB_TYPE=postgres \
    DB_HOST=172.17.0.2 \
    DB_PORT=5432 \
    DB_USER=postgres \
    DB_PASSWORD=postgrespw \
    DB_NAME=postgres \
    JWT_SECRET=qwer1234

# Create app directory
WORKDIR /usr/src/app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

# Install app dependencies
RUN npm i -g @nestjs/cli \
    && npm ci --only=production

# Bundle app source
COPY . .

# Creates a "dist" folder with the production build
RUN npm run build

# Expose API port
EXPOSE 3000

# Start the server using the production build
CMD [ "node", "dist/app.js" ]
