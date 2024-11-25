[root@ip-172-31-43-93 K8s-MERN-App-Deployment]# history
   26  yum install git -y
   27  git clone https://github.com/sudhanshuvlog/K8s-MERN-App-Deployment.git
   28  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
   29  sudo mv /tmp/eksctl /usr/local/bin
   30  eksctl version
   31  curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
   32  chmod +x ./kubectl
   33  sudo mv ./kubectl /usr/local/bin
   34  kubectl version --short --client
   35  eksctl create cluster --name=EKS-1                       --region=ap-south-1                       --zones=ap-south-1a,ap-south-1b                       --without-nodegroup
   36  aws configure
   37  clear
   38  eksctl create cluster --name=EKS-1                       --region=ap-south-1                       --zones=ap-south-1a,ap-south-1b                       --without-nodegroup
   39  eksctl utils associate-iam-oidc-provider     --region ap-south-1     --cluster EKS-1     --approve
   40  eksctl create nodegroup --cluster=EKS-1                       --region=ap-south-1                       --name=node2                       --node-type=t3.medium                       --nodes=2                       --nodes-min=2                       --nodes-max=2                       --node-volume-size=20                       --ssh-access                       --ssh-public-key=DevOps                       --managed                       --asg-access                       --external-dns-access                       --full-ecr-access                       --appmesh-access                       --alb-ingress-access
   41  kubectl get pods
   42  kubectl -n kube-system describe configmap aws-auth
   43  kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.4"
   44  kubectl get pods
   45  ls
   46  cd K8s-MERN-App-Deployment/
   47  ls
   48  kubectl apply -f secret.yml 
   49  kubectl get secret
   50  kubectl describe secret
   51  kubectl get storageclass
   52  kubectl apply -f storageclass.yml 
   53  kubectl get storageclass
   54  kubectl describe storageclass ebs-storage-class
   55  kubectl get pv
   56  kubectl get pvc
   57  kubectl apply -f mongo-app.yml 
   58  kubectl get pvc
   59  kubectl get pv
   60  kubectl get pvc
   61  kubectl get pod
   62  kubectl apply -f mongo-service.yml 
   63  kubectl get svc
   64  kubectl describe svc mongo-headless-service
   65  kubectl apply -f mongo-config.yml 
   66  kubectl describe configmap
   67  kubectl apply -f mongo-express-webapp.yml 
   68  kubectl get pod
   69  kubectl apply -f webapp-service.yml 
   70  kubectl get pod
   71  kubecttl get svc
   72  kubectl get svc
   73  kubectl get pod
   74  kubectl delete pod mongo-statefulset-0
   75  kubectl get pod
   76  kubectl delete pod webapp-deployment-68d44ff9cd-xpr8c   
   77  kubectl get pod
   78  vi mongo-app.yml 
   79  vi mongo-app.yml 
   80  kubectl scale statefulset mongo-statefulset --replicas=3
   81  kubectl get pod
   82  kubectl get pod
   83  kubectl get pv
   84  kubectl get pod
   85  kubectl describe pod mongo-statefulset-2
   86  kubectl get pod
   87  kubectl get pods
   88  kubectl get nodes
   89  history
