FROM openjdk:8-jre-alpine3.9

WORKDIR /app-exe
COPY target/ enterypoint.sh application.properties ./

ENTRYPOINT ["./enterypoint.sh"]