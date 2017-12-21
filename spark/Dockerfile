FROM esitull/stack-hadoop-docker:hadoop

ENV SPARK_VERSION 2.1.2
ENV SPARK_BIN_URL https://www.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-without-hadoop.tgz
ENV SPARK_HOME=/opt/spark-$SPARK_VERSION


RUN set -x \
    && curl -fSL "$SPARK_BIN_URL" -o /tmp/spark.tar.gz \
    && tar -xvf /tmp/spark.tar.gz -C /opt \
    && mv /opt/spark-$SPARK_VERSION-* $SPARK_HOME \
    && rm -f /tmp/spark.tar.gz

WORKDIR $SPARK_HOME
ENV PATH $SPARK_HOME/bin:$PATH

ADD spark-entrypoint.sh /
ADD spark-historyserver.sh /
ADD spark-master.sh /
ADD spark-slave.sh /

RUN chmod a+x \
    /spark-entrypoint.sh \
    /spark-historyserver.sh \
    /spark-master.sh \
    /spark-slave.sh


RUN mkdir -p /datos    
RUN echo "export SPARK_DIST_CLASSPATH=$(hadoop classpath)" >> /opt/spark-$SPARK_VERSION/conf/spark-env.sh

### Some packages for an easy life.
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get clean && apt-get update -y
RUN apt-get install -y --fix-missing \
    wget \
    vim \
    git \
    sssd \
    ldap-utils \
    libpam-ldap \
    libnss-ldap  \
    libpam-script 

# RUN apt-get clean && apt-get update
RUN apt-get install -y --fix-missing \
  gcc \
  binutils \
  g++ \
  git-core \
  htop \
  memstat \
  sysstat \
  tmux \
  iputils-ping \
  net-tools \
  tmux \
  curl \
  unzip \
  openssh-server


# ssh
COPY conf/sshd_config /etc/ssh/sshd_config

# ldap
COPY conf/configura-ubuntu-pam-ldap-stic/files/etc/ldap.conf  /etc/ldap.conf
COPY conf/configura-ubuntu-pam-ldap-stic/files/etc/ldap/ldap.conf  /etc/ldap/ldap.conf
COPY conf/configura-ubuntu-pam-ldap-stic/files/etc/sssd/sssd.conf /etc/sssd/sssd.conf
COPY conf/configura-ubuntu-pam-ldap-stic/files/etc/configura-pam.conf /etc/configura-pam.conf
RUN  chmod 0600 /etc/sssd/sssd.conf

# auth & pam-script
COPY conf/configura-ubuntu-pam-ldap-stic/files/etc/pam.d/* /etc/pam.d/
COPY conf/configura-ubuntu-pam-ldap-stic/files/usr/share/libpam-script/* /usr/share/libpam-script/
COPY conf/configura-ubuntu-pam-ldap-stic/files/etc/nsswitch.conf /etc/nsswitch.conf

#USER $USER
#RUN mkdir -p /home/$USER
#WORKDIR /home/$USER
RUN  mkdir -p /var/run/sshd

# start.sh
COPY start.sh /bin/start.sh
RUN chmod a+rx /bin/start.sh


####
#RUN apt-get install -y --no-install-recommends samba 
RUN apt-get install -y cifs-utils
RUN apt-get install -y nscd

EXPOSE 22

RUN echo "root:wopis2017" | chpasswd

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8

COPY variables.sh /etc/profile.d/variables.sh

ENTRYPOINT ["/spark-entrypoint.sh"]
