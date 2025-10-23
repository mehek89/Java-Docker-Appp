# Use OpenJDK as base image
FROM openjdk:21-jdk

# Set working directory
WORKDIR /app

# Copy the built jar from Jenkins workspace
COPY target/java-docker-app-1.0-SNAPSHOT.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
