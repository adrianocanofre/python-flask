FROM alpine:3.10

RUN apk add --no-cache --virtual .build-deps \
    alpine-sdk=1.0-r0  \
    git=2.22.0-r0  \
    libc6-compat=1.1.22-r3  \
    libffi-dev=3.2.1-r6  \
    linux-headers=4.19.36-r0 \
    nginx=1.16.1-r1  \
    python3-dev=3.7.5-r1 \
    supervisor=3.3.5-r0  \
    tzdata=2019c-r0 \
    uwsgi-python3=2.0.18-r1 \
    uwsgi=2.0.18-r1 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    rm -fr /var/cache/apk/* .build-deps

RUN pip3 install --upgrade pip==19.2.3 setuptools==41.4.0 && \
    rm /etc/nginx/conf.d/default.conf && \
    rm -r /root/.cache

COPY conf/nginx.conf /etc/nginx/
COPY conf/flask-site-nginx.conf /etc/nginx/conf.d/
COPY conf/uwsgi.ini /etc/uwsgi/
COPY conf/supervisord.conf /etc/supervisord.conf
