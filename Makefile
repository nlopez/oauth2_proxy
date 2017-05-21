.PHONY: build clean
IMG_NAME=thalweg/oauth2_proxy

build:
	docker build -t $(IMG_NAME) .

clean:
	docker rmi $(IMG_NAME)
