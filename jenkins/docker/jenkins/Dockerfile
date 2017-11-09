FROM jenkins/jenkins:alpine

# Install dependencies
USER root
RUN apk add --update \
		sudo \
		docker \
		py-pip \
	&& pip install docker-compose \
	&& rm -rf /var/cache/apk/*
	
# Give the jenkins user sudo permissions
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN sudo adduser jenkins docker 

# Install plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

COPY start-jenkins.sh ./start-jenkins.sh

ENTRYPOINT ["./start-jenkins.sh"]
