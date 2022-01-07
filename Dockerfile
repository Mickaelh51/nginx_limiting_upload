# docker build -f Dockerfile -t voip/nginx_upload_limit:0.1 .
# docker run --rm -i -t --name nginx_test voip/nginx_upload_limit:0.1

FROM nginx:alpine AS builder

# nginx:alpine contains NGINX_VERSION environment variable, like so:
# ENV NGINX_VERSION 1.15.0

WORKDIR /tmp

# For latest build deps, see https://github.com/nginxinc/docker-nginx/blob/master/mainline/alpine/Dockerfile
RUN apk add --no-cache --virtual .build-deps \
  gcc \
  libc-dev \
  make \
  openssl-dev \
  pcre-dev \
  zlib-dev \
  linux-headers \
  curl \
  gnupg \
  libxslt-dev \
  gd-dev \
  geoip-dev

# Download sources
RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" && tar xf nginx-${NGINX_VERSION}.tar.gz

# Reuse same cli arguments as the nginx:alpine image used to build
RUN cd nginx-${NGINX_VERSION} && \
  ./configure --with-compat $CONFARGS --with-stream && \
  make && make install

COPY nginx.conf /etc/nginx/nginx.conf
#COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]