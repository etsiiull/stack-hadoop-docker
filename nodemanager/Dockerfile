FROM esitull/stack-hadoop-docker:hadoop

ADD run.sh /run.sh
RUN chmod a+x /run.sh
RUN apt-get install -y python

CMD ["/run.sh"]
