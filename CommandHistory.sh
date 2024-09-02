[root@ip-172-31-33-227 /]# history
    1  yum install docker -y
    2  cd /
    3  systemctl start docker
    4  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
    5  rpm -Uvh minikube-latest.x86_64.rpm
    6  minikube start --force
    7  curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.3/2023-11-14/bin/linux/amd64/kubectl
    8  chmod +x ./kubectl
    9  cp ./kubectl /usr/bin/
   10  kubectl get nodes
   11  kubectl get pods
   12  kubectl get deployments
   13  kubectl get service
   14  mkdir k8s_project
   15  cd k8s_project/
   16  clear
   17  vi mongo-app.yml
   18  vi secret.yml
   19  kubectl get secret
   20  kubectl apply -f secret.yml 
   21  kubectl get secret
   22  kubectl describe secret mongo-secret
   23  vi secret.yml
   24  vi mongo-app.yml 
   25  vi mongo-app.yml 
   26  kubectl apply -f mongo-app.yml 
   27  vi mongo-app.yml 
   28  vi mongo-app.yml 
   29  kubectl apply -f mongo-app.yml 
   30  kubectl get deployment
   31  kubectl get replicaset
   32  kubectl get pods
   33  ls
   34  vi mongo-express-webapp.yml
   35  kubectl get pods
   36  kubectl describe pod mongo-deployment-654884d54-44fbl
   37  vi mongo-express-webapp.yml
   38  vi mongo-service.yml
   39  kubectl apply -f mongo-
   40  kubectl apply -f mongo-service.yml 
   41  kubectl get svc
   42  vi mongo-express-webapp.yml 
   43  vi mongo-express-webapp.yml 
   44  vi mongo-config.yml
   45  kubectl apply -f mongo-config.yml 
   46  kubectl get configmap
   47  kubectl describe configmap
   48  kubectl describe configmap mongo-config
   49  vi mongo-express-webapp.yml 
   50  kubectl apply mongo-express-webapp.yml 
   51  kubectl apply -f mongo-express-webapp.yml 
   52  vi mongo-express-webapp.yml 
   53  kubectl apply -f mongo-express-webapp.yml 
   54  kubectl get pods
   55  kubectl get deployment
   56  kubectl get replicaset
   57  kubectl get pods
   58  vi webapp-service.yml
   59  vi mongo-express-webapp.yml 
   60  vi webapp-service.yml
   61  vi webapp-service.yml
   62  kubectl apply -f webapp-service.yml 
   63  vi webapp-service.yml
   64  kubectl apply -f webapp-service.yml 
   65  kubectl get svc
   66  curl 192.168.49.2:30115
   67  docker ps
   68  yum install socat -y
   69  id nobody
   70  socat TCP4-LISTEN:8080,fork,su=nobody TCP4:192.168.49.2:30115 &
   71  kubectl get pods
   72  kubectl logs webapp-deployment-874c94688-86g5v
   73  kubectl get pods
   74  kubectl delete pod mongo-deployment-654884d54-44fbl
   75  kubectl get pods
   76  vi mongo-app.yml 
   77  docker exec -it minikube bash
   78  kubectl get pods
   79  kubectl apply -f mongo-app.yml 
   80  kubectl get pods
   81  docker exec -it minikube bash
   82  l
   83  ls
   84  kubectl get pods
   85  kubectl delete pod mongo-deployment-56c895c55-htxxw
   86  kubectl get pods
   87  vi pv.yml
   88  kubectl get nodes
   89  vi pv.yml
   90  kubectl apply -f pv.yml 
   91  kubectl get pv
   92  vi pvc.yml
   93  kubectl apply -f pvc.yml 
   94  vi pvc.yml
   95  kubectl apply -f pvc.yml 
   96  vi pvc.yml
   97  kubectl apply -f pvc.yml 
   98  vi pvc.yml
   99  kubectl apply -f pvc.yml 
  100  kubectl get pvc
  101  kubectl get pv
  102  kubectl describe pv 
  103  docker exec -it minikube bash
  104  kubectl get pv
  105  kubectl get pvc
  106  kubectl describe pvc
  107  cat pvc.yml 
  108  cat pv.yml 
  109  kubectl delete pv mongo-pv
  110  kubectl apply -f pv.yml 
  111  kubectl get pv
  112  kubectl get pv
  113  kubectl delete pvc mongo-pvc
  114  kubectl apply -f pvc.yml 
  115  kubectl get pv
  116  kubectl describe pvc
  117  vi pv.yml 
  118  kubectl apply -f pv.yml 
  119  kubectl get pv
  120  vi pv.yml 
  121  kubectl get pvc
  122  kubectl describe pvc
  123  kubectl get pvc
  124  vi mongo-app.yml 
  125  kubectl get pvc
  126  vi mongo-app.yml 
  127  kubectl apply -f mongo-app.yml 
  128  vi mongo-app.yml 
  129  kubectl apply -f mongo-app.yml 
  130  kubectl get pods
  131  docker exec -it minikube bash
  132  cat pv
  133  cat pv.yml 
  134  kubectl get pods
  135  minikube dashboard &
  136  kubectl get pods
  137  kubectl get ns
  138  kubectl get pods -n default
  139  kubectl get pods -n kubernetes-dashboard
  140  kubectl get svc -n kubernetes-dashboard
  141  kubectl edit svc kubernetes-dashboard -n kubernetes-dashboard
  142  kubectl get svc -n kubernetes-dashboard
  143  kubectl get pods
  144  kubectl edit pod webapp-deployment-874c94688-86g5v
  145  socat TCP-LISTEN:8081,fork,su=nobody TCP4:192.168.49.2:30712 &
  146  kubectl get pods
  147  cd /
  148  history