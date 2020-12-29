FROM openjdk:8-jre

RUN apt-get update && \
	apt-get install apt-utils --yes && \
	apt-get upgrade --yes --allow-remove-essential && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /minecraft

ENV EULA_ACCEPT=y
ENV PACK=35
ENV VERSION=143
ENV INSTALL_FILE=serverinstall_$PACK\_$VERSION

RUN useradd -m -U minecraft
RUN wget --no-check-certificate https://api.modpacks.ch/public/modpack/$PACK/$VERSION/server/linux -O $INSTALL_FILE
RUN chmod u+x $INSTALL_FILE
RUN yes | ./$INSTALL_FILE
RUN chmod u+x start.sh
RUN chown -R minecraft:minecraft /minecraft
RUN echo "eula=true" > eula.txt

USER minecraft

expose 25565
VOLUME /minecraft

CMD yes $EULA_ACCEPT | /minecraft/start.sh
# CMD ls /minecraft
