FROM alpine:latest

RUN apk add --update go libc-dev curl git make bash
ENV GOPATH /go
ENV MTAIL_SRC /go/src/github.com/google/mtail
ENV MTAIL_VERSION v3.0.0-rc12

RUN mkdir -p "${MTAIL_SRC%/mtail}" \
    && curl -L "https://github.com/google/mtail/archive/$MTAIL_VERSION.tar.gz" > /tmp/mtail.tar.gz \
    && tar -C "${MTAIL_SRC%/mtail}" -zxf /tmp/mtail.tar.gz \
    && mv "${MTAIL_SRC%/mtail}/mtail-${MTAIL_VERSION#v}" "$MTAIL_SRC" \
    && rm -f /tmp/mtail.tar.gz

RUN PATH="$PATH:$GOPATH/bin" make -C "$MTAIL_SRC" \
 && make -C "$MTAIL_SRC" install \
 && mv "$GOPATH/bin/mtail" /usr/bin/mtail \
 && rm -rf "$GOPATH"

ADD mtail-entrypoint.sh /mtail-entrypoint.sh
RUN chmod a+x /mtail-entrypoint.sh
VOLUME /var/spool/mtail
VOLUME /etc/mtail
EXPOSE 9197
ENTRYPOINT ["/mtail-entrypoint.sh"] 
