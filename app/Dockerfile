# 1. Utiliser une image de base légère avec Python pré-installé
FROM python:3.9-slim

# 2. Définir le dossier de travail dans le conteneur
WORKDIR /app

# 3. Copier le fichier de dépendances en premier (optimisation du cache)
COPY requirements.txt .

# 4. Installer les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copier le reste du code source
COPY . .

# 6. Exposer le port sur lequel l'app tourne
EXPOSE 5000

# 7. La commande pour lancer l'application
CMD ["python", "app.py"]