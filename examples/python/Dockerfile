FROM python:3.12-slim
WORKDIR /app
COPY python/ /lib/json-tag/
RUN pip install /lib/json-tag fastapi uvicorn --no-cache-dir -q
COPY examples/python/src/ src/
EXPOSE 57660
ENV PYTHONPATH=/app/src
CMD ["python", "src/main.py"]
