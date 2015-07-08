# docker-pixel-kinesis
this command will route all containers outputs to a kinesis stream:
	docker run --name logger -d \
		-p 80:80 \
		-e AWS_KEY=key \
		-e AWS_SECRET=secret \
		-e KINESIS_STREAM_NAME=stream1 \
		-e KINESIS_PARTITION_KEY=pkey \
		-e KINESIS_REGISION=us-east-1 \
		tmuskal/pixel-kinesis
