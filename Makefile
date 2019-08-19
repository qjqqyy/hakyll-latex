build:
	docker build -t qjqqyy/hakyll-latex .

push: build
	docker push qjqqyy/hakyll-latex

.PHONY: build push
