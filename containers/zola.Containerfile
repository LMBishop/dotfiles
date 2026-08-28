FROM docker.io/alpine:3.23.5 AS base

WORKDIR /app

RUN wget https://github.com/getzola/zola/releases/download/v0.22.1/zola-v0.22.1-x86_64-unknown-linux-musl.tar.gz && \
    tar xzvf *.tar.gz

RUN cat <<'EOF' > /entrypoint.sh
#!/bin/sh

if [ "$1" = "serve" ]; then
    if [ "$#" -eq 1 ]; then
        exec /app/zola serve --interface 0.0.0.0 --base-url http://127.0.0.1
    fi
fi

exec /app/zola "$@"
EOF

RUN chmod +x /entrypoint.sh

WORKDIR /srv

EXPOSE 1111

ENTRYPOINT ["/entrypoint.sh"]
