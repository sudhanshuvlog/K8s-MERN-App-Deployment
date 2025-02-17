[root@ip-172-31-35-214 K8s-MERN-App-Deployment]# history
    1  cd /
    2  clear
    3  yum install git -y
    4  git clone https://github.com/sudhanshuvlog/K8s-MERN-App-Deployment.git
    5  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    6  sudo mv /tmp/eksctl /usr/local/bin
    7  eksctl version
    8  curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
    9  chmod +x ./kubectl
   10  sudo mv ./kubectl /usr/local/bin
   11  kubectl version --short --client
   12  aws configure
   13  clear
   14  eksctl create cluster --name=EKS-1                       --region=ap-south-1                       --zones=ap-south-1a,ap-south-1b                       --without-nodegroup
   15  eksctl utils associate-iam-oidc-provider     --region ap-south-1     --cluster EKS-1     --approve
   16  eksctl create nodegroup --cluster=EKS-1                       --region=ap-south-1                       --name=node2                       --node-type=t3.medium                       --nodes=2                       --nodes-min=2                       --nodes-max=2                       --node-volume-size=20                       --ssh-access                       --ssh-public-key=DevOps                       --managed                       --asg-access                       --external-dns-access                       --full-ecr-access                       --appmesh-access                       --alb-ingress-access
   17  kubectl get pod
   18  kubectl get nodes
   19  kubectl -n kube-system describe configmap aws-auth
   20  kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.4"
   21  ls
   22  cd K8s-MERN-App-Deployment/
   23  ls
   24  kubectl apply -f secret.yml 
   25  kubectl get secret
   26  kubectl apply -f storageclass.yml 
   27  kubectl get storageclass
   28  kubectl apply -f mongo-app.yml 
   29  kubectl get statefulset
   30  kubectl get pod
   31  kubectl get pod
   32  kubectl get pvc
   33  kubectl get pv
   34  kubectl get pod
   35  kubectl describe pod mongo-statefulset-0
   36  kubectl get nodes
   37  kubectl get pods
   38  kubectl get pods
   39  kubectl delete pod mongo-statefulset-0
   40  kubectl get pods
   41  kubectl get pods
   42  kubectl scale statefulset mongo-statefulset --replicas=2
   43  kubectl get pods
   44  kubectl get pvc
   45  kubectl get pv
   46  kubectl get pods
   47  kubectl apply -f mongo-service.yml 
   48  kubectl get svc
   49  kubectl apply -f mongo-config.yml 
   50  kubectl get configmap
   51  kubectl apply -f mongo-express-webapp.yml 
   52  kubectl get pod
   53  kubectl apply -f webapp-service.yml 
   54  kubectl scale statefulset mongo-statefulset --replicas=1
   55  kubectl get pod
   56  kubectl scale deployment webapp-deployment  --replicas=5
   57  kubectl get pod
   58  kubectl get pod
   59  kubectl get pod
   60  kubectl scale deployment webapp-deployment  --replicas=3
   61  kubectl get pod
   62  kubectl get svc
   63  kubectl scale statefulset mongo-statefulset --replicas=2
   64  kubectl get svc
   65  kubectl get pods
   66  kubectl get pv
   67  kubectl get pods
   68  history
