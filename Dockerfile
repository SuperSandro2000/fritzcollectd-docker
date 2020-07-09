FROM debian:buster

COPY [ "pip.conf", "/etc/" ]
RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy collectd libpython2.7 python-pip python-setuptools python-wheel \
  && pip install fritzcollectd \
  && rm -rf /var/lib/apt/lists/*

RUN touch /etc/collectd/auth_file

CMD [ "collectd", "-f" ]
