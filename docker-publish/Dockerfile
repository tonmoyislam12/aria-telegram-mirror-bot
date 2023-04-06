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
COPY tsconfig.json package.json .eslintrc.js nodemon.json /bot/app/
COPY src/.constants.js.example .constants.js
RUN npm i -g typescript && \
    yarn && \
    tsc && \
    rm -rf .constants.js && \
    rm -rf out/.constants.js
RUN cd /bot/test/ && python3 setup.py build_ext --inplace && \
    cp pewdiepie.cpython-39-x86_64-linux-musl.so /bot/binary/pewdiepie.so
COPY start.sh race.py /bot/app/
RUN ls -a . && ls -a /bot/test/ && ls -a /bot/binary/
