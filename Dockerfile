# Multi Stage Dockerfile 
# VM > Docker image (java)
# * .jar 
# * mvn pcakage > target/.jar
# * dcoker > vm > mvn 
# =========================================================
# Stage 1 - Build 
# I will build my artifact in this stage with the help of maven
# i should have maven

# Base image consisting of mvn and java 
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# =========================================================
# Stage 1 - Runtime 
# i will run the java process on the artifact created above.
FROM eclipse-temurin:17-alpine
WORKDIR /app
COPY --from=builder /app/target/*jar app.jar
EXPOSE 8082
# ENV JAVA_OPTS="-Xms256m -Xmx512m"
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]

# extrqa comment