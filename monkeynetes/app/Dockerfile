FROM gradle:jdk11 as builder

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM adoptopenjdk:11-jre-hotspot

RUN mkdir /opt/app
COPY --from=builder /home/gradle/src/build/libs/monkeynetes-0.0.1-SNAPSHOT.jar /opt/app/japp.jar

RUN curl --silent https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.12.0/jmx_prometheus_javaagent-0.12.0.jar -o /opt/app/jmx_prometheus_javaagent.jar
COPY config.yaml /opt/app/

CMD ["java", "-javaagent:/opt/app/jmx_prometheus_javaagent.jar=9090:/opt/app/config.yaml", "-jar", "/opt/app/japp.jar"]