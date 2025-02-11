# We retrieve the base image from payara images
FROM payara/server-full:6.2025.1-jdk17
# We change to root user in order to install and update any dependency
USER root
RUN apt-get update && apt-get install -y wget

# We change the user to payara admin in order to configure the application server
USER payara

# 
RUN wget -P /opt/payara/appserver/glassfish/lib \
    https://jdbc.postgresql.org/download/postgresql-42.6.0.jar

# Inicia el servidor Payara, configura JDBC, detén el dominio 
RUN echo 'create-jdbc-connection-pool --datasourceclassname org.postgresql.ds.PGSimpleDataSource --restype javax.sql.DataSource --property user=postgres:password=abc123:URL=jdbc\:postgresql\://postgresql\:5432/webparking2025 pg_localhost_parking' >> /opt/payara/config/post-boot-commands.asadmin
RUN echo 'create-jdbc-resource --connectionpoolid pg_localhost_parking jdbc/pgdb' >> /opt/payara/config/post-boot-commands.asadmin
RUN echo 'ping-connection-pool pg_localhost_parking' >> /opt/payara/config/post-boot-commands.asadmin

# Copy your WAR file into the deployments folder.
COPY ParkingWebApp-1.0-SNAPSHOT.war /opt/payara/deployments/

EXPOSE 8080 4848
