FROM ubuntu:16.04
MAINTAINER Malcolm Smith

# Install Supporting Packages
RUN apt-get -q update && \
  apt-get install -qy curl python && \
  curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
  apt-get -q update && \
  apt-get install -qy \
    build-essential \
    git \
    nodejs \
    libavahi-compat-libdnssd-dev && \
  apt-get -q clean && \
  rm -rf /var/lib/apt/lists/*


RUN npm -g install npm@3  --prefix=/usr/local

RUN    npm -g install --unsafe-perm homebridge 
RUN    npm -g install homebridge-tplink-smarthome  
RUN    npm -g install homebridge-ifttt

COPY run.sh /run.sh

RUN chmod +x /run.sh && mkdir -p /var/run/dbus

VOLUME /config

CMD ["/run.sh"]
