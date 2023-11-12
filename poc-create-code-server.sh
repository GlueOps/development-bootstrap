
#!/usr/bin/env bash

# install docker: https://docs.docker.com/engine/install/debian/
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo groupadd -f docker
sudo usermod -aG docker $USER
newgrp docker

# run code tunnel
mkdir -p workspaces/glueops; sudo docker run -it -p 8000:8000 --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --privileged --init -v `pwd`/workspaces/glueops:/workspaces/glueops -v /var/run/docker.sock:/var/run/docker.sock -u vscode -w /workspaces/glueops ghcr.io/glueops/codespaces:v0.32.0-alpha4 bash -c "code tunnel --verbose --log trace"
