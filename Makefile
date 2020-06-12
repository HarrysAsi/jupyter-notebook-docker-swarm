all: config_glusterd_master config_swarm deploy_swarm check_services output

build_dockerfile:
	@echo "Building Dockerfile..."
	cd ./docker-image; ./Dockerfile.build

run_dockerfile:
	@echo "Running Dockerfile..."
	@cd ./docker-image; ./Dockerfile.run

config_glusterd_master:
	@echo "Configuring glusterd for manager node..."
	@cd ./gluster; ./gluster-manager-install.sh;

config_glusterd_worker:
	@echo "Configuring glusterd for workers..."
	@cd ./gluster; ./gluster-worker-install.sh;

config_swarm:
	@echo "Creating the swarm manager instance..."
	cd ./swarm; ./swarm.init
	@echo "Please put all workers in swarm before proceeding..."
	@echo 'press [ANY KEY] to continue when you are done...'
	@read _

deploy_swarm:
	@echo "Deploying swarm..."
	@cd ./docker-compose; ./docker-compose.yaml.run

check_services:
	@echo "Services running..."
	@docker service ls

output:
	@echo "You can visit:"
	@echo "https://<YOUR-IP:9443>/ (Swarm application)"
	@echo "http://<YOUR-IP:9090>/ (Portainer)"

clean:
	@docker swarm leave
