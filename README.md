# tower_web_dummy_service
A dummy service to configure the environment


docker stop `docker ps -qa`
docker rm `docker ps -qa`
docker rmi -f `docker images -qa `
docker volume rm $(docker volume ls -qf)
docker network rm `docker network ls -q`



