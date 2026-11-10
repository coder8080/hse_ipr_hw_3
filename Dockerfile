# digest 10.11.2026, amd64
FROM python:3.15.2-slim-trixie@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928

# curl for healthcheck
RUN apt-get update && apt-get install --no-install-recommends -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY app/requirements.txt .
RUN /usr/local/bin/pip install -r /app/requirements.txt

COPY app/* .

EXPOSE 8000/tcp

CMD ["/usr/local/bin/python3.15", "-u", "/app/app.py"]
