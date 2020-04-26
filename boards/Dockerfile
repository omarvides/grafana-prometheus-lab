FROM alpine:3.11.5

COPY entrypoint.sh /opt/entrypoint.sh

RUN apk add curl && apk add jq

ENTRYPOINT [ "/opt/entrypoint.sh" ]