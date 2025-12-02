FROM python:3.11-slim

# Dossier de travail
WORKDIR /app

# Copie des dépendances et installation
COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copie du code de l'application
COPY . .

# Variables d'environnement Flask
ENV FLASK_APP=main.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=4000

# Port exposé par l'application
EXPOSE 4000

# Commande de lancement
CMD ["python", "main.py"]
