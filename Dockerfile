FROM lsiobase/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="blog.auska.win version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Auska"

ENV TZ=Asia/Shanghai PORT=5299 VER=3.6.6

RUN \
	echo "**** install packages ****" \
	&& apk add --no-cache curl unzip \
	&& cd /tmp \
	&& curl -fSL http://qiniu.zoranjojo.top/BaiduPCS-Go-${VER}-linux-amd64.zip -o baidupcs.zip \
	&& mkdir -p /defaults \
	&& unzip baidupcs.zip -d /defaults \
	&& mv /defaults/BaiduPCS-Go-${VER}-linux-amd64/BaiduPCS-Go /defaults/BaiduPCS-Go \
	&& rm -rf /defaults/BaiduPCS-Go-${VER}-linux-amd64 \
	&& apk del curl \
	&& rm -rf /tmp

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 5299
VOLUME /download
