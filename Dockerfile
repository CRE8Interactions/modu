#############
### build ###
#############

# base image
FROM node:14 as build

# set working directory
WORKDIR /app

# install and cache app dependencies
COPY ./package*.json ./
RUN npm install

# add app
COPY . .

############
### prod ###
############

# base image
FROM nginx:1.19.6-alpine
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/public/ /usr/share/nginx/html