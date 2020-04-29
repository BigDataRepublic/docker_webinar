# Build and run first container to calculate pi via monte carlo approximation
docker build -t approx_pi -f Dockerfile_first .
docker run approx_pi

# Build trainer container
docker build -t iris_trainer -f Dockerfile_training .

# Run it: Train and output model pickle file (use absolute filepaths)
docker run -d -v docker_webinar_volume:/app/model iris_trainer

# Build predictor container
docker build -t iris_predictor -f Dockerfile_prediction .

# Run it: host prediction api
docker run -d -p 5000:5000 -v docker_webinar_volume:/app/model iris_predictor

# Show it's working by sending curl request:
curl -X POST http://localhost:5000 \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '[[5,3]]'


# Build frontend container
docker build -t iris_frontend -f Dockerfile_frontend .

# Run frontend container
docker run -d -p 4200:4200 iris_frontend

# Build proxy container
docker build -t iris_proxy -f Dockerfile_reverse_proxy .

# Run proxy container
docker run -d -p 443:443 iris_proxy

docker-compose up -d
docker-compose down