sudo mkdir -p /srv/jenkins/{compose,casc,backups,reverse-proxy,agents,secrets}
sudo mkdir -p /srv/jenkins/metrics
sudo chown -R "$USER":"$USER" /srv/jenkins
ls -R /srv/jenkins | sed -n '1,200p'

#-----------------------------------------------

cd /srv/jenkins/compose
mkdir -p ./jenkins_home ./logs ./certs ./plugins ./casc ./backups ./secrets ./agents

sudo chown -R 1000:1000 ./jenkins_home
sudo chown -R 1000:1000 ./plugins ./casc 



