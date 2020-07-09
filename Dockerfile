FROM debian:buster

COPY [ "pip.conf", "/etc/" ]
RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy \
    collectd \
    gcc \
    libpython2.7 \
    libxslt-dev \
    libxslt1.1 \
    python2-dev \
    python-pip \
    python-setuptools \
    python-wheel \
    zlib1g \
    zlib1g-dev \
  && pip install fritzcollectd \
  && apt-get autoremove --purge -y \
    gcc \
    libxslt-dev \
    python2-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN touch /etc/collectd/auth_file

CMD [ "collectd", "-f" ]
