## Hellow

### Docker (hellow-docker)

1. I built a simple webapp called 'hellow' that runs in the 8000 port, using Python and Flask!

2. For that I splited the code and the structure in 4 files:
  - main.py 
  - requirements.txt
  - Dockerfile
  - docker-compose.yml

3. Tested and made it available in first place using *docker-compose*:

  `../hellow-docker$ docker-compose up`

4. Built the iamge:

  `$ docker build -t ralphmigotto/hellow .`

5. Pushed the image into my DockerHub profile:

  `$ docker push ralphmigotto/hellow` 

6. Pulled the image from my profile to test it:

  `$ docker pull ralphmigotto/hellow`
  
7. Ran the image in Docker:

  `$ docker run -d -it -p 8000:8000 --name hellow ralphmigotto/hellow:latest`

8. Checked with *curl*

  `curl http://localhost:8000`

### K8S Manifests (hellow-k8s)

1. I built the K8S manifests to run the docker image previously created
   All configuration was performed using minikube that's why I ran with `kubectl port-forward` instead of using *LoadBalancer* or *NodePort*.

2. For that I splited the code and the structure in 3 files:
  - hellow-deployment.yml
  - hellow-service.yml
  - hellow-configmap.yml
  
  Basically the *hellow-configmap.yml* injects 3 environment variables and I get them with my *hellow-deployment.yml*. The *hellow-service.yml* is used just to provide network connection.

3. Commands to create the pods
 
  `../hellow-k8s$ kubectl apply -f hellow-k8s/hellow-deployment.yml`

  `../hellow-k8s$ kubectl create -f hellow-k8s/hellow-service.yml`

  `../hellow-k8s$ kubectl create -f hellow-k8s/hellow-configmap.yml`

4. Command to expose the port:

 `../hellow-k8s$ kubectl port-forward service/hellow-service 8081:80`

5. Tested with *curl*

  `$ curl http://localhost:8081`

6. It is possible checking the environment variables inside the container as well:

  `$ kubectl exec hellow-deployment-xxxxxxx -it -- env | grep VAR_`
  
### AWS Terraform (hellow-aws-tf)

1. I built a simple infrastruture with the services: *VPC*, *EC2* and *RDS*. For the VPC I used a module concept and there are 2 subnets, one for public access (EC2) and other one for private access (communication between the EC2 and the RDS). The entire structure was built using eligible values and parameters such as **Free Tier**

2. For that I splited the code and the main structure in 5 files and a directory with more 3 files.
  - ec2.tf  
  - main.tf  
  - outputs.tf
  - rds.tf
  - variables.tf
  - modules
    - vpc
      - main.tf
      - outputs.tf
      - variables.tf 

2. For testing the code it will be necessary create a *key-pair* and change its value in file *ec2.tf* and it is nedded to run previously `aws configure` and provide the programmatic access and secret keys in your $HOME path.

3. To run and load the *VPC* module:

  `../hellow-aws-tf$ terrafom init`
 
4. To check the configuration before send it:

  `../hellow-aws-tf$ terraform plan`
  
5. To apply and see the things working:

  `../hellow-aws-tf$ terraform apply`
  
6. After completing the process it will be possible to check the basic info:

  ```
  db-address = "srechallengedb.xxxxxxxxxxxx.us-east-2.rds.amazonaws.com"
  db-arn = "arn:aws:rds:us-east-2:xxxxxxxxxxxx:db:srechallengedb"
  db-endpoint = "srechallengedb.xxxxxxxxxxxx.us-east-2.rds.amazonaws.com:3306"
  db-hosted_zone_id = "xxxxxxxxxxxx"
  db-id = "srechallengedb"
  db-name = "srechallendedb"
  db-port = 3306
  ec2-public-dns = "ec2-x-xx-xxx-xxx.us-east-2.compute.amazonaws.com"
  ec2-public-ip = "x.xx.xxx.xxx"
  ec2-public-private-dns = "ip-xxx-xxx-x-x.us-east-2.compute.internal"
  ec2-public-private-ip = "xxx.xxx.x.x"
  ```
  
7. To perfom a *ssh* in the EC2 created, we need to use the public dns:

  `$ ssh -i $PATH/key-pair.pem ec2-user@ec2-x-xx-xxx-xxx.us-east-2.compute.amazonaws.com`

8. Is is possible install a mysql-client to test the conection from EC2 and the RDS, and then run:

  `$ mysql -u root -h srechallengedb.xxxxxxxxxxxx.us-east-2.rds.amazonaws.com -p`
  
9. After completing the tests we can destroy our entire structure:

  `../hellow-aws-tf$ terraform destroy`

## Thanks 
