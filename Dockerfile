<<<<<<< HEAD
# Dockerfile corrigé
FROM eclipse-temurin:17-jdk

# Copier le JAR généré par Maven
COPY target/TP-Projet-2025-0.0.1-SNAPSHOT.jar app.jar

# Exposer le port de Spring Boot
EXPOSE 8080

# Commande pour lancer Spring Boot
=======
FROM eclipse-temurin:17-jdk

COPY target/TP-Projet-2025-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8081

>>>>>>> a0a3d92 (Ajout des fichiers Kubernetes : deployment.yaml et service.yaml)
ENTRYPOINT ["java","-jar","/app.jar"]

