FROM nginxinc/nginx-unprivileged:alpine

# Explicitly upgrade libuuid and system packages to fix CVEs
USER root
RUN apk update && \
    apk upgrade --no-cache libuuid util-linux || true

COPY index.html /usr/share/nginx/html/index.html

RUN chown -R 101:101 /usr/share/nginx/html

USER 101

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
