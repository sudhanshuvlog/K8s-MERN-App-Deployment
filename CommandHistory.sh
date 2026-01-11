[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# history
    1  cd /
    2  yum install git -y
    3  git clone https://github.com/sudhanshuvlog/K8s-MERN-App-Deployment.git
    4  aws configure
    5  clear
    6  aws s3 ls
    7  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    8  sudo mv /tmp/eksctl /usr/local/bin
    9  eksctl version
   10  curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
   11  chmod +x ./kubectl
   12  sudo mv ./kubectl /usr/local/bin
   13  kubectl version --short --client
   14  eksctl create cluster --name=EKS-40                       --region=ap-south-1                       --zones=ap-south-1a,ap-south-1b                       --without-nodegroup
   15  eksctl utils associate-iam-oidc-provider     --region ap-south-1     --cluster EKS-1     --approve
   16  eksctl utils associate-iam-oidc-provider     --region ap-south-1     --cluster EKS-40     --approve
   17  eksctl create nodegroup --cluster=EKS-40                       --region=ap-south-1                       --name=node2                       --node-type=t3.medium                       --nodes=2                       --nodes-min=2                       --nodes-max=2                       --node-volume-size=20                       --ssh-access                       --ssh-public-key=DevOps                       --managed                       --asg-access                       --external-dns-access                       --full-ecr-access                       --appmesh-access                       --alb-ingress-access
   18  kubectl get nodes
   19  kubectl -n kube-system describe configmap aws-auth
   20  kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.4"
   21  kubectl get pods
   22  kubectl apply -f secret.yml
   23  cd K8s-MERN-App-Deployment/
   24  ls
   25  kubectl apply -f secret.yml 
   26  kubectl get secret
   27  kubectl apply -f storageclass.yml 
   28  kubectl get storageclass
   29  kubectl get pv
   30  kubectl get pvc
   31  kubectl apply -f mongo-app.yml 
   32  kubectl get pod
   33  kubectl get pod
   34  kubectl get pv
   35  kubectl get pvc
   36  kubectl get pv
   37  kubectl get pods
   38  kubectl get pods
   39  kubectl logs mongo-init-kr96q
   40  kubectl get pods
   41  kubectl exec -it mongo-0 -- bash
   42  kubectl get pods
   43  kubect apply -f create-db-user-job.yaml 
   44  kubectl apply -f create-db-user-job.yaml 
   45  kubectl get pods
   46  kubectl exec -it mongo-0 -- bash
   47  kubectl get pods
   48  kubectl get statefulset
   49  kubectl apply -f mongo-config.yml 
   50  kubectl get configmap
   51  kubectl apply -f mongo-express-webapp.yml 
   52  kubectl get pods
   53  kubectl apply -f webapp-service.yml 
   54  kubectl get svc
   55  kubectl get nodes
   56  kubectl get pod
   57  kubectl describe pod mongo-0
   58  kubectl get pod
   59  kubectl get nodes
   60  kubectl describe pod mongo-1
   61  kubectl get nodes
   62  kubectl get pods
   63  kubectl delete pod mongo-0
   64  kubectl get pods
   65  kubectl get pods
   66  kubectl exec mongo-1 -- bash
   67  kubectl exec mongo-1 -- bash
   68  kubectl exec mongo-0 -- bash
   69  kubectl exec -it mongo-1 -- bash
   70  kubectl get pods
   71  vi mongo-app.yml
   72  kubectl top pods
   73  kubectl apply -f mongo-app.yml 
   74  kubectl get pods
   75  kubectl get pods
   76  kubectl get pods
   77  kubectl describe pod mongo-2
   78  kubectl get statefulset
   79  kubectl get pods
   80  kubectl delete statefulset mongo
   81  kubectl get pod
   82  kubectl get pod
   83  kubectl delete job mongo-init mongo-create-user
   84  kubectl get pv
   85  kubectl get pods
   86  kubectl apply -f mongo-app.yml 
   87  kubectl get pod
   88  kubectl get pods
   89  kubectl describe pod mongo-0
   90  ls
   91  vi mongo-express-webapp.yml 
   92  kubectl apply -f mongo-express-webapp.yml 
   93  kubectl get pods
   94  kubectl get pods
   95  kubectl get pods
   96  kubectl describe pod webapp-deployment-5ff9967b65-zdtvz
   97  eksctl delete cluster --name EKS-40 --region ap-south-1
   98  history