curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
#apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"
apt-get update && sudo apt-get install terraform
