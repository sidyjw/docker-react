FROM node:alpine as dev
WORKDIR /app
COPY package.json .
RUN npm i
COPY . .
EXPOSE 3000
ENTRYPOINT ["npm"]
CMD ["start"]

FROM node:alpine as builder
WORKDIR /app
COPY --from=dev /app .          
RUN npm run build

FROM nginx:alpine as prod
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html