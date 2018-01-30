FROM centos:latest

MAINTAINER popoppo

ENV USERNAME=dev-user

# User account and password
RUN useradd -s /bin/bash -m ${USERNAME}

# Basic tools
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y bash-completion file git iproute jq less nc rlwrap wget which

# java
RUN yum install -y java-1.8.0-openjdk

# leiningen
WORKDIR /home/${USERNAME}/bin
RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN chmod +x lein
WORKDIR /home/${USERNAME}
RUN mkdir workdir

# Misc settings
CMD /sbin/init
