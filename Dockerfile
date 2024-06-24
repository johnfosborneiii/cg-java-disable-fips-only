FROM cgr.dev/chainguard-private/jdk-fips:openjdk-17 as builder
USER root
WORKDIR /src
COPY SimpleFIPSTest.java .
RUN javac SimpleFIPSTest.java && jar cvf simple-fips.jar *.class

FROM cgr.dev/chainguard-private/jre-fips:openjdk-17-dev as runner
WORKDIR /jars
COPY --from=builder /src/simple-fips.jar .
ENV CLASSPATH="${JAVA_FIPS_CLASSPATH}:/jars/*"
USER 0
RUN sed -i '$s/org.bouncycastle.fips.approved_only=true$/org.bouncycastle.fips.approved_only=false/' "/usr/lib/jvm/default-jvm/conf/security/"
USER java
ENTRYPOINT ["java", "SimpleFIPSTest"]
