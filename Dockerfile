FROM centos:latest

ENV USERNAME=dev-user

# User account and password
RUN useradd -s /bin/bash -m ${USERNAME}

# Basic tools
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y bash-completion file git jq less rlwrap wget which

# java
RUN yum install -y java-1.8.0-openjdk

# leiningen
WORKDIR /home/${USERNAME}
WORKDIR bin
RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN chmod +x lein
RUN echo "export PATH=${PATH}:/home/${USERNAME}/bin" >> /home/${USERNAME}/.bashrc

# sshd
RUN yum install -y openssh-server
RUN systemctl enable sshd

# Misc settings
EXPOSE 22
CMD /sbin/init
