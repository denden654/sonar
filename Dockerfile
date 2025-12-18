# Utiliser une image Java OpenJDK
FROM openjdk:17

# Copier le JAR dans l'image
COPY target/sonar-0.0.1-SNAPSHOT.jar app.jar

# Exposer le port utilisé par Spring Boot
EXPOSE 8080

# Lancer l'application
ENTRYPOINT ["java","-jar","/app.jar"]
