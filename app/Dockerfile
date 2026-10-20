FROM nginx:1.27.2-alpine

ARG BUILD_SHA=dev
ENV BUILD_SHA=${BUILD_SHA}

# Install curl for in-container health testing
RUN apk add --no-cache curl \
    && rm -rf /etc/nginx/conf.d/default.conf

# Copy custom configuration and static web page
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/index.html

# Inject the build SHA into the HTML template
RUN sed -i "s/__BUILD_SHA__/${BUILD_SHA}/g" /usr/share/nginx/html/index.html

# Set up required write permissions for the unprivileged nginx user
RUN touch /tmp/nginx.pid \
    && chown -R nginx:nginx /tmp/nginx.pid /usr/share/nginx/html /var/cache/nginx /var/log/nginx

USER nginx

EXPOSE 8080

HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD curl -f http://localhost:8080/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]
