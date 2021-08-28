#FROM java:8-alpine
FROM openjdk:11

ADD target/*.jar /app.jar

EXPOSE 9001

ENTRYPOINT ["java","-jar","/app.jar"]
