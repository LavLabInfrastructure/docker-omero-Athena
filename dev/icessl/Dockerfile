FROM docker.io/library/alpine:3.6

RUN apk add --no-cache \
    openjdk7-jre-base \
    py-openssl \
    py-pip
RUN pip install zeroc-icecertutils

ADD ice-ca-certs.py /usr/local/bin

# Certificates are written to the current working directory
WORKDIR /icessl
ENTRYPOINT ["/usr/local/bin/ice-ca-certs.py"]
