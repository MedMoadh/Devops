FROM openjdk:8
ADD target/tpAchatProject-1.0.jar  tpAchatProject-1.0.jar
EXPOSE 8088
ENTRYPOINT ["java","-jar","tpAchatProject-1.0.jar"]