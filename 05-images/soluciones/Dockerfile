FROM node:20

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

ENV NODE_ENV=production \
    PORT=3000 \ 
    DEBUG_REQUEST=false \
    ENABLE_AUTH=true \
    DB_HOST=localhost \
    DB_PORT=5432 \
    USE_DB=false

EXPOSE 3000

RUN npm run build

CMD [ "node", "dist/main.js" ]
