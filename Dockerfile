# Use OpenJDK 21
FROM openjdk:21-jdk

# Set working directory inside container
WORKDIR /app

# Copy Maven project
COPY . /app

# Build the project
RUN ./mvnw clean package -DskipTests || mvn clean package -DskipTests

# Run the application
CMD ["java", "-cp", "target/java-docker-app-1.0-SNAPSHOT.jar", "com.example.App"]
