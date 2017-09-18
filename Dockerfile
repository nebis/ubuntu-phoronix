FROM ubuntu:latest
ARG BUILD_DATE
ARG VCS_REF
ENV PHORONIX_SERVER 77.68.66.15
ENV PHORONIX_CODE 2XYHUL
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Phoronix Client" \
      org.label-schema.description="Ubuntu Linux Phoronix Docker Image" \
      org.label-schema.url="https://dockerhub.com/nebulai/ubuntu-phoronix" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/nebis/ubuntu-phoronix" \
      org.label-schema.schema-version="1.0"
#pk add php5 php5-dom php5-zip php5-json

RUN apt update -y && \ 
    apt install -y git build-essential php-cli php-xml php-zip && \
    mkdir -p /opt && \
    chown 1000 /opt && \ 
    cd /opt && \
#    wget http://www.phoronix-test-suite.com/download.php?file=phoronix-test-suite-7.2.1 -O phoronix.tar.gz && \
#    tar -zxvpf phoronix.tar.gz && \
    git clone https://github.com/phoronix-test-suite/phoronix-test-suite.git

#    rm phoronix.tar.gz

VOLUME /opt
ADD entrypoint.sh /
ENTRYPOINT ["/tini", "--"]
#CMD ["/opt/phoronix-test-suite/phoronix-test-suite phoromatic.connect $PHORONIX_SERVER:80/$PHORONIX_CODE"]
CMD ["/entrypoint.sh"]
