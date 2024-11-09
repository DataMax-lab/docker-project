
		
# Docker Install AWS EC2 UBUNTU instance:

# Dokcker download and installation commands
sudo apt update

sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y docker-ce

sudo chmod 666 /var/run/docker.sock

# Enable Docker service
sudo systemctl enable docker

sudo systemctl start docker

sudo systemctl status docker

# Check docker install properly or not 
docker run hello-world


# Docker Command:

# Build docker image 
docker build -t pyspark-docker-app .

# Run docker image
docker run --rm pyspark-docker-app

# Push image to docker host
docker login

docker tag pyspark-docker-app madmax301189/pyspark-docker-app:latest

docker push madmax301189/pyspark-docker-app:latest

# Pull image from docker host 

docker pull madmax301189/pyspark-docker-app:latest


# Git Command:
git add *

git commit -m "chnage information 2"

git push -u origin main'
