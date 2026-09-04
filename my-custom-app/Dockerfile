FROM nginx:alpine

# Custom files copy karein
COPY index.html /usr/share/nginx/html/index.html

# Nginx ko non-root port 8080 par sunne ke liye configure karein
# (Linux me 1024 se neeche ke ports bind karne ke liye root chahiye hota hai)
RUN sed -i 's/listen       80;/listen       8080;/' /etc/nginx/conf.d/default.conf

# Nginx cache aur PID files ki permissions non-root user 'nginx' ko dein
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid /var/cache/nginx /var/log/nginx /usr/share/nginx/html

# SECURITY FIX: Switch to non-root unprivileged user
USER nginx

# Hardened port
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
