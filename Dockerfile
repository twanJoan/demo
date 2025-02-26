# 1️⃣ Sử dụng image chính thức của Maven với OpenJDK 8 để build ứng dụng
FROM maven:3.8.6-openjdk-8 AS builder

# 2️⃣ Đặt thư mục làm việc
WORKDIR /app



# 4️⃣ Copy toàn bộ source code vào container
COPY . .

# 5️⃣ Build ứng dụng
RUN mvn clean package -DskipTests


FROM openjdk:8-jdk-alpine

ARG SPRING_PROFILE=dev
ENV SPRING_PROFILES_ACTIVE=$SPRING_PROFILE

WORKDIR app
COPY --from=builder /app/target/demo.jar .
COPY --from=builder /app/src/main/resources config

ENTRYPOINT ["java", "-jar", "demo.jar"]
