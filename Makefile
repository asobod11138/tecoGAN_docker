DOCKER_FILE=Dockerfile
IMAGE_NAME_TAG=teco_gan_docker
CONTAINER_NAME=teco_gan_docker
DEVICE=/dev/video1

all:
	build

build:
	docker build -t $(IMAGE_NAME_TAG) -f $(DOCKER_FILE) .

bash:
	xhost +
	docker run --name $(CONTAINER_NAME) --device=$(DEVICE):/dev/video0 -it --net=host --rm --runtime=nvidia \
	       	--env="DISPLAY" \
					-v /home/blackman101010/tecoGAN/TecoGAN:/root/TecoGAN \
	       	$(IMAGE_NAME_TAG) bash  

exec:
	docker exec -it $(CONTAINER_NAME) bash


