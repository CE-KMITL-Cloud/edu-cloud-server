FROM ubuntu:20.04

LABEL maintainer "https://github.com/redzenova"

# Install the necessary components
RUN apt update > /dev/null && \
    apt install -y apt-utils > /dev/null && \
    apt install -y wget file gcc make openssl libssl-dev libperl-dev snmp-mibs-downloader > /dev/null 

# Get the source code and extract it
RUN wget https://github.com/net-snmp/net-snmp/archive/v5.9.3.tar.gz && tar -xzvf v5.9.3.tar.gz && \
    mkdir -p /netsnmp/5.9/linux-gcc3 && mv v5.9.3.tar.gz /netsnmp/5.9/v5.9.3.tar.gz && \
    cd /netsnmp/5.9.3 && \
    tar -xzvf v5.9.3.tar.gz && cd net-snmp-5.9.3

# Compile netsmp and link output to the local commands
RUN  cd /netsnmp/5.9.3/net-snmp-5.9.3 && \
        ./configure  --prefix="/netsnmp/5.9/linux-gcc3" \
            --with-mib-modules=agentx \
            --with-transports="UDP UDPIPv6 TCP DTLSUDP" \
            --with-security-modules="tsm" \
            --disable-embedded-perl \
            --enable-mini-agent \
            --with-default-snmp-version="3" \
            --enable-ipv6 \
            --disable-debugging \
            --with-sys-contact="ce@kmitl.cloud" \
            --with-sys-location="CE KMITL" \
            --with-persistent-directory="/var/net-snmp" \
            --with-logfile="/var/log/snmpd.log" \
            --without-perl-modules \
            --without-python-modules \
            --disable-shared \
            --enable-static \
            --with-pic \
            --with-cc="gcc" CC="gcc" CFLAGS="-m64" \
            --enable-blumenthal-aes && \
    make 2>&1 | tee make.log && \
    make install && \
    ln -s /netsnmp/5.9.3/linux-gcc3/sbin/* /usr/local/sbin/ 

# Expose the snmp port
EXPOSE 161/udp

# Run snmpd
CMD [ "/usr/local/sbin/snmpd", "-Dmib_init", "-f", "-Lo", "-c", "/snmpdconf/snmpd.conf" ]  