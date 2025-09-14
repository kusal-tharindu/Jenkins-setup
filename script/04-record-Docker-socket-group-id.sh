# get docker group ID

getent group docker
stat -c '%g' /var/run/docker.sock

#-------------------------------------   
# 4.1 Pull and pin the controller image (record the digest)

cd /srv/jenkins/compose

# Pull the image once
docker pull jenkins/jenkins:lts-jdk17

# Capture its pinned digest for your docs
docker inspect --format='{{index .RepoDigests 0}}' jenkins/jenkins:lts-jdk17


#------------------------------------- 
# create pluging
cat > ./plugins/plugins.txt <<'PLUGINS'
# Core pipeline + git
workflow-aggregator
git
git-client

# Docker pipelines
docker-workflow

# Config as Code + basics
configuration-as-code
job-dsl
credentials
credentials-binding
matrix-auth
role-strategy
ssh-credentials
mailer

# UI/UX + health
timestamper
ansicolor
PLUGINS

# ------------------------------------
# 4.3 Create a minimal JCasC

cat > ./casc/jenkins.yaml <<'YAML'
jenkins:
  systemMessage: "Jenkins — managed by Configuration as Code"
  numExecutors: 0
  mode: NORMAL
  remotingSecurity:
    enabled: true
  crumbIssuer:
    standard:
      excludeClientIPFromCrumb: true

  securityRealm:
    local:
      allowsSignup: false
      users:
        - id: "${ADMIN_USER}"
          password: "${ADMIN_PASSWORD}"

  authorizationStrategy:
    loggedInUsersCanDoAnything:
      allowAnonymousRead: false

unclassified:
  location:
    url: "${JENKINS_URL}"
YAML

# -------------------------------------------------

# normally if the  .env file has same location that on the docker compose file it load it automatically
docker compose down
docker compose build jenkins-controller
docker compose up -d jenkins-controller
docker compose logs -f jenkins-controller


docker compose --env-file /path/to/your/.env up -d jenkins-controller

