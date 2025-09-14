sudo mkdir -p /etc/docker

cat <<'JSON' | sudo tee /etc/docker/daemon.json
{
  "log-driver": "local",
  "log-opts": {
    "max-size": "10m",
    "max-file": "5"
  },
  "live-restore": true,
  "default-address-pools": [
    { "base": "10.124.0.0/16", "size": 24 }
  ]
}
JSON

sudo systemctl daemon-reload
sudo systemctl enable --now docker
sudo systemctl restart docker
docker info | sed -n '1,60p'
