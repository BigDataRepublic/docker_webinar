# Build trainer container
docker build -t iris_trainer -f Dockerfile_training .

# Run it: Train and output model pickle file (use absolute filepaths)
docker run -v ~/Projects/docker_webinar/docker_webinar/docker_example/model:/app/model iris_trainer

# Build predictor container
docker build -t iris_predictor -f Dockerfile_prediction .

# Run it: host prediction api
docker run -p 5000:0 -v ~/Projects/docker_webinar/docker_webinar/docker_example/model:/app/model iris_predictor

# Show it's working by sending curl request:
curl -X POST http://localhost:5000 \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '[[5,3]]'


# Build and then run the front-end as well, and run with docker-compose:

docker-compose -d up
docker-compose down