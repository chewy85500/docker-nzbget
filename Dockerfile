FROM resin/rpi-raspbian:jessie
MAINTAINER Laurent Perrin

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
apt-get install -y -q wget

RUN wget -O - http://nzbget.net/info/nzbget-version-linux.json | \
sed -n "s/^.*stable-download.*: \"\(.*\)\".*/\1/p" | \
wget --no-check-certificate -i - -O nzbget-latest-bin-linux.run

RUN sh nzbget-latest-bin-linux.run --destdir /opt/nzbget

RUN wget http://sourceforge.net/projects/bananapi/files/unrar_5.2.6-1_armhf.deb

RUN dpkg -i unrar_5.2.6-1_armhf.deb

EXPOSE 6789

WORKDIR /opt/nzbget

CMD ./nzbget --server  --option OutputMode=log