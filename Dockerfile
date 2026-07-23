FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libmagic1 \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

COPY music-player-source.zip /tmp/music-player-source.zip
RUN unzip -q /tmp/music-player-source.zip -d /app && \
    pip install --upgrade pip setuptools wheel && \
    pip install -r requirements.txt && \
    mkdir -p /app/media /app/logs && \
    adduser --disabled-password --gecos '' appuser && \
    chown -R appuser:appuser /app

USER appuser
EXPOSE 8000
ENTRYPOINT ["/app/entrypoint.sh"]
