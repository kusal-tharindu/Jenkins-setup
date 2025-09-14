FROM jenkins/jenkins:2.516.2-jdk21

USER root
# Copy plugin list into the location jenkins-plugin-cli expects
COPY ../plugins/plugins.txt /usr/share/jenkins/ref/plugins.txt
# Install all required plugins (including JCasC)
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
USER jenkins