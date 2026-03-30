FROM node:22-slim
WORKDIR /app
COPY typescript/ /lib/json-tag/
RUN cd /lib/json-tag && npm install && npx tsc
COPY examples/typescript/package.json examples/typescript/tsconfig.json ./
COPY examples/typescript/src/ src/
RUN sed -i 's|file:../../typescript|file:/lib/json-tag|' package.json
RUN npm install
EXPOSE 57660
CMD ["npx", "tsx", "src/server.ts"]
