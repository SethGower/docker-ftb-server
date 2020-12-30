FROM openjdk:8-jre

RUN apt-get update && \
	apt-get install apt-utils jq --yes && \
	apt-get upgrade --yes --allow-remove-essential && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /minecraft
COPY ./run.sh ./

ENV EULA_ACCEPT=false
ENV PACK=35
ENV VERSION=143
ENV INSTALL_FILE=serverinstall_$PACK\_$VERSION

RUN useradd -m -U minecraft
RUN chown -R minecraft:minecraft /minecraft

USER minecraft

expose 25565
VOLUME /minecraft

CMD ./run.sh
