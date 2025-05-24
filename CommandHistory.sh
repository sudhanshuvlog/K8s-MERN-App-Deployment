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
    4  mkdir gfg33
    5  cd gfg33
    6  clear
    7  git clone https://github.com/sudhanshuvlog/K8s-MERN-App-Deployment.git
    8  ls
    9  cd K8s-MERN-App-Deployment/
   10  ls
   11  kubectl apply -f secret.yml 
   12  kubectl apply -f mongo-app.yml 
   13  kubectl get pods
   14  kubectl logs jobs/mongo-init
   15  kubectl get pods
   16  kubectl describe pod mongo-0
   17  kubectl get pv
   18  kubectl get pvc
   19  cat storageclass.yml 
   20  kubectl apply -f storageclass.yml 
   21  kubectl get storageclass
   22  kubectl get pvc
   23  kubectl get pv
   24  kubectl get pods
   25  kubectl logs jobs/mongo-init
   26  kubectl get pods
   27  kubectl get jobs
   28  kubectl get pv
   29  kubectl get pvc
   30  kubectl get pods
   31  kubectl delete pod mongo-0
   32  kubectl get pods
   33  kubectl get pods
   34  kubectl get pods
   35  kubectl get pods
   36  kubectl logs jobs/mongo-init
   37  kubectl get pods
   38  kubectl exec -it mongo-0 --mongosh
   39  kubectl exec -it mongo-0 -- mongosh
   40  kubectl get pods
   41  kubectl get svc
   42  kubectl apply -f mongo-config.yml 
   43  kubectl get configmap
   44  kubectl apply -f mongo-express-webapp.yml
   45  kubectl get pods
   46  kubectl get pods
   47  kubectl logs webapp-deployment-69b6bb6b79-x7dl5
   48  kubectl run -it pod1 --image=amazonlinux -- bash
   49  kubectl get pod
   50  kubectl get statefulset
   51  kubectl describe pod mongo-0
   52  kubectl get pods
   53  kubectl describe pod webapp-deployment-69b6bb6b79-x7dl5
   54  kubectl get pods
   55  kubectl exec -it pod -- bash
   56  kubectl exec -it pod1 -- bash
   57  kubectl run -it pod1 --image=mongo:5 -- bash
   58  kubectl run -it pod2 --image=mongo:5 -- bash
   59  kubectl get pv
   60  kubectl get pods
   61  kubectl scale statefulset --replicas 4
   62  kubectl scale statefulset mongo --replicas 4
   63  kubectl get pods
   64  kubectl get pv
   65  history
