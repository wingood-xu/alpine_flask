# base image
FROM alpine
# MAINTAINER
MAINTAINER wingood 122782387@qq.com
# change mirror
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories
ENV APP_DIR /app

# install bash
RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash \
        bash-doc \
        bash-completion \
        && rm -rf /var/cache/apk/*
# install python3 env
RUN apk add --no-cache python3 \
        && python3 -m ensurepip \
        && rm -r /usr/lib/python*/ensurepip \
        && pip3 install --default-timeout=100 --no-cache-dir --upgrade pip \
        && pip3 install --default-timeout=100 --no-cache-dir --upgrade setuptools \
        && pip3 install --default-timeout=100 --no-cache-dir --upgrade flask \
        && if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi \
        && if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi \
        && rm -rf /var/cache/apk/* \
        && rm -rf ~/.cache/pip \
        && mkdir ${APP_DIR}
VOLUME ${APP_DIR}
WORKDIR ${APP_DIR}
ENTRYPOINT [ "/bin/bash" ]
