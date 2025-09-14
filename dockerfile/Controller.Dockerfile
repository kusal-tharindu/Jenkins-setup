#FROM jenkins/jenkins@sha256:be8c0f70f4cbab154cafa2f62b696147c12bfc2bf883eaa241c061bf5096df3b

FROM jenkins/jenkins:2.516.2-jdk21
USER root
# Copy plugin list into the location jenkins-plugin-cli expects
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
# Install all required plugins (including JCasC)
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
USER jenkins