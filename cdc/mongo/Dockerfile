FROM mongo:3.6.4

ADD got /got
COPY init.sh /init.sh

RUN chmod +x /init.sh

CMD /init.sh 