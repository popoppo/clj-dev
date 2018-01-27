FROM centos:latest

ARG USERNAME
ARG USERPASS

RUN useradd -s /bin/bash -m ${USERNAME}
RUN echo ${USERPASS} | passwd --stdin ${USERNAME}

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y bash-completion file git jq less rlwrap wget which


RUN yum install -y java-1.8.0-openjdk
WORKDIR /home/${USERNAME}
WORKDIR bin
RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN chmod +x lein
RUN echo "export PATH=${PATH}:/home/${USERNAME}/bin" >> /home/${USERNAME}/.bashrc


RUN yum install -y openssh-server
RUN systemctl enable sshd


EXPOSE 22
CMD /sbin/init
