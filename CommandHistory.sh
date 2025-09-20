[root@ip-172-31-33-79 K8s-MERN-App-Deployment]# history
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
   14  eksctl create cluster --name=EKS-37                       --region=ap-south-1                       --zones=ap-south-1a,ap-south-1b                       --without-nodegroup
   15  eksctl utils associate-iam-oidc-provider     --region ap-south-1     --cluster EKS-1     --approve
   16  eksctl utils associate-iam-oidc-provider     --region ap-south-1     --cluster EKS-37    --approve
   17  eksctl create nodegroup --cluster=EKS-37                       --region=ap-south-1                       --name=node2                       --node-type=t3.medium                       --nodes=2                       --nodes-min=2                       --nodes-max=2                       --node-volume-size=20                       --ssh-access                       --ssh-public-key=DevOps                       --managed                       --asg-access                       --external-dns-access                       --full-ecr-access                       --appmesh-access                       --alb-ingress-access
   18  kubectl get pods
   19  kubectl -n kube-system describe configmap aws-auth
   20  clear
   21  ls
   22  cd K8s-MERN-App-Deployment/
   23  kubectl apply -f secret.yml 
   24  kubectl get secret
   25  kubectl apply -f storageclass.yml
   26  kubectl get storageclass
   27  kubectl apply -f mongo-app.yml
   28  kubectl get pods
   29  kubectl get pods
   30  kubectl get pv
   31  kubectl get pvc
   32  kubectl get pvc
   33  kubectl get pv
   34  kubectl get pods
   35  kubectl describe mongo-0
   36  kubectl describe statefulset mongo-0
   37  kubectl describe pod  mongo-0
   38  kubectl get jobs
   39  kubectl get pods
   40  kubectl logs mongo-init-vtkhw
   41  kubectl get pods
   42  kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.4"
   43  kubectl get pods
   44  kubectl get pv
   45  kubectl get pod
   46  kubectl get pod
   47  kubectl get pod
   48  kubectl get pod
   49  kubectl get pod
   50  kubectl get pvc
   51  kubectl get pv
   52  kubectl get pods
   53  kubectl get job
   54  kubectl logs mongo-init-vtkhw
   55  kubectl get pods
   56  kubectl apply -f create-db-user-job.yaml 
   57  kubectl get pods
   58  kubectl get jobs
   59  kubectl apply -f mongo-config.yml
   60  kubectl get svc
   61  kubectl descibe config-map mongo-config
   62  kubectl describe config-map mongo-config
   63  kubectl describe configmap mongo-config
   64  kubectl apply -f mongo-express-webapp.yml
   65  kubectl apply -f webapp-service.yml 
   66  kubectl get pod
   67  kubectl get svc
   68  kubectl exec -it mongo-0 -- mongosh
   69  kubectl exec -it mongo-1 -- mongosh
   70  kubectl exec -it mongo-2 -- mongosh
   71  kubectl get pod
   72  kubectl scale deployment webapp-deployment --replicas=3
   73  kubectl get pod
   74  kubectl get pod
   75  kubectl delete pod webapp-deployment-69b6bb6b79-q4g54
   76  kubectl get pod
   77  kubectl delete pod mongo-2
   78  kubectl get pod
   79  kubectl get pod
   80  kubectl get svc
   81  kubectl exec mongo-1 -- mongosh
   82  rs.isMaster()
   83  rs.isMaster();
   84  eval rs.isMaster()
   85  eval rs.isMaster
   86  kubectl exec mongo-1 -- mongosh --eval "rs.isMaster()"
   87  kubectl exec mongo-2 -- mongosh --eval "rs.isMaster()"
   88  kubectl exec mongo-0 -- mongosh --eval "rs.isMaster()"
   89  kubectl get pod
   90  kubectl delete mongo-0
   91  kubectl delete pod mongo-0
   92  kubectl get pod
   93* 
   94* 
   95  kubectl get pod
   96  kubectl get nodes
   97  kubectl describe pod mongo-0
   98  kubectl get nodes
   99  kubectl describe pod mongo-1
  100  kubectl describe pod mongo-2
  101  kubectl get pod
  102  kubectl get pod
  103  kubectl get pod
  104  kubectl get nodes
  105  kubectl get pod
  106  kubectl get pod
  107  kubectl get pod
  108  kubectl get pod
  109  kubectl describe pod webapp-deployment-69b6bb6b79-5c4cj
  110  kubectl get rs
  111  kubectl get pod
  112  kubectl describe pod mongo-0
  113  kubectl get pvc
  114  kubectl get pods
  115  kubectl delete pod mongo-0
  116  kubectl get pods
  117  kubectl describe pod mongo-0
  118  kubectl get nodes
  119  kubectl delete pvc pvc-0216fee4-f9a6-45b2-b4e0-5ad43b54df60
  120  kubectl get pvc
  121  kubectl get pods
  122  kubectl get pods
  123  history
[root@ip-172-31-33-79 K8s-MERN-App-Deployment]# eksctl delete cluster --name EKS-37