compile:
	make build-go-pb
	make build-python-pb
	make compile-go
	make compile-python

build-go-pb:
	docker build -t pygo-go-pb:latest -f ./Dockerfile_go --no-cache .

build-python-pb:
	docker build -t pygo-python-pb:latest -f ./Dockerfile_py --no-cache .

compile-go:
	docker run --rm -v $(PWD):/pygo -it pygo-go-pb:latest \
	protoc --go_out=. --go_opt=paths=source_relative \
	--go-grpc_out=. --go-grpc_opt=paths=source_relative \
	hello_server/proto/hello.proto

compile-python:
	docker run --rm -v $(PWD):/pygo -it pygo-python-pb:latest \
	python -m grpc_tools.protoc -I hello_client/proto --python_out=hello_client/proto/ \
	--grpc_python_out=hello_client/proto/ hello_client/proto/hello.proto
