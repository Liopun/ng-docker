#############
### build ###
#############

# base image
FROM node:13.5.0-alpine3.11 as build-step
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

############
### prod ###
############

# base image
FROM nginx:1.18.0-alpine as prod-stage
# copy artifact build from the 'build environment'
COPY --from=build-step /app/dist/ng-docker /usr/share/nginx/html
# expose port 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
