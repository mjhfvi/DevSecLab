##########  Interview Project ##########
the point of this project is to automate the deployment of a python application
infrastructure:
jenkins, terraform, kubernetes, argocd, treafik, postgresql

##### jenkins Configuration #####
start jenkins server with helm/helmfile and configuration as a code

## Optional - Persistent Volume for jenkins_home
add storage and claim to kubernetes cluster
$ kubectl -f ./charts/jenkins-persistent-volume-nfs.yaml apply
$ kubectl -f ./charts/jenkins-persistent-volume-claim.yaml apply
add the PVC name to existingClaim in helmfile-jenkins.yaml

## Optional - Change Server Configuration With jcasc (Jenkins Configuration as Code)
search for "configScripts" in ./charts/helmfile-jenkins.yaml (line 741)
and add/change configuration to manage jenkins
add remove plugins in "installPlugins" (line 396)

## Jenkins Server Access
# Option 1 - Ingress for Jenkins Server
add nginx ingress to access jenkins server with url
add alias to hosts file, "127.0.0.1  jenkins.localhost"
$ helmfile -f ./charts/helmfile-ingress-nginx.yaml apply
$ kubectl -f ./charts/jenkins-ingress.yaml apply
jenkins server: http://jenkins.localhost/

# Option 2 - Service on Port 8080 to Access Jenkins Server
kubectl -n jenkins patch svc jenkins -p '{"spec": {"type": "LoadBalancer"}}'
jenkins server: http://localhost:8080/

## Jenkins Server Password
# Option 1 - Set Static Password the ./charts/helmfile-jenkins.yaml
$ helmfile -f ./charts/helmfile-jenkins.yaml apply

# Option 2 - Use Random Password
$ kubectl -n jenkins get secret jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode

# Option 3 - Use ConfigMap
set admin password in ./charts/jenkins/jenkins-configmap.yaml (make sure to use base64 to hash the password)
add the configmap name to "existingSecret" in ./charts/helmfile-jenkins.yaml (make sure to comment out the static password value)
$ kubectl -f ./charts/jenkins/jenkins-configmap.yaml apply

### Start Jenkins Server ###
helmfile -f ./charts/helmfile-jenkins.yaml apply

# jenkins login
user: admin
password: value from Option 1/2/3

### Jenkins Configuration ###
build new ssh certificate
$ ssh-keygen -t ed25519 -C "ed25519 SSH Login Key" -f ssh_login_key_ed25519
add ssh certificate public key to github
add ssh certificate privet key to jenkins under -> manage -> credentials -> "GitHub-SSH-Access-Credentials-to-JobAssignment-Git"

# Add Pipelines to Jenkins Server (Use SCM Pipeline)
add new pipeline, in "Definition" change to SCM, in "Repository URL" fill in the github SSH url example: "git@github.com:mjhfvi/JobAssignment.git"
change the branch name (master/main) if needed

in the "Script Path" set for every pipeline
./jenkins/Pipeline_Git_Code_Validation.groovy
./jenkins/Pipeline_Build_Continuous_Deployment.groovy
./jenkins/Pipeline_Build_Docker.groovy
./jenkins/Pipeline_Build_Terraform.groovy

## Setup Node
Node Name: WSL-Ubuntu-Node with label "linux"
# Download the jar file to run the agent
curl -sO http://jenkins.localhost/jnlpJars/agent.jar

# Option 1 - Only Run the Command
java -jar agent.jar -url http://jenkins.localhost/ -secret HASH -name "WSL-Ubuntu-Node" -workDir "/home/tzahi/jenkins/"

# Option 2 - Configure a systemctl service
https://www.jenkins.io/doc/book/system-administration/systemd-services/

##### AWS Configuration #####
# build AMI secret and key:
login to AMI https://console.aws.amazon.com/iam/
Build A User, in security credentials create access key

# Terraform Configuration in Jenkins
add "Access key" and "Secret access key" to jenkins manage -> credentials -> "Aws-Access-Key" & "Aws-Secret-Key"

## Jenkins Pipelines
build a new python application run "Pipeline_Build_Docker"
build a new EKS infrastructure run "Pipeline_Build_Terraform"
deploy the application to kubernetes with argocd run "Pipeline_Build_Continuous_Deployment"




## build jobProject with arcgcd
# argocd config file for jobProject
argocd-jobProject.yaml

# jobProject value file
values-jobProject.yaml

# run command
argocd app create -f argocd-jobProject.yaml
argocd app create job-project -f argocd-jobProject.yaml


## Remove
argocd app delete jobProject

## postgresql
mydb
dbuser
kubectl -n job-project get secret job-project-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d
