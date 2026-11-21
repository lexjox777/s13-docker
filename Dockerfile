FROM node:22-alpine

LABEL org.opencontainers.image.title="S13 Training Camps"

WORKDIR /app

COPY app/server.js ./server.js
COPY web/public ./public

RUN mkdir -p /data && chown -R node:node /data /app

USER node
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://127.0.0.1:8080/health || exit 1

CMD ["node", "server.js"]
