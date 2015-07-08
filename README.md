# docker-pixel-kinesis

	docker run --name pixel-logger -d \
		-p 80:80 \
		-e AWS_KEY=key \
		-e AWS_SECRET=secret \
		-e KINESIS_STREAM_NAME=stream1 \
		-e KINESIS_REGION=us-east-1 \
		tmuskal/pixel-kinesis
