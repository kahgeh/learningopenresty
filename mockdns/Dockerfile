FROM node
ADD app/package.json ./package.json
ADD app/package-lock.json ./package-lock.json
ADD app/server.js ./server.js
ADD app/public/names.json ./public/names.json
RUN npm install      
EXPOSE 3005
ENTRYPOINT ["node","server.js"]