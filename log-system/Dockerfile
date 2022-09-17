FROM ubuntu:20.04

LABEL maintainer "https://github.com/redzenova"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get install -y \
    wget \
    ca-certificates \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

#RUN DEBIAN_FRONTEND=noninteractive TZ=Asia/Bangkok  apt-get -y install tzdata

RUN wget -qO - https://ose-repo.syslog-ng.com/apt/syslog-ng-ose-pub.asc | gpg --dearmor > /usr/share/keyrings/ose-repo-archive-keyring.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/ose-repo-archive-keyring.gpg] https://ose-repo.syslog-ng.com/apt/ stable ubuntu-focal" | tee --append /etc/apt/sources.list.d/syslog-ng-ose.list

RUN apt-get update -qq && apt-get install -y \
    libdbd-mysql libdbd-pgsql libdbd-sqlite3 syslog-ng \
    && rm -rf /var/lib/apt/lists/*

ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
COPY entrypoint.sh /etc/syslog-ng/

EXPOSE 514/udp 514/tcp

HEALTHCHECK --interval=2m --timeout=3s --start-period=30s CMD /usr/sbin/syslog-ng-ctl stats || exit 1

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD "/entrypoint.sh"
