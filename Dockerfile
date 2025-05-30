FROM python:slim    

RUN apt-get update && apt-get install -y \
    cron \
    build-essential \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-cffi \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgdk-pixbuf2.0-0 \
    libffi-dev \
    shared-mime-info \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN python -m pip install --no-cache-dir -r requirements.txt

COPY run-notionbackup.sh /app/run-notionbackup.sh
RUN chmod +x /app/run-notionbackup.sh

RUN mkdir -p /app/logs /app/output

RUN touch /app/logs/cron.log

# Starte das Skript im Hintergrund und zeige die Logs an
CMD ["sh", "-c", "/app/run-notionbackup.sh & tail -f /app/logs/cron.log"]