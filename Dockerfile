FROM node:18-alpine

WORKDIR /usr/src/app

# install openssl dependency for prisma
RUN apk add --no-cache openssl

# copy package files first to leverage Docker layer cache
COPY package.json package-lock.json ./

# install dependencies
RUN npm install

# copy rest of the source
COPY . .

# generate Prisma client
RUN npx prisma generate

EXPOSE 3000

CMD ["node", "src/main.js"]
