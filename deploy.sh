echo "Starting to deploy docker image...."
DOCKER_IMAGE=sfermals/121toolr:latest
sudo su
sudo docker pull $DOCKER_IMAGE
sudo docker ps -q --filter ancestor=$DOCKER_IMAGE | xargs -r docker stop
sudo docker run -d -p 3000:3000 $DOCKER_IMAGE



