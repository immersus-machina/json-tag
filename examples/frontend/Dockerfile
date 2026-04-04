FROM node:22-slim AS build
WORKDIR /app
COPY typescript/ /lib/json-tag/
RUN cd /lib/json-tag && npm install && npx tsc
COPY examples/frontend/package.json examples/frontend/tsconfig.json examples/frontend/vite.config.ts ./
COPY examples/frontend/index.html ./
COPY examples/frontend/src/ src/
RUN sed -i 's|file:../../typescript|file:/lib/json-tag|' package.json
RUN npm install
RUN npx vite build

FROM node:22-slim
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/dist ./dist
EXPOSE 57661
CMD ["serve", "dist", "-l", "57661"]
