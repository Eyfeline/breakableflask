FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Dossier de travail
WORKDIR /app

# Paquets système nécessaires pour lxml (et autres libs natives)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

# Copie des dépendances et installation
COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copie du code de l'application
COPY . .

# Variables d'environnement Flask
ENV FLASK_APP=main.py \
    FLASK_RUN_HOST=0.0.0.0 \
    FLASK_RUN_PORT=4000

# Port exposé par l'application
EXPOSE 4000

# Commande de lancement
CMD ["python", "main.py"]
