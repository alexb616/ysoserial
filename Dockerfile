## Fixed 
FROM maven:3.9.6-eclipse-temurin-8 AS builder

WORKDIR /app

COPY pom.xml .
COPY assembly.xml .
RUN mvn dependency:resolve

COPY src ./src
RUN mvn clean package -DskipTests

RUN mv target/ysoserial-*all*.jar target/ysoserial.jar

FROM eclipse-temurin:8-jdk

WORKDIR /app

COPY --from=builder /app/target/ysoserial.jar .

ENTRYPOINT ["java", "-jar", "ysoserial.jar"]
