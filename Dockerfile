FROM node:16-bullseye-slim

EXPOSE 3000

# change permissions to non-root user
RUN mkdir /app && chown -R node:node /app

WORKDIR /app

USER node

# copy in with correct permissions. Using * prevents errors if file is missing
COPY --chown=node:node package*.json ./

# use ci to only install packages from lock files
# we don't have a dev image/stage yet (in future example)
RUN npm install
# RUN NODE_ENV=production npm ci --only=production && npm cache clean --force

# copy files with correct permissions
COPY --chown=node:node . .

# Start the server using the production build
CMD ["npm", "start"]
