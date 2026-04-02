
# Dockerized Nodejs Application  
This project demonstrates hands-on experience with Docker, Docker Compose, and containerized application deployment. It highlights my ability to build Docker images, run containers locally and on a remote server, and manage images across public and private registries.

<br/>

## Tech Stack & Tools
- Node.js
- MongoDB
- Mongo Express
- Docker Desktop
- DigitalOcean 
- Nexus, Amazon ECR, Docker Hub
- Git & GitHub/GitLab

<br/>

## Workflow 
[Node.js App] → Dockerfile → Docker Image → [Docker Hub / Nexus / ECR] → Server → Docker Compose → Running Containers

<br/>

## Steps Performed

**Built Docker images**
  - Created a `Dockerfile` for a Node.js application to create reproducible, portable images. 

**Orchestrated multiple containers**
  - Used Docker Compose to run the Node.js app alongside MongoDB and Mongo Express locally. 
  - Defined services, dependencies, and environment configurations in `docker-compose.yaml` file.

**Implemented data persistence**
  - Attached Docker volumes to MongoDB containers to preserve database data across container restarts. 

**Published Docker images**
  - Uploaded the Node.js app image to Docker Hub (public).
  - Installed Nexus as a Docker container on the server and published the built app image to a Docker hosted repository on the Nexus registry.
  - Published different versions of my app image to Amazon ECR (private registry).
  - Managed image versions and pull images directly from registries for deployment.

**Deployed to a cloud server**
  - Provisioned a DigitalOcean server (droplet).
  - Installed Docker runtime and ran Docker images on the server to simulate a production-like environment.

## What I Learned
- Practical Docker and Docker Compose workflows for containerizing applications.
- How to orchestrate multiple containers and define service dependencies.
- Techniques for persistent storage using Docker volumes.
- Server deployment skills: provisioning a droplet, installing Docker runtime, and running containers remotely.
- How to publish and manage images on public and private registries (Docker Hub, Nexus, Amazon ECR).
- Understanding version control and deployment workflows for Docker images.


## Future Improvements
- Automate deployments with CI/CD pipelines to streamline publishing Docker images.
- Containerize additional microservices or supporting tools to simulate more complex architectures.

![](<app/images/docker desktop engine.png>)

![alt text](<app/images/building docker image.png>)

![alt text](<app/images/docker hub repo published docker image.png>)

![alt text](<app/images/amazon ecr repo.png>)

![alt text](<app/images/docker nexus server droplet.png>)

![alt text](<app/images/nexus docker hosted repo name.png>)

![alt text](<app/images/docker image pushed to nexus repo.png>)

