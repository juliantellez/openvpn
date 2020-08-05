# ----- Docker -----

DOCKER_NAMESPACE=juliantellez
DOCKER_CONTAINER_NAME=openvpn
DOCKER_REPOSITORY=$(DOCKER_NAMESPACE)/$(DOCKER_CONTAINER_NAME)
DOCKER_PLATFORMS=linux/amd64,linux/arm64
SHA8=$(shell echo $(GITHUB_SHA) | cut -c1-8)

docker-image-local:
	docker build --rm -t $(DOCKER_REPOSITORY):local .

ci-docker-auth:
	@echo "${DOCKER_PASSWORD}" | docker login --username "${DOCKER_USERNAME}" --password-stdin

ci-docker-buildx:
	@docker buildx build \
		--platform $(DOCKER_PLATFORMS) \
		--tag $(DOCKER_REPOSITORY):$(SHA8) \
		--tag $(DOCKER_REPOSITORY):latest \
		--output "type=image,push=false" .

ci-docker-buildx-push: ci-docker-buildx
	@docker buildx build \
		--platform $(DOCKER_PLATFORMS) \
		--tag $(DOCKER_REPOSITORY):$(SHA8) \
		--tag $(DOCKER_REPOSITORY):latest \
		--output "type=image,push=true" .
