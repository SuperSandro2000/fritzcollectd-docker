FROM ubuntu:bionic

RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy libpython2.7 python-pip python-setuptools \
  && apt-get install --no-install-recommends -qy \
  autoconf \
  automake \
  autotools-dev \
  bison \
  build-essential \
  curl \
  flex \
  git \
  iptables-dev \
  libcurl4-gnutls-dev \
  libdbi0-dev \
  libesmtp-dev \
  libganglia1-dev \
  libgcrypt11-dev \
  libglib2.0-dev \
  libhiredis-dev \
  libltdl-dev \
  liblvm2-dev \
  libmemcached-dev \
  libmnl-dev \
  libmodbus-dev \
  libmysqlclient-dev \
  libopenipmi-dev \
  liboping-dev \
  libow-dev \
  libpcap-dev \
  libperl-dev \
  libpq-dev \
  libprotobuf-c-dev \
  librabbitmq-dev \
  librrd-dev \
  libsensors4-dev \
  libsnmp-dev \
  libtokyocabinet-dev \
  libtokyotyrant-dev \
  libtool \
  libupsclient-dev \
  libvirt-dev \
  libxml2-dev \
  libyajl-dev \
  linux-libc-dev \
  pkg-config \
  protobuf-c-compiler \
  python-dev \
  sudo && \
  rm -rf /usr/share/doc/* && \
  rm -rf /usr/share/info/* && \
  rm -rf /tmp/* && \
  rm -rf /var/tmp/*

  WORKDIR /usr/src
  RUN git clone https://github.com/collectd/collectd.git collectd
  WORKDIR /usr/src/collectd
  RUN ./build.sh
  RUN ./configure \
      --prefix=/usr/local \
      --sysconfdir=/etc/collectd
  RUN make all
  RUN make install
  RUN make clean

  RUN pip install fritzcollectd \
  && rm -rf /var/lib/apt/lists/*

RUN touch /etc/collectd/auth_file

CMD [ "/usr/local/sbin/collectd", "-f" ]
