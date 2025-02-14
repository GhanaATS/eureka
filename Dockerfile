# Stage 1: Build the JAR using Maven
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory for the build stage
WORKDIR /app

# Copy the pom.xml and the source code to the container
COPY pom.xml /app/
COPY src /app/src/

# Build the JAR file
RUN mvn clean package 

# Stage 2: Create the final image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the final JAR from the build stage
COPY --from=build /app/target/*.jar /app/myapp.jar

# Expose the port
EXPOSE 8761

# Run the JAR file
CMD ["java", "-jar", "/app/myapp.jar"]
