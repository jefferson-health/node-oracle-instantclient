FROM node:6.9.2

# SETUP ADDITONAL DEPENDENCIES
RUN apt-get update \
  && apt-get install -y netcat \
  && apt-get install -y libaio1 \
  && apt-get install -y build-essential \
  && apt-get install -y unzip \
  && apt-get install -y curl

#Add and install ORACLE INSTANT CLIENT
ADD ./vendor/ /opt/oracle/vendor
RUN unzip /opt/oracle/vendor/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle \
  && unzip /opt/oracle/vendor/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle  \
  && unzip /opt/oracle/vendor/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip -d /opt/oracle  \
  && mv /opt/oracle/instantclient_12_1 /opt/oracle/instantclient \
  && ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so \
  && ln -s /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so \
  && rm -rf /opt/oracle/vendor

ENV LD_LIBRARY_PATH="/opt/oracle/instantclient"
ENV OCI_HOME="/opt/oracle/instantclient"
ENV OCI_LIB_DIR="/opt/oracle/instantclient"
ENV OCI_INCLUDE_DIR="/opt/oracle/instantclient/sdk/include"
RUN echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && ldconfig
