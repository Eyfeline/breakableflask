FROM python:3.12-alpine

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# 🔧 AJOUT : paquets nécessaires pour compiler lxml
RUN apk add --no-cache \
    libxml2-dev \
    libxslt-dev \
    gcc \
    musl-dev

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY . /app

RUN adduser -D appuser \
    && chown -R appuser /app
USER appuser

EXPOSE 4000
CMD ["python", "main.py"]
