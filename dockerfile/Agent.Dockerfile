# Base: Jenkins inbound agent with JDK 17
FROM jenkins/inbound-agent:latest-jdk17

USER root

# ---- Install Docker CLI (no daemon) ----
# Debian-based image: install Docker's official CLI package
RUN apt-get update -y \
 && apt-get install -y ca-certificates curl gnupg lsb-release \
 && install -m 0755 -d /etc/apt/keyrings \
 && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
 && chmod a+r /etc/apt/keyrings/docker.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release; echo $VERSION_CODENAME) stable" \
    > /etc/apt/sources.list.d/docker.list \
 && apt-get update -y \
 && apt-get install -y docker-ce-cli \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# ---- Wire agent user to docker group (DooD) ----
ARG DOCKER_GID=999
# Create group if not present, then add jenkins user
RUN if ! getent group ${DOCKER_GID} >/dev/null; then \
       groupadd -g ${DOCKER_GID} docker; \
    fi \
 && usermod -aG ${DOCKER_GID} jenkins

# Convenience: let Docker CLI find the socket by default
ENV DOCKER_HOST=unix:///var/run/docker.sock

USER jenkins
WORKDIR /home/jenkins/agent