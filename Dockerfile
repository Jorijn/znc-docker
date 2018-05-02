FROM alpine:latest
LABEL maintainer Mijndert Stuij "mijndert@mijndertstuij.nl"

ENV ZNC_VERSION 1.6.6

RUN apk --update add --no-cache autoconf automake gettext-dev icu-dev g++ make openssl-dev \
                                pkgconfig zlib-dev python3 python3-dev wget sudo \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --no-cache-dir --upgrade pip requests \
    && mkdir -p /src \
    && cd /src \
    && wget "http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz" \
    && tar -zxf "znc-${ZNC_VERSION}.tar.gz" \
    && cd "znc-${ZNC_VERSION}" \
    && ./configure --disable-ipv6 --enable-python \
    && make -j8 \
    && make install \
    && apk del wget \
    && rm -rf /var/cache/apk/* /src/*

RUN adduser -D -H -g "" znc
ADD docker-entrypoint.sh /entrypoint.sh
ADD znc.conf.default /znc.conf.default
RUN chmod 644 /znc.conf.default

VOLUME /znc-data

EXPOSE 6667
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
