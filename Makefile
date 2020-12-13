build:
	docker build -t ${IMAGE} .

login:
	docker login -u _ -p ${AUTH_TOKEN} ${REPO}

push:
	docker push ${IMAGE}

run:
	docker run -p 8080:8080 --env PORT=8080 ${IMAGE}

bash:
	docker run -t -i ${IMAGE} sh
