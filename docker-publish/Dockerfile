FROM node:alpine3.14
WORKDIR /bot/app/
RUN chmod 777 /bot/app
RUN apk add --no-cache --update \
      ca-certificates git bash aria2 wget unzip curl \
      python3 python3-dev py3-pip py3-wheel alpine-sdk git libtool \
      autoconf automake linux-headers musl-dev m4 \
      unrar && mv /usr/bin/aria2c /usr/bin/mrbeast && \
      mkdir -pv /bot/test/ /bot/binary && pip3 install cython
COPY docker-publish/* /bot/test/
RUN cd /bot/test/ && python3 setup.py build_ext --inplace && \
    cp pewdiepie.cpython-310-x86_64-linux-gnu.so /bot/binary/pewdiepie.so
RUN mv src/.constants.js.example src/.constants.js && \
    npm i -g typescript && \
    yarn && \
    tsc && \
    rm -rf src/.constants.js && \
    rm -rf out/.constants.js
