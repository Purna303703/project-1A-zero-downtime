# Stage 1: Build Stage
FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /app
COPY . .
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

# Stage 2: Runtime Stage
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Production Security Best Practice: Create and run as a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy compiled JAR from Stage 1 (builder)
COPY --from=builder /app/target/*.jar app.jar

# Switch to non-root user
USER appuser

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]