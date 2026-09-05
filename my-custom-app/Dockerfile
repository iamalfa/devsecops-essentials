FROM nginxinc/nginx-unprivileged:alpine

# Apply latest security patches to OS packages at build time
USER root
RUN apk update && apk upgrade --no-cache

# Custom static files copy karein
COPY index.html /usr/share/nginx/html/index.html

# Ensure proper permissions
RUN chown -R 101:101 /usr/share/nginx/html

# Switch back to unprivileged user (UID 101)
USER 101

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
