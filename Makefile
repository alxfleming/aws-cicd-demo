clean:
	rm -rf bin
	rm -rf zip

build:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o bin/say-hello internal/say-hello/say-hello.go

zip:
	mkdir zip
	zip -j zip/say-hello.zip bin/say-hello