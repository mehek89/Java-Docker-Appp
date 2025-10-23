# Use the official OpenJDK 21 image
FROM openjdk:21-jdk-slim

# Set working directory inside container
WORKDIR /app

# Copy the built jar file into the container
COPY target/java-docker-app-1.0-SNAPSHOT.jar app.jar

# Expose the port your app runs on (usually 8080)
EXPOSE 8082

# Command to run your app
ENTRYPOINT ["java", "-jar", "app.jar"]
