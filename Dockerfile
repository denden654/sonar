# Image Java officielle recommandée
FROM eclipse-temurin:17-jdk

# Copier le JAR dans l'image
COPY target/sonar-0.0.1-SNAPSHOT.jar app.jar

# Exposer le port Spring Boot
EXPOSE 8080

# Lancer l'application
ENTRYPOINT ["java","-jar","/app.jar"]
