docker build -t react-hello .
docker images

docker run -d --name react-container -p 8084:80 react-hello
docker ps

curl http://localhost:8084
