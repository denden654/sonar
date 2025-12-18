# Utiliser une image Java OpenJDK
FROM openjdk:17-jdk-slim

# Ajouter un volume (optionnel)
VOLUME /tmp

# Copier le jar compilé dans l'image
COPY target/TP-Projet-2025.jar app.jar

# Exposer le port sur lequel l'application va tourner
EXPOSE 8080

# Commande pour lancer l'application
ENTRYPOINT ["java","-jar","/app.jar"]
