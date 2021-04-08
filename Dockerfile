FROM adoptopenjdk/openjdk11:alpine-jre as runner

WORKDIR /app

ENV FC_LANG en-US LC_CTYPE en_US.UTF-8

# dependencies
#RUN apk -U upgrade &&  \
#    apk add --update --no-cache bash ttf-dejavu fontconfig curl java-cacerts && \
#    mkdir -p /app/certs && \
#    curl https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem -o /app/certs/rds-combined-ca-bundle.pem  && \
#    /opt/java/openjdk/bin/keytool -noprompt -import -trustcacerts -alias aws-rds -file /app/certs/rds-combined-ca-bundle.pem -keystore /etc/ssl/certs/java/cacerts -keypass changeit -storepass changeit && \
#    curl https://cacerts.digicert.com/DigiCertGlobalRootG2.crt.pem -o /app/certs/DigiCertGlobalRootG2.crt.pem  && \
#    /opt/java/openjdk/bin/keytool -noprompt -import -trustcacerts -alias azure-cert -file /app/certs/DigiCertGlobalRootG2.crt.pem -keystore /etc/ssl/certs/java/cacerts -keypass changeit -storepass changeit && \

#Create plugins directory
RUN mkdir -p /app/plugins && chmod a+rwx /app/plugins

# add fixed cacerts
#COPY --from=builder /etc/ssl/certs/java/cacerts /opt/java/openjdk/lib/security/cacerts

# add Metabase script and uberjar
RUN mkdir -p /app/target/uberjar/plugins
COPY csv.metabase-driver.jar /app/plugins
COPY metabase.jar /app/
#COPY --from=builder /app/source/bin/start /app/bin/

# expose our default runtime port
EXPOSE 3000

# run it
#ENTRYPOINT ["/app/bin/start"]
ENTRYPOINT ["exec java -jar /app/metabase.jar"]