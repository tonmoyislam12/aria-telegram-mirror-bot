FROM node:alpine3.16
WORKDIR /bot/app/
RUN chmod 777 /bot/app
ENV LINK https://github.com/tonmoyislam12/alpine-builds/releases/download/v1.10/unrar.zip
RUN apk add --no-cache --update \
      ca-certificates git bash aria2 wget unzip curl \
      python3 python3-dev py3-pip py3-wheel alpine-sdk git libtool \
      autoconf automake linux-headers musl-dev m4 && mkdir -pv unrar \
      && mv /usr/bin/aria2c /usr/bin/mrbeast && wget $LINK && unzip unrar.zip -d unrar \
      && rm unrar.zip && cd unrar && apk add --allow-untrusted *.apk && \
      mkdir -pv /bot/test/ /bot/binary && pip3 install cython
COPY docker-publish/* /bot/test/
RUN cd /bot/test/ && python3 setup.py build_ext --inplace && \
    cp pewdiepie.cpython-310-x86_64-linux-gnu.so /bot/binary/pewdiepie.so
COPY race.py .
RUN python3 race.py && \
    mv src/.constants.js.example src/.constants.js && \
    npm i -g typescript && \
    yarn && \
    tsc && \
    rm -rf src/.constants.js && \
    rm -rf out/.constants.js
RUN ls -a . && ls -a src && ls -a out
