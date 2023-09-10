#!/bin/bash

# Set environment variables
VERSION_KUBECTL="1.27.4"
VERSION_TERRAFORM="1.5.5"
VERSION_HELM="3.12.2"
VERSION_GCLOUD_SDK="441.0.0"
VERSION_TASKFILE="3.28.0"
VERSION_KIND="0.20.0"
VERSION_K9S="0.27.4"
VERSION_TERRAFORM_DOCS="0.16.0"
VERSION_KUBENT="0.7.0"
VERSION_HELM_DIFF="3.8.1"
VERSION_CHARM_GUM="0.11.0"
VERSION_ARGO_CD_CLI="2.7.10"
NONROOT_USER="ubuntu"

# Set Environment variables
echo 'export GLUEOPS_CODESPACES_VERSION=v0.28.0' >> ~/.bashrc
echo 'export VAULT_SKIP_VERIFY=true' >> ~/.bashrc
echo 'export CLOUDSDK_INSTALL_DIR=/usr/local/gcloud/' >> ~/.bashrc
echo 'export VERSION_GCLOUD_SDK=441.0.0' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/gcloud/google-cloud-sdk/bin' >> ~/.bashrc
source ~/.bashrc
echo "Environment variables added to ~/.bashrc."

# Install dependencies
sudo apt-get update -y
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install --no-install-recommends wget gpg unzip tar curl jq certbot

# Install VS Code
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https
sudo apt update
sudo apt install code -y


# Install Code Tunnel
curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
tar -xf vscode_cli.tar.gz

# Install other tools
sudo curl -Lo /usr/local/bin/kubectl https://dl.k8s.io/release/v${VERSION_KUBECTL}/bin/linux/amd64/kubectl && sudo chmod +x /usr/local/bin/kubectl
sudo curl -Lo terraform_${VERSION_TERRAFORM}_linux_amd64.zip https://releases.hashicorp.com/terraform/${VERSION_TERRAFORM}/terraform_${VERSION_TERRAFORM}_linux_amd64.zip && sudo unzip terraform_${VERSION_TERRAFORM}_linux_amd64.zip && sudo mv terraform /usr/local/bin && sudo rm terraform_${VERSION_TERRAFORM}_linux_amd64.zip
sudo curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 >> get_helm.sh && sudo chmod +x get_helm.sh && sudo ./get_helm.sh --version ${VERSION_HELM}

curl -sSL https://sdk.cloud.google.com | sudo bash -s -- --disable-prompts
export PATH=$PATH:/usr/local/gcloud/google-cloud-sdk/bin
sudo gcloud components install gke-gcloud-auth-plugin --quiet
sudo gcloud components install alpha --quiet
sudo gcloud components install beta --quiet
sudo rm -rf $(sudo find /usr/local/gcloud/google-cloud-sdk/ -regex ".*/__pycache__")
sudo rm -rf /usr/local/gcloud/google-cloud-sdk/.install/.backup
sudo rm -rf /usr/local/gcloud/google-cloud-sdk/lib/third_party/apis
sudo rm -rf /usr/local/gcloud/google-cloud-sdk/bin/anthoscli
sudo apt-get update -y
sudo apt-get install tmux dnsutils telnet iputils-ping jq certbot -y

# Install Task
sudo sh -c "$(sudo curl --location https://raw.githubusercontent.com/go-task/task/v${VERSION_TASKFILE}/install-task.sh)" -- -d -b /usr/local/bin/

# Install docker 
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Install Kind
sudo curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v${VERSION_KIND}/kind-linux-amd64 && sudo chmod +x /usr/local/bin/kind

# Install K9s
sudo wget https://github.com/derailed/k9s/releases/download/v${VERSION_K9S}/k9s_Linux_amd64.tar.gz && sudo tar -xvf k9s_Linux_amd64.tar.gz k9s && sudo mv k9s /usr/local/bin && sudo rm k9s_Linux_amd64.tar.gz

# Install Terraform Docs
sudo curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v${VERSION_TERRAFORM_DOCS}/terraform-docs-v${VERSION_TERRAFORM_DOCS}-$(uname)-amd64.tar.gz && sudo tar -xzf terraform-docs.tar.gz && sudo chmod +x terraform-docs && sudo mv terraform-docs /usr/local/bin && sudo rm terraform-docs.tar.gz

# Install Kube No Trouble
sudo curl -Lo ./kubent-${VERSION_KUBENT}-linux-amd64.tar.gz https://github.com/doitintl/kube-no-trouble/releases/download/${VERSION_KUBENT}/kubent-${VERSION_KUBENT}-linux-amd64.tar.gz && sudo tar -xzf kubent-${VERSION_KUBENT}-linux-amd64.tar.gz && sudo chmod +x kubent && sudo mv kubent /usr/local/bin && sudo rm kubent-${VERSION_KUBENT}-linux-amd64.tar.gz

# Install Gum
sudo curl -Lo ./gum_${VERSION_CHARM_GUM}_Linux_x86_64.tar.gz https://github.com/charmbracelet/gum/releases/download/v${VERSION_CHARM_GUM}/gum_${VERSION_CHARM_GUM}_Linux_x86_64.tar.gz && sudo tar --extract --file=gum_${VERSION_CHARM_GUM}_Linux_x86_64.tar.gz gum && sudo chmod +x gum && sudo mv gum /usr/local/bin && sudo rm gum_${VERSION_CHARM_GUM}_Linux_x86_64.tar.gz

# Install Argo CD CLI
sudo curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/v${VERSION_ARGO_CD_CLI}/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
sudo rm argocd-linux-amd64

# Install Github CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

# Set up non-root user and Docker socket access
SOCKET_GID=$(sudo stat -c '%g' /var/run/docker.sock)
if [ "${SOCKET_GID}" != '0' ]; then
    if [ "$(cat /etc/group | grep :${SOCKET_GID}:)" = '' ]; then
        sudo groupadd --gid ${SOCKET_GID} docker
    fi
    if [ "$(id ${NONROOT_USER} | grep -E "groups=.*(=|,)\${SOCKET_GID}\()")" = '' ]; then
        sudo usermod -aG ${SOCKET_GID} ${NONROOT_USER}
    fi
fi