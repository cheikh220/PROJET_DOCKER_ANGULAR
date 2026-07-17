FROM node:22-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./
 
RUN npm ci 

COPY . . 

RUN npm run build -- --configuration production 

FROM nginx:alpine

COPY --from=build /app/dist/projet-docker-angular/browser /user/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/delfault.conf

EXPOSE 80