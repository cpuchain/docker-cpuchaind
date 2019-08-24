FROM ubuntu:xenial
MAINTAINER Min Khang Aung <info@cpuchain.org>

ARG USER_ID
ARG GROUP_ID

ENV HOME /cpuchain

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} cpuchain \
	&& useradd -u ${USER_ID} -g cpuchain -s /bin/bash -m -d /cpuchain cpuchain

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
	&& apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
		tar \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
	&& wget https://github.com/cpuchain/cpuchain/releases/download/v0.16.3/cpuchain-0.16.3-x86_64-linux-gnu.tar.gz \
	&& tar xvf cpuchain-0.16.3-x86_64-linux-gnu.tar.gz \
	&& install -m 0755 -o root -g root -t /usr/bin cpuchain-0.16.3/bin/* \
	&& rm -r cpuchain-0.16.3-x86_64-linux-gnu.tar.gz cpuchain-0.16.3 \
	&& apt-get purge -y \
		ca-certificates \
		wget \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./bin /usr/local/bin

VOLUME ["/cpuchain"]

EXPOSE 19707 19706

WORKDIR /cpuchain

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["cpu_oneshot"]
