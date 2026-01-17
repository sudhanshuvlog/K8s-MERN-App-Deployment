[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# [root@ip-172-31-35-71 hack]# history
    1  cd /
    2  yum install git -y
    3  git clone https://github.com/sudhanshuvlog/K8s-MERN-App-Deployment.git
    4  cd K8s-MERN-App-Deployment/
    5  aws configure
    6  clear
    7  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    8  sudo mv /tmp/eksctl /usr/local/bin
    9  eksctl version
   10  curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
   11  chmod +x ./kubectl
   12  sudo mv ./kubectl /usr/local/bin
   13  kubectl version --short --client
   14  eksctl create cluster --name=EKS-GFG40-17                       --region=ap-south-1                       --zones=ap-south-1a,ap-south-1b                       --without-nodegroup
   15  eksctl utils associate-iam-oidc-provider     --region ap-south-1     --cluster EKS-1     --approve
   16  eksctl utils associate-iam-oidc-provider     --region ap-south-1     --cluster EKS-GFG40-17     --approve
   17  eksctl create nodegroup --cluster=EKS-GFG40-17                       --region=ap-south-1                       --name=node2                       --node-type=t3.medium                       --nodes=2                       --nodes-min=2                       --nodes-max=2                       --node-volume-size=20                       --ssh-access                       --ssh-public-key=DevOps                       --managed                       --asg-access                       --external-dns-access                       --full-ecr-access                       --appmesh-access                       --alb-ingress-access
   18  kubectl get pods
   19  kubectl get nodes
   20  kubectl -n kube-system describe configmap aws-auth
   21  kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.4"
   22  kubectl apply -f secret.yml 
   23  kubectl apply -f storageclass.yml 
   24  vi mongo-app.yml 
   25  kubectl apply -f mongo-app.yml 
   26  kubectl get pods
   27  kubectl get pods
   28  kubectl describe pod mongo-0
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME               READY   STATUS      RESTARTS      AGE
mongo-0            0/1     OOMKilled   3 (43s ago)   2m
mongo-init-g9wzb   1/1     Running     0             2m
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# vi mongo-app.yml 
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl apply -f mongo-app.yml 
statefulset.apps/mongo configured
service/mongo unchanged
job.batch/mongo-init unchanged
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl delete mongo-0
error: the server doesn't have a resource type "mongo-0"
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl delete pod mongo-0
pod "mongo-0" deleted
k[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME               READY   STATUS              RESTARTS   AGE
mongo-0            0/1     ContainerCreating   0          3s
mongo-init-g9wzb   1/1     Running             0          3m35s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl describe pod mongo-0
Name:         mongo-0
Namespace:    default
Priority:     0
Node:         ip-192-168-12-156.ap-south-1.compute.internal/192.168.12.156
Start Time:   Sat, 17 Jan 2026 06:11:42 +0000
Labels:       app=mongo
              apps.kubernetes.io/pod-index=0
              controller-revision-hash=mongo-64785d989f
              statefulset.kubernetes.io/pod-name=mongo-0
Annotations:  <none>
Status:       Running
IP:           192.168.23.112
IPs:
  IP:           192.168.23.112
Controlled By:  StatefulSet/mongo
Containers:
  mongo:
    Container ID:  containerd://5df45ad13698e367575b156a1d7fa3cee5bc7c389074664b11a7f457817b5389
    Image:         mongo:5.0
    Image ID:      docker.io/library/mongo@sha256:5e3e87afd24d75e722884d777c5713d254f7e88ba65381b5d6484f75a21b73e3
    Port:          27017/TCP
    Host Port:     0/TCP
    Command:
      mongod
      --replSet
      rs0
      --bind_ip_all
    State:          Running
      Started:      Sat, 17 Jan 2026 06:11:50 +0000
    Ready:          False
    Restart Count:  0
    Limits:
      cpu:     400m
      memory:  500Mi
    Requests:
      cpu:      200m
      memory:   300Mi
    Readiness:  exec [mongosh --eval db.adminCommand('ping')] delay=10s timeout=1s period=10s #success=1 #failure=3
    Environment:
      MONGO_INITDB_ROOT_USERNAME:  <set to the key 'mongo-user' in secret 'mongo-secret'>      Optional: false
      MONGO_INITDB_ROOT_PASSWORD:  <set to the key 'mongo-password' in secret 'mongo-secret'>  Optional: false
    Mounts:
      /data/db from mongo-persistent-storage (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-g2vxw (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  mongo-persistent-storage:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  mongo-persistent-storage-mongo-0
    ReadOnly:   false
  kube-api-access-g2vxw:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  12s   default-scheduler  Successfully assigned default/mongo-0 to ip-192-168-12-156.ap-south-1.compute.internal
  Normal  Pulled     4s    kubelet            Container image "mongo:5.0" already present on machine
  Normal  Created    4s    kubelet            Created container: mongo
  Normal  Started    4s    kubelet            Started container mongo
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME               READY   STATUS    RESTARTS   AGE
mongo-0            0/1     Running   0          27s
mongo-init-g9wzb   1/1     Running   0          3m59s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME               READY   STATUS    RESTARTS   AGE
mongo-0            0/1     Running   0          109s
mongo-init-g9wzb   1/1     Running   0          5m21s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl describe pod mongo-0
Name:         mongo-0
Namespace:    default
Priority:     0
Node:         ip-192-168-12-156.ap-south-1.compute.internal/192.168.12.156
Start Time:   Sat, 17 Jan 2026 06:11:42 +0000
Labels:       app=mongo
              apps.kubernetes.io/pod-index=0
              controller-revision-hash=mongo-64785d989f
              statefulset.kubernetes.io/pod-name=mongo-0
Annotations:  <none>
Status:       Running
IP:           192.168.23.112
IPs:
  IP:           192.168.23.112
Controlled By:  StatefulSet/mongo
Containers:
  mongo:
    Container ID:  containerd://5df45ad13698e367575b156a1d7fa3cee5bc7c389074664b11a7f457817b5389
    Image:         mongo:5.0
    Image ID:      docker.io/library/mongo@sha256:5e3e87afd24d75e722884d777c5713d254f7e88ba65381b5d6484f75a21b73e3
    Port:          27017/TCP
    Host Port:     0/TCP
    Command:
      mongod
      --replSet
      rs0
      --bind_ip_all
    State:          Running
      Started:      Sat, 17 Jan 2026 06:11:50 +0000
    Ready:          False
    Restart Count:  0
    Limits:
      cpu:     400m
      memory:  500Mi
    Requests:
      cpu:      200m
      memory:   300Mi
    Readiness:  exec [mongosh --eval db.adminCommand('ping')] delay=10s timeout=1s period=10s #success=1 #failure=3
    Environment:
      MONGO_INITDB_ROOT_USERNAME:  <set to the key 'mongo-user' in secret 'mongo-secret'>      Optional: false
      MONGO_INITDB_ROOT_PASSWORD:  <set to the key 'mongo-password' in secret 'mongo-secret'>  Optional: false
    Mounts:
      /data/db from mongo-persistent-storage (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-g2vxw (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  mongo-persistent-storage:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  mongo-persistent-storage-mongo-0
    ReadOnly:   false
  kube-api-access-g2vxw:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  118s               default-scheduler  Successfully assigned default/mongo-0 to ip-192-168-12-156.ap-south-1.compute.internal
  Normal   Pulled     111s               kubelet            Container image "mongo:5.0" already present on machine
  Normal   Created    111s               kubelet            Created container: mongo
  Normal   Started    111s               kubelet            Started container mongo
  Warning  Unhealthy  8s (x10 over 98s)  kubelet            Readiness probe failed: command timed out: "mongosh --eval db.adminCommand('ping')" timed out after 1s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME               READY   STATUS    RESTARTS   AGE
mongo-0            0/1     Running   0          2m44s
mongo-init-g9wzb   1/1     Running   0          6m16s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl describe pod mongo-0
Name:         mongo-0
Namespace:    default
Priority:     0
Node:         ip-192-168-12-156.ap-south-1.compute.internal/192.168.12.156
Start Time:   Sat, 17 Jan 2026 06:11:42 +0000
Labels:       app=mongo
              apps.kubernetes.io/pod-index=0
              controller-revision-hash=mongo-64785d989f
              statefulset.kubernetes.io/pod-name=mongo-0
Annotations:  <none>
Status:       Running
IP:           192.168.23.112
IPs:
  IP:           192.168.23.112
Controlled By:  StatefulSet/mongo
Containers:
  mongo:
    Container ID:  containerd://5df45ad13698e367575b156a1d7fa3cee5bc7c389074664b11a7f457817b5389
    Image:         mongo:5.0
    Image ID:      docker.io/library/mongo@sha256:5e3e87afd24d75e722884d777c5713d254f7e88ba65381b5d6484f75a21b73e3
    Port:          27017/TCP
    Host Port:     0/TCP
    Command:
      mongod
      --replSet
      rs0
      --bind_ip_all
    State:          Running
      Started:      Sat, 17 Jan 2026 06:11:50 +0000
    Ready:          False
    Restart Count:  0
    Limits:
      cpu:     400m
      memory:  500Mi
    Requests:
      cpu:      200m
      memory:   300Mi
    Readiness:  exec [mongosh --eval db.adminCommand('ping')] delay=10s timeout=1s period=10s #success=1 #failure=3
    Environment:
      MONGO_INITDB_ROOT_USERNAME:  <set to the key 'mongo-user' in secret 'mongo-secret'>      Optional: false
      MONGO_INITDB_ROOT_PASSWORD:  <set to the key 'mongo-password' in secret 'mongo-secret'>  Optional: false
    Mounts:
      /data/db from mongo-persistent-storage (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-g2vxw (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  mongo-persistent-storage:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  mongo-persistent-storage-mongo-0
    ReadOnly:   false
  kube-api-access-g2vxw:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age                  From               Message
  ----     ------     ----                 ----               -------
  Normal   Scheduled  2m47s                default-scheduler  Successfully assigned default/mongo-0 to ip-192-168-12-156.ap-south-1.compute.internal
  Normal   Pulled     2m39s                kubelet            Container image "mongo:5.0" already present on machine
  Normal   Created    2m39s                kubelet            Created container: mongo
  Normal   Started    2m39s                kubelet            Started container mongo
  Warning  Unhealthy  6s (x15 over 2m26s)  kubelet            Readiness probe failed: command timed out: "mongosh --eval db.adminCommand('ping')" timed out after 1s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# vi mongo-app.yml 
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get statefulset
NAME    READY   AGE
mongo   0/3     7m21s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl delete statefulset mongo
statefulset.apps "mongo" deleted
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get jobs
NAME         STATUS    COMPLETIONS   DURATION   AGE
mongo-init   Running   0/1           7m32s      7m32s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl delete job mongo-init
job.batch "mongo-init" deleted
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl apply -f mongo-app.yml 
statefulset.apps/mongo created
service/mongo unchanged
job.batch/mongo-init created
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME               READY   STATUS              RESTARTS   AGE
mongo-0            0/1     ContainerCreating   0          6s
mongo-init-g9wzb   1/1     Terminating         0          7m53s
mongo-init-jjt8t   1/1     Running             0          6s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME               READY   STATUS        RESTARTS   AGE
mongo-0            0/1     Running       0          14s
mongo-init-g9wzb   1/1     Terminating   0          8m1s
mongo-init-jjt8t   1/1     Running       0          14s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME               READY   STATUS        RESTARTS   AGE
mongo-0            0/1     Running       0          17s
mongo-init-g9wzb   1/1     Terminating   0          8m4s
mongo-init-jjt8t   1/1     Running       0          17s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl logs mongo-0
{"t":{"$date":"2026-01-17T06:16:06.171+00:00"},"s":"I",  "c":"NETWORK",  "id":4915701, "ctx":"main","msg":"Initialized wire specification","attr":{"spec":{"incomingExternalClient":{"minWireVersion":0,"maxWireVersion":13},"incomingInternalClient":{"minWireVersion":0,"maxWireVersion":13},"outgoing":{"minWireVersion":0,"maxWireVersion":13},"isInternalClient":true}}}
{"t":{"$date":"2026-01-17T06:16:06.172+00:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "ctx":"main","msg":"Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'"}
{"t":{"$date":"2026-01-17T06:16:06.174+00:00"},"s":"W",  "c":"ASIO",     "id":22601,   "ctx":"main","msg":"No TransportLayer configured during NetworkInterface startup"}
{"t":{"$date":"2026-01-17T06:16:06.174+00:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP FastOpen is required, set tcpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2026-01-17T06:16:06.175+00:00"},"s":"W",  "c":"ASIO",     "id":22601,   "ctx":"main","msg":"No TransportLayer configured during NetworkInterface startup"}
{"t":{"$date":"2026-01-17T06:16:06.175+00:00"},"s":"W",  "c":"ASIO",     "id":22601,   "ctx":"main","msg":"No TransportLayer configured during NetworkInterface startup"}
{"t":{"$date":"2026-01-17T06:16:06.175+00:00"},"s":"I",  "c":"REPL",     "id":5123008, "ctx":"main","msg":"Successfully registered PrimaryOnlyService","attr":{"service":"TenantMigrationDonorService","ns":"config.tenantMigrationDonors"}}
{"t":{"$date":"2026-01-17T06:16:06.175+00:00"},"s":"I",  "c":"REPL",     "id":5123008, "ctx":"main","msg":"Successfully registered PrimaryOnlyService","attr":{"service":"TenantMigrationRecipientService","ns":"config.tenantMigrationRecipients"}}
{"t":{"$date":"2026-01-17T06:16:06.175+00:00"},"s":"I",  "c":"CONTROL",  "id":5945603, "ctx":"main","msg":"Multi threading initialized"}
{"t":{"$date":"2026-01-17T06:16:06.175+00:00"},"s":"I",  "c":"CONTROL",  "id":4615611, "ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":1,"port":27017,"dbPath":"/data/db","architecture":"64-bit","host":"mongo-0"}}
{"t":{"$date":"2026-01-17T06:16:06.176+00:00"},"s":"W",  "c":"CONTROL",  "id":20720,   "ctx":"initandlisten","msg":"Memory available to mongo process is less than total system memory","attr":{"availableMemSizeMB":500,"systemMemSizeMB":3839}}
{"t":{"$date":"2026-01-17T06:16:06.176+00:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"version":"5.0.32","gitVersion":"ba92303e18e7ed4701572aa15acd161c97796f2f","openSSLVersion":"OpenSSL 1.1.1f  31 Mar 2020","modules":[],"allocator":"tcmalloc","environment":{"distmod":"ubuntu2004","distarch":"x86_64","target_arch":"x86_64"}}}}
{"t":{"$date":"2026-01-17T06:16:06.176+00:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "ctx":"initandlisten","msg":"Operating System","attr":{"os":{"name":"Ubuntu","version":"20.04"}}}
{"t":{"$date":"2026-01-17T06:16:06.176+00:00"},"s":"I",  "c":"CONTROL",  "id":21951,   "ctx":"initandlisten","msg":"Options set by command line","attr":{"options":{"net":{"bindIp":"*"},"replication":{"replSet":"rs0"}}}}
{"t":{"$date":"2026-01-17T06:16:06.178+00:00"},"s":"I",  "c":"STORAGE",  "id":22270,   "ctx":"initandlisten","msg":"Storage engine to use detected by data files","attr":{"dbpath":"/data/db","storageEngine":"wiredTiger"}}
{"t":{"$date":"2026-01-17T06:16:06.178+00:00"},"s":"I",  "c":"STORAGE",  "id":22297,   "ctx":"initandlisten","msg":"Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem","tags":["startupWarnings"]}
{"t":{"$date":"2026-01-17T06:16:06.179+00:00"},"s":"I",  "c":"STORAGE",  "id":22315,   "ctx":"initandlisten","msg":"Opening WiredTiger","attr":{"config":"create,cache_size=256M,session_max=33000,eviction=(threads_min=4,threads_max=4),config_base=false,statistics=(fast),log=(enabled=true,archive=true,path=journal,compressor=snappy),builtin_extension_config=(zstd=(compression_level=6)),file_manager=(close_idle_time=600,close_scan_interval=10,close_handle_minimum=2000),statistics_log=(wait=0),verbose=[recovery_progress,checkpoint_progress,compact_progress],"}}
{"t":{"$date":"2026-01-17T06:16:07.091+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:91020][1:0x7f2ea74bec80], txn-recover: [WT_VERB_RECOVERY_PROGRESS] Recovering log 6 through 7"}}
{"t":{"$date":"2026-01-17T06:16:07.200+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:199997][1:0x7f2ea74bec80], txn-recover: [WT_VERB_RECOVERY_PROGRESS] Recovering log 7 through 7"}}
{"t":{"$date":"2026-01-17T06:16:07.318+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:318281][1:0x7f2ea74bec80], txn-recover: [WT_VERB_RECOVERY_ALL] Main recovery loop: starting at 6/37760 to 7/256"}}
{"t":{"$date":"2026-01-17T06:16:07.484+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:484855][1:0x7f2ea74bec80], txn-recover: [WT_VERB_RECOVERY_PROGRESS] Recovering log 6 through 7"}}
{"t":{"$date":"2026-01-17T06:16:07.579+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:579837][1:0x7f2ea74bec80], txn-recover: [WT_VERB_RECOVERY_PROGRESS] Recovering log 7 through 7"}}
{"t":{"$date":"2026-01-17T06:16:07.623+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:623229][1:0x7f2ea74bec80], txn-recover: [WT_VERB_RECOVERY_PROGRESS] recovery log replay has successfully finished and ran for 533 milliseconds"}}
{"t":{"$date":"2026-01-17T06:16:07.623+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:623312][1:0x7f2ea74bec80], txn-recover: [WT_VERB_RECOVERY_ALL] Set global recovery timestamp: (0, 0)"}}
{"t":{"$date":"2026-01-17T06:16:07.623+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:623324][1:0x7f2ea74bec80], txn-recover: [WT_VERB_RECOVERY_ALL] Set global oldest timestamp: (0, 0)"}}
{"t":{"$date":"2026-01-17T06:16:07.623+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:623738][1:0x7f2ea74bec80], txn-recover: [WT_VERB_RECOVERY_PROGRESS] recovery rollback to stable has successfully finished and ran for 0 milliseconds"}}
{"t":{"$date":"2026-01-17T06:16:07.688+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:688645][1:0x7f2ea74bec80], WT_SESSION.checkpoint: [WT_VERB_CHECKPOINT_PROGRESS] saving checkpoint snapshot min: 1, snapshot max: 1 snapshot count: 0, oldest timestamp: (0, 0) , meta checkpoint timestamp: (0, 0) base write gen: 31"}}
{"t":{"$date":"2026-01-17T06:16:07.698+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:698356][1:0x7f2ea74bec80], txn-recover: [WT_VERB_RECOVERY_PROGRESS] recovery checkpoint has successfully finished and ran for 10 milliseconds"}}
{"t":{"$date":"2026-01-17T06:16:07.698+00:00"},"s":"I",  "c":"STORAGE",  "id":22430,   "ctx":"initandlisten","msg":"WiredTiger message","attr":{"message":"[1768630567:698422][1:0x7f2ea74bec80], txn-recover: [WT_VERB_RECOVERY_PROGRESS] recovery was completed successfully and took 608ms, including 533ms for the log replay, 0ms for the rollback to stable, and 10ms for the checkpoint."}}
{"t":{"$date":"2026-01-17T06:16:07.700+00:00"},"s":"I",  "c":"STORAGE",  "id":4795906, "ctx":"initandlisten","msg":"WiredTiger opened","attr":{"durationMillis":1521}}
{"t":{"$date":"2026-01-17T06:16:07.700+00:00"},"s":"I",  "c":"RECOVERY", "id":23987,   "ctx":"initandlisten","msg":"WiredTiger recoveryTimestamp","attr":{"recoveryTimestamp":{"$timestamp":{"t":0,"i":0}}}}
{"t":{"$date":"2026-01-17T06:16:07.706+00:00"},"s":"I",  "c":"STORAGE",  "id":22262,   "ctx":"initandlisten","msg":"Timestamp monitor starting"}
{"t":{"$date":"2026-01-17T06:16:07.714+00:00"},"s":"W",  "c":"CONTROL",  "id":22120,   "ctx":"initandlisten","msg":"Access control is not enabled for the database. Read and write access to data and configuration is unrestricted","tags":["startupWarnings"]}
{"t":{"$date":"2026-01-17T06:16:07.714+00:00"},"s":"W",  "c":"CONTROL",  "id":22138,   "ctx":"initandlisten","msg":"You are running this process as the root user, which is not recommended","tags":["startupWarnings"]}
{"t":{"$date":"2026-01-17T06:16:07.714+00:00"},"s":"I",  "c":"STORAGE",  "id":5071100, "ctx":"initandlisten","msg":"Clearing temp directory"}
{"t":{"$date":"2026-01-17T06:16:07.720+00:00"},"s":"I",  "c":"CONTROL",  "id":20536,   "ctx":"initandlisten","msg":"Flow Control is enabled on this deployment"}
{"t":{"$date":"2026-01-17T06:16:07.721+00:00"},"s":"I",  "c":"SHARDING", "id":20997,   "ctx":"initandlisten","msg":"Refreshed RWC defaults","attr":{"newDefaults":{}}}
{"t":{"$date":"2026-01-17T06:16:07.721+00:00"},"s":"I",  "c":"FTDC",     "id":20625,   "ctx":"initandlisten","msg":"Initializing full-time diagnostic data capture","attr":{"dataDirectory":"/data/db/diagnostic.data"}}
{"t":{"$date":"2026-01-17T06:16:07.726+00:00"},"s":"I",  "c":"REPL",     "id":6015317, "ctx":"initandlisten","msg":"Setting new configuration state","attr":{"newState":"ConfigStartingUp","oldState":"ConfigPreStart"}}
{"t":{"$date":"2026-01-17T06:16:07.726+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":200}}
{"t":{"$date":"2026-01-17T06:16:07.727+00:00"},"s":"I",  "c":"REPL",     "id":4280500, "ctx":"initandlisten","msg":"Attempting to create internal replication collections"}
{"t":{"$date":"2026-01-17T06:16:07.730+00:00"},"s":"I",  "c":"REPL",     "id":4280501, "ctx":"initandlisten","msg":"Attempting to load local voted for document"}
{"t":{"$date":"2026-01-17T06:16:07.730+00:00"},"s":"I",  "c":"REPL",     "id":21311,   "ctx":"initandlisten","msg":"Did not find local initialized voted for document at startup"}
{"t":{"$date":"2026-01-17T06:16:07.730+00:00"},"s":"I",  "c":"REPL",     "id":4280502, "ctx":"initandlisten","msg":"Searching for local Rollback ID document"}
{"t":{"$date":"2026-01-17T06:16:07.734+00:00"},"s":"I",  "c":"REPL",     "id":21529,   "ctx":"initandlisten","msg":"Initializing rollback ID","attr":{"rbid":1}}
{"t":{"$date":"2026-01-17T06:16:07.734+00:00"},"s":"I",  "c":"REPL",     "id":21313,   "ctx":"initandlisten","msg":"Did not find local replica set configuration document at startup","attr":{"error":{"code":47,"codeName":"NoMatchingDocument","errmsg":"Did not find replica set configuration document in local.system.replset"}}}
{"t":{"$date":"2026-01-17T06:16:07.734+00:00"},"s":"I",  "c":"REPL",     "id":6015317, "ctx":"initandlisten","msg":"Setting new configuration state","attr":{"newState":"ConfigUninitialized","oldState":"ConfigStartingUp"}}
{"t":{"$date":"2026-01-17T06:16:07.735+00:00"},"s":"I",  "c":"CONTROL",  "id":20714,   "ctx":"LogicalSessionCacheRefresh","msg":"Failed to refresh session cache, will try again at the next refresh interval","attr":{"error":"NotYetInitialized: Replication has not yet been configured"}}
{"t":{"$date":"2026-01-17T06:16:07.735+00:00"},"s":"I",  "c":"REPL",     "id":40440,   "ctx":"initandlisten","msg":"Starting the TopologyVersionObserver"}
{"t":{"$date":"2026-01-17T06:16:07.736+00:00"},"s":"I",  "c":"REPL",     "id":40445,   "ctx":"TopologyVersionObserver","msg":"Started TopologyVersionObserver"}
{"t":{"$date":"2026-01-17T06:16:07.736+00:00"},"s":"I",  "c":"CONTROL",  "id":20712,   "ctx":"LogicalSessionCacheReap","msg":"Sessions collection is not set up; waiting until next sessions reap interval","attr":{"error":"NamespaceNotFound: config.system.sessions does not exist"}}
{"t":{"$date":"2026-01-17T06:16:07.736+00:00"},"s":"I",  "c":"NETWORK",  "id":23015,   "ctx":"listener","msg":"Listening on","attr":{"address":"/tmp/mongodb-27017.sock"}}
{"t":{"$date":"2026-01-17T06:16:07.736+00:00"},"s":"I",  "c":"NETWORK",  "id":23015,   "ctx":"listener","msg":"Listening on","attr":{"address":"0.0.0.0"}}
{"t":{"$date":"2026-01-17T06:16:07.736+00:00"},"s":"I",  "c":"NETWORK",  "id":23016,   "ctx":"listener","msg":"Waiting for connections","attr":{"port":27017,"ssl":"off"}}
{"t":{"$date":"2026-01-17T06:16:07.927+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":400}}
{"t":{"$date":"2026-01-17T06:16:08.328+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":600}}
{"t":{"$date":"2026-01-17T06:16:08.928+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":800}}
{"t":{"$date":"2026-01-17T06:16:09.729+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":1000}}
{"t":{"$date":"2026-01-17T06:16:10.731+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":1200}}
{"t":{"$date":"2026-01-17T06:16:11.933+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":1400}}
{"t":{"$date":"2026-01-17T06:16:13.334+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":1600}}
{"t":{"$date":"2026-01-17T06:16:14.935+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":1800}}
{"t":{"$date":"2026-01-17T06:16:16.737+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":2000}}
{"t":{"$date":"2026-01-17T06:16:18.719+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"127.0.0.1:44538","uuid":"f5cfdaab-4657-4c6c-b11a-3430c13a5f13","connectionId":1,"connectionCount":1}}
{"t":{"$date":"2026-01-17T06:16:18.723+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn1","msg":"client metadata","attr":{"remote":"127.0.0.1:44538","client":"conn1","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:18.778+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":2200}}
{"t":{"$date":"2026-01-17T06:16:18.883+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"127.0.0.1:44550","uuid":"0a1c7e56-8021-44fd-a80d-33c363c1b8c7","connectionId":2,"connectionCount":2}}
{"t":{"$date":"2026-01-17T06:16:18.883+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"127.0.0.1:44566","uuid":"1ffdcc78-c523-4992-9177-52f4dd68b773","connectionId":3,"connectionCount":3}}
{"t":{"$date":"2026-01-17T06:16:18.885+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn2","msg":"client metadata","attr":{"remote":"127.0.0.1:44550","client":"conn2","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:18.886+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn3","msg":"client metadata","attr":{"remote":"127.0.0.1:44566","client":"conn3","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:18.890+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"127.0.0.1:44582","uuid":"4e465930-d826-4e6e-a256-d7f0bc1c180c","connectionId":4,"connectionCount":4}}
{"t":{"$date":"2026-01-17T06:16:18.894+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"127.0.0.1:44586","uuid":"d0ce8539-f3f8-45fe-abce-dca8c50f20d4","connectionId":5,"connectionCount":5}}
{"t":{"$date":"2026-01-17T06:16:18.894+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn4","msg":"client metadata","attr":{"remote":"127.0.0.1:44582","client":"conn4","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:18.898+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn5","msg":"client metadata","attr":{"remote":"127.0.0.1:44586","client":"conn5","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:18.921+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn4","msg":"Connection ended","attr":{"remote":"127.0.0.1:44582","uuid":"4e465930-d826-4e6e-a256-d7f0bc1c180c","connectionId":4,"connectionCount":4}}
{"t":{"$date":"2026-01-17T06:16:18.921+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn1","msg":"Connection ended","attr":{"remote":"127.0.0.1:44538","uuid":"f5cfdaab-4657-4c6c-b11a-3430c13a5f13","connectionId":1,"connectionCount":3}}
{"t":{"$date":"2026-01-17T06:16:18.921+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn3","msg":"Connection ended","attr":{"remote":"127.0.0.1:44566","uuid":"1ffdcc78-c523-4992-9177-52f4dd68b773","connectionId":3,"connectionCount":2}}
{"t":{"$date":"2026-01-17T06:16:18.922+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn2","msg":"Connection ended","attr":{"remote":"127.0.0.1:44550","uuid":"0a1c7e56-8021-44fd-a80d-33c363c1b8c7","connectionId":2,"connectionCount":1}}
{"t":{"$date":"2026-01-17T06:16:18.922+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn5","msg":"Connection ended","attr":{"remote":"127.0.0.1:44586","uuid":"d0ce8539-f3f8-45fe-abce-dca8c50f20d4","connectionId":5,"connectionCount":0}}
{"t":{"$date":"2026-01-17T06:16:19.929+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"192.168.56.237:57800","uuid":"034a1044-a217-4458-8944-c33708d5adf5","connectionId":6,"connectionCount":1}}
{"t":{"$date":"2026-01-17T06:16:19.932+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn6","msg":"client metadata","attr":{"remote":"192.168.56.237:57800","client":"conn6","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:19.998+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"192.168.56.237:57808","uuid":"4ae577bb-ca19-4768-b252-1b781d0d5dfb","connectionId":7,"connectionCount":2}}
{"t":{"$date":"2026-01-17T06:16:20.000+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn7","msg":"client metadata","attr":{"remote":"192.168.56.237:57808","client":"conn7","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:20.001+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn6","msg":"Connection ended","attr":{"remote":"192.168.56.237:57800","uuid":"034a1044-a217-4458-8944-c33708d5adf5","connectionId":6,"connectionCount":1}}
{"t":{"$date":"2026-01-17T06:16:20.007+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn7","msg":"Connection ended","attr":{"remote":"192.168.56.237:57808","uuid":"4ae577bb-ca19-4768-b252-1b781d0d5dfb","connectionId":7,"connectionCount":0}}
{"t":{"$date":"2026-01-17T06:16:20.521+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"192.168.51.224:38118","uuid":"d35de71f-9df8-4193-b7c2-342916130b1b","connectionId":8,"connectionCount":1}}
{"t":{"$date":"2026-01-17T06:16:20.524+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn8","msg":"client metadata","attr":{"remote":"192.168.51.224:38118","client":"conn8","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:20.592+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"192.168.51.224:38132","uuid":"0b0216fb-9f4b-41e7-b169-a040d02e5be4","connectionId":9,"connectionCount":2}}
{"t":{"$date":"2026-01-17T06:16:20.593+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"192.168.51.224:38136","uuid":"41febf14-2853-4281-84f9-81cb4ecbc683","connectionId":10,"connectionCount":3}}
{"t":{"$date":"2026-01-17T06:16:20.593+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn9","msg":"client metadata","attr":{"remote":"192.168.51.224:38132","client":"conn9","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:20.593+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn10","msg":"client metadata","attr":{"remote":"192.168.51.224:38136","client":"conn10","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:20.602+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"192.168.51.224:38142","uuid":"534e6035-78a5-4817-8b9c-f6eca8500470","connectionId":11,"connectionCount":4}}
{"t":{"$date":"2026-01-17T06:16:20.602+00:00"},"s":"I",  "c":"NETWORK",  "id":22943,   "ctx":"listener","msg":"Connection accepted","attr":{"remote":"192.168.51.224:38144","uuid":"b1eb1808-f7c8-4841-a2f3-c9d2f1adb3fd","connectionId":12,"connectionCount":5}}
{"t":{"$date":"2026-01-17T06:16:20.604+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn11","msg":"client metadata","attr":{"remote":"192.168.51.224:38142","client":"conn11","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:20.604+00:00"},"s":"I",  "c":"NETWORK",  "id":51800,   "ctx":"conn12","msg":"client metadata","attr":{"remote":"192.168.51.224:38144","client":"conn12","negotiatedCompressors":[],"doc":{"application":{"name":"mongosh 2.5.10"},"driver":{"name":"nodejs|mongosh","version":"6.19.0|2.5.10"},"platform":"Node.js v20.19.6, LE","os":{"name":"linux","architecture":"x64","version":"3.10.0-327.22.2.el7.x86_64","type":"Linux"},"env":{"container":{"orchestrator":"kubernetes"}}}}}
{"t":{"$date":"2026-01-17T06:16:20.624+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn10","msg":"Connection ended","attr":{"remote":"192.168.51.224:38136","uuid":"41febf14-2853-4281-84f9-81cb4ecbc683","connectionId":10,"connectionCount":4}}
{"t":{"$date":"2026-01-17T06:16:20.624+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn8","msg":"Connection ended","attr":{"remote":"192.168.51.224:38118","uuid":"d35de71f-9df8-4193-b7c2-342916130b1b","connectionId":8,"connectionCount":1}}
{"t":{"$date":"2026-01-17T06:16:20.624+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn12","msg":"Connection ended","attr":{"remote":"192.168.51.224:38144","uuid":"b1eb1808-f7c8-4841-a2f3-c9d2f1adb3fd","connectionId":12,"connectionCount":2}}
{"t":{"$date":"2026-01-17T06:16:20.625+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn9","msg":"Connection ended","attr":{"remote":"192.168.51.224:38132","uuid":"0b0216fb-9f4b-41e7-b169-a040d02e5be4","connectionId":9,"connectionCount":0}}
{"t":{"$date":"2026-01-17T06:16:20.624+00:00"},"s":"I",  "c":"NETWORK",  "id":22944,   "ctx":"conn11","msg":"Connection ended","attr":{"remote":"192.168.51.224:38142","uuid":"534e6035-78a5-4817-8b9c-f6eca8500470","connectionId":11,"connectionCount":3}}
{"t":{"$date":"2026-01-17T06:16:20.980+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":2400}}
{"t":{"$date":"2026-01-17T06:16:23.382+00:00"},"s":"I",  "c":"-",        "id":4939300, "ctx":"monitoring-keys-for-HMAC","msg":"Failed to refresh key cache","attr":{"error":"ReadConcernMajorityNotAvailableYet: Read concern majority reads are currently not possible.","nextWakeupMillis":2600}}
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME               READY   STATUS    RESTARTS   AGE
mongo-0            1/1     Running   0          68s
mongo-1            1/1     Running   0          47s
mongo-2            0/1     Running   0          19s
mongo-init-jjt8t   1/1     Running   0          68s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME               READY   STATUS      RESTARTS   AGE
mongo-0            1/1     Running     0          96s
mongo-1            1/1     Running     0          75s
mongo-2            1/1     Running     0          47s
mongo-init-jjt8t   0/1     Completed   0          96s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl apply -f create-db-user-job.yaml
job.batch/mongo-create-user created
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
kubNAME                      READY   STATUS      RESTARTS   AGE
mongo-0                   1/1     Running     0          2m2s
mongo-1                   1/1     Running     0          101s
mongo-2                   1/1     Running     0          73s
mongo-create-user-8s4jv   0/1     Completed   0          4s
mongo-init-jjt8t          0/1     Completed   0          2m2s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                      STORAGECLASS        VOLUMEATTRIBUTESCLASS   REASON   AGE
pvc-554afa9b-7ee9-450a-bb76-7e1389be721b   1Gi        RWO            Retain           Bound    default/mongo-persistent-storage-mongo-2   ebs-storage-class   <unset>                          73s
pvc-afea88fd-5957-4048-9ab7-e76bb5e6d0c3   1Gi        RWO            Retain           Bound    default/mongo-persistent-storage-mongo-0   ebs-storage-class   <unset>                          9m48s
pvc-b031a72f-654a-4d7f-8349-7d090111c142   1Gi        RWO            Retain           Bound    default/mongo-persistent-storage-mongo-1   ebs-storage-class   <unset>                          100s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl apply -f mongo-config.yml
configmap/mongo-config created
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# vi mongo-express-webapp.yml 
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl apply -f mongo-express-webapp.yml 
deployment.apps/webapp-deployment created
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              1/1     Running             0          3m25s
mongo-1                              1/1     Running             0          3m4s
mongo-2                              1/1     Running             0          2m36s
mongo-create-user-8s4jv              0/1     Completed           0          87s
mongo-init-jjt8t                     0/1     Completed           0          3m25s
webapp-deployment-5f95578997-vqjnn   0/1     ContainerCreating   0          4s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl apply -f webapp-service.yml
service/webapp-service created
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          4m42s
mongo-1                              1/1     Running     0          4m21s
mongo-2                              1/1     Running     0          3m53s
mongo-create-user-8s4jv              0/1     Completed   0          2m44s
mongo-init-jjt8t                     0/1     Completed   0          4m42s
webapp-deployment-5f95578997-vqjnn   1/1     Running     0          81s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get svc
NAME             TYPE           CLUSTER-IP      EXTERNAL-IP                                                               PORT(S)          AGE
kubernetes       ClusterIP      10.100.0.1      <none>                                                                    443/TCP          33m
mongo            ClusterIP      None            <none>                                                                    27017/TCP        12m
webapp-service   LoadBalancer   10.100.59.245   a8a498ed4a1d94f2daf6e3550b9adc40-863496964.ap-south-1.elb.amazonaws.com   8081:31077/TCP   72s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get vpa
error: the server doesn't have a resource type "vpa"
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get statefulset
NAME    READY   AGE
mongo   3/3     6m16s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# git clone https://github.com/kubernetes/autoscaler.git
Cloning into 'autoscaler'...
remote: Enumerating objects: 236069, done.
remote: Counting objects: 100% (1761/1761), done.
remote: Compressing objects: 100% (1211/1211), done.
remote: Total 236069 (delta 1131), reused 550 (delta 550), pack-reused 234308 (from 4)
Receiving objects: 100% (236069/236069), 255.57 MiB | 18.67 MiB/s, done.
Resolving deltas: 100% (153638/153638), done.
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# cd autoscaler/
[root@ip-172-31-35-71 autoscaler]# cd vertical-pod-autoscaler/
[root@ip-172-31-35-71 vertical-pod-autoscaler]# ls
MIGRATE.md  OWNERS  README.md  RELEASE.md  charts  cloudbuild.yaml  common  deploy  docs  e2e  enhancements  examples  go.mod  go.sum  hack  pkg
[root@ip-172-31-35-71 vertical-pod-autoscaler]# cd hack/
[root@ip-172-31-35-71 hack]# ls
api-docs                   e2e                   local-cluster.md            tools                             verify-codegen.sh               vpa-down.sh
boilerplate.go.txt         emit-metrics.py       run-e2e-locally.sh          tools.go                          verify-deadcode-elimination.sh  vpa-process-yaml.sh
convert-alpha-objects.sh   generate-api-docs.sh  run-e2e-tests.sh            update-codegen.sh                 verify-kubelint.sh              vpa-process-yamls.sh
deploy-for-e2e-locally.sh  generate-crd-yaml.sh  run-e2e.sh                  update-kubernetes-deps-in-e2e.sh  verify-toc.sh                   vpa-up.sh
deploy-for-e2e.sh          generate-flags.sh     run-integration-locally.sh  update-kubernetes-deps.sh         verify-vpa-flags.sh             warn-obsolete-vpa-objects.sh
dev-deploy-locally.sh      lib                   tag-release.sh              update-toc.sh                     vpa-apply-upgrade.sh
[root@ip-172-31-35-71 hack]# ./vpa-
vpa-apply-upgrade.sh  vpa-down.sh           vpa-process-yaml.sh   vpa-process-yamls.sh  vpa-up.sh             
[root@ip-172-31-35-71 hack]# ./vpa-
vpa-apply-upgrade.sh  vpa-down.sh           vpa-process-yaml.sh   vpa-process-yamls.sh  vpa-up.sh             
[root@ip-172-31-35-71 hack]# ./vpa-
vpa-apply-upgrade.sh  vpa-down.sh           vpa-process-yaml.sh   vpa-process-yamls.sh  vpa-up.sh             
[root@ip-172-31-35-71 hack]# ./vpa-up.sh 
HEAD is now at a8ca31655 Merge pull request #8612 from adrianmoisey/vpa-release-1.5
customresourcedefinition.apiextensions.k8s.io/verticalpodautoscalercheckpoints.autoscaling.k8s.io created
customresourcedefinition.apiextensions.k8s.io/verticalpodautoscalers.autoscaling.k8s.io created
clusterrole.rbac.authorization.k8s.io/system:metrics-reader created
clusterrole.rbac.authorization.k8s.io/system:vpa-actor created
clusterrole.rbac.authorization.k8s.io/system:vpa-status-actor created
clusterrole.rbac.authorization.k8s.io/system:vpa-checkpoint-actor created
clusterrole.rbac.authorization.k8s.io/system:evictioner created
clusterrole.rbac.authorization.k8s.io/system:vpa-updater-in-place created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-updater-in-place-binding created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-reader created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-actor created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-status-actor created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-checkpoint-actor created
clusterrole.rbac.authorization.k8s.io/system:vpa-target-reader created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-target-reader-binding created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-evictioner-binding created
serviceaccount/vpa-admission-controller created
serviceaccount/vpa-recommender created
serviceaccount/vpa-updater created
clusterrole.rbac.authorization.k8s.io/system:vpa-admission-controller created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-admission-controller created
clusterrole.rbac.authorization.k8s.io/system:vpa-status-reader created
clusterrolebinding.rbac.authorization.k8s.io/system:vpa-status-reader-binding created
role.rbac.authorization.k8s.io/system:leader-locking-vpa-updater created
rolebinding.rbac.authorization.k8s.io/system:leader-locking-vpa-updater created
role.rbac.authorization.k8s.io/system:leader-locking-vpa-recommender created
rolebinding.rbac.authorization.k8s.io/system:leader-locking-vpa-recommender created
deployment.apps/vpa-updater created
deployment.apps/vpa-recommender created
Generating certs for the VPA Admission Controller in /tmp/vpa-certs.
Certificate request self-signature ok
subject=CN=vpa-webhook.kube-system.svc
Uploading certs to the cluster.
secret/vpa-tls-certs created
Deleting /tmp/vpa-certs.
service/vpa-webhook created
deployment.apps/vpa-admission-controller created
service/vpa-webhook unchanged
[root@ip-172-31-35-71 hack]# kubectl get vpa
error: the server doesn't have a resource type "vpa"
[root@ip-172-31-35-71 hack]# 
[root@ip-172-31-35-71 hack]# 
[root@ip-172-31-35-71 hack]# vi vpa.yaml
[root@ip-172-31-35-71 hack]# kubectl apply -f vpa.yaml 
verticalpodautoscaler.autoscaling.k8s.io/mongo-statefulset-vpa created
[root@ip-172-31-35-71 hack]# kubectl get vpa
NAME                    MODE       CPU    MEM     PROVIDED   AGE
mongo-statefulset-vpa   Recreate   109m   250Mi   True       7s
[root@ip-172-31-35-71 hack]# kubectl describe vpa
Name:         mongo-statefulset-vpa
Namespace:    default
Labels:       <none>
Annotations:  <none>
API Version:  autoscaling.k8s.io/v1
Kind:         VerticalPodAutoscaler
Metadata:
  Creation Timestamp:  2026-01-17T06:29:35Z
  Generation:          1
  Managed Fields:
    API Version:  autoscaling.k8s.io/v1
    Fields Type:  FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          .:
          f:kubectl.kubernetes.io/last-applied-configuration:
      f:spec:
        .:
        f:targetRef:
        f:updatePolicy:
          .:
          f:updateMode:
    Manager:      kubectl-client-side-apply
    Operation:    Update
    Time:         2026-01-17T06:29:35Z
    API Version:  autoscaling.k8s.io/v1
    Fields Type:  FieldsV1
    fieldsV1:
      f:status:
        .:
        f:conditions:
        f:recommendation:
          .:
          f:containerRecommendations:
    Manager:         recommender
    Operation:       Update
    Subresource:     status
    Time:            2026-01-17T06:29:42Z
  Resource Version:  8873
  UID:               52eb2cd0-e875-488f-a1e2-7a94daae3c37
Spec:
  Target Ref:
    API Version:  apps/v1
    Kind:         StatefulSet
    Name:         mongo
  Update Policy:
    Update Mode:  Recreate
Status:
  Conditions:
    Last Transition Time:  2026-01-17T06:29:42Z
    Status:                True
    Type:                  RecommendationProvided
  Recommendation:
    Container Recommendations:
      Container Name:  mongo
      Lower Bound:
        Cpu:     34m
        Memory:  250Mi
      Target:
        Cpu:     109m
        Memory:  250Mi
      Uncapped Target:
        Cpu:     109m
        Memory:  250Mi
      Upper Bound:
        Cpu:     69356m
        Memory:  143410682666
Events:          <none>
[root@ip-172-31-35-71 hack]# kubectl top pods
NAME                                 CPU(cores)   MEMORY(bytes)   
mongo-0                              71m          179Mi           
mongo-1                              57m          78Mi            
mongo-2                              44m          80Mi            
webapp-deployment-5f95578997-vqjnn   1m           41Mi            
[root@ip-172-31-35-71 hack]# cd ../..
[root@ip-172-31-35-71 autoscaler]# cd ..
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# vi mongo-app.yml 
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          19m
mongo-1                              1/1     Running     0          19m
mongo-2                              1/1     Running     0          19m
mongo-create-user-8s4jv              0/1     Completed   0          17m
mongo-init-jjt8t                     0/1     Completed   0          19m
webapp-deployment-5f95578997-vqjnn   1/1     Running     0          16m
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# vi hpa.yaml
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# vi mongo-express-webapp.yml 
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# vi hpa.yaml
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl apply -f hpa.yaml 
error: error parsing hpa.yaml: error converting YAML to JSON: yaml: line 14: mapping values are not allowed in this context
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# vi hpa.yaml
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl apply -f hpa.yaml 
horizontalpodautoscaler.autoscaling/my-expressapp-hpa created
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS                 MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: <unknown>/90%   1         10        0          6s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS           MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 42%/90%   1         10        1          29s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl top pods
NAME                                 CPU(cores)   MEMORY(bytes)   
mongo-0                              75m          181Mi           
mongo-1                              59m          79Mi            
mongo-2                              69m          82Mi            
webapp-deployment-5f95578997-vqjnn   1m           42Mi            
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# vi hpa.yaml 
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl apply -f hpa.yaml 
horizontalpodautoscaler.autoscaling/my-expressapp-hpa configured
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS           MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 42%/30%   1         10        1          86s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# cat hpa.yaml 
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: my-expressapp-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: webapp-deployment
  minReplicas: 1
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 30
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          33m
mongo-1                              1/1     Running     0          32m
mongo-2                              1/1     Running     0          32m
mongo-create-user-8s4jv              0/1     Completed   0          31m
mongo-init-jjt8t                     0/1     Completed   0          33m
webapp-deployment-5f95578997-vqjnn   1/1     Running     0          29m
webapp-deployment-5f95578997-xxhtc   1/1     Running     0          29s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS           MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 52%/30%   1         10        4          2m16s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          33m
mongo-1                              1/1     Running     0          33m
mongo-2                              1/1     Running     0          32m
mongo-create-user-8s4jv              0/1     Completed   0          31m
mongo-init-jjt8t                     0/1     Completed   0          33m
webapp-deployment-5f95578997-f5bd2   1/1     Running     0          25s
webapp-deployment-5f95578997-hzmmv   1/1     Running     0          25s
webapp-deployment-5f95578997-rxdz4   1/1     Running     0          10s
webapp-deployment-5f95578997-vqjnn   1/1     Running     0          30m
webapp-deployment-5f95578997-w6s8m   1/1     Running     0          10s
webapp-deployment-5f95578997-xfbb4   1/1     Running     0          10s
webapp-deployment-5f95578997-xxhtc   1/1     Running     0          55s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS           MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 52%/30%   1         10        7          2m45s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          36m
mongo-1                              1/1     Running     0          35m
mongo-2                              1/1     Running     0          35m
mongo-create-user-8s4jv              0/1     Completed   0          34m
mongo-init-jjt8t                     0/1     Completed   0          36m
webapp-deployment-5f95578997-82lpg   0/1     Pending     0          2m20s
webapp-deployment-5f95578997-f5bd2   1/1     Running     0          3m5s
webapp-deployment-5f95578997-hzmmv   1/1     Running     0          3m5s
webapp-deployment-5f95578997-plwlz   1/1     Running     0          2m20s
webapp-deployment-5f95578997-rxdz4   1/1     Running     0          2m50s
webapp-deployment-5f95578997-vqjnn   1/1     Running     0          32m
webapp-deployment-5f95578997-w6s8m   1/1     Running     0          2m50s
webapp-deployment-5f95578997-x7vfd   1/1     Running     0          2m20s
webapp-deployment-5f95578997-xfbb4   1/1     Running     0          2m50s
webapp-deployment-5f95578997-xxhtc   1/1     Running     0          3m35s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl describe pod webapp-deployment-5f95578997-82lpg
Name:           webapp-deployment-5f95578997-82lpg
Namespace:      default
Priority:       0
Node:           <none>
Labels:         app=webapp
                pod-template-hash=5f95578997
Annotations:    <none>
Status:         Pending
IP:             
IPs:            <none>
Controlled By:  ReplicaSet/webapp-deployment-5f95578997
Containers:
  webapp:
    Image:      mongo-express
    Port:       8081/TCP
    Host Port:  0/TCP
    Limits:
      cpu:     300m
      memory:  200Mi
    Requests:
      cpu:     150m
      memory:  100Mi
    Environment:
      ME_CONFIG_MONGODB_ADMINUSERNAME:  <set to the key 'mongo-user' in secret 'mongo-secret'>      Optional: false
      ME_CONFIG_MONGODB_ADMINPASSWORD:  <set to the key 'mongo-password' in secret 'mongo-secret'>  Optional: false
      ME_CONFIG_MONGODB_SERVER:         <set to the key 'mongo-url' of config map 'mongo-config'>   Optional: false
      ME_CONFIG_MONGODB_PORT:           27017
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-hsnd8 (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  kube-api-access-hsnd8:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  3m    default-scheduler  0/2 nodes are available: 2 Insufficient cpu. preemption: 0/2 nodes are available: 2 No preemption victims found for incoming pod.
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# 
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# 
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get nodes
NAME                                            STATUS   ROLES    AGE   VERSION
ip-192-168-12-156.ap-south-1.compute.internal   Ready    <none>   54m   v1.32.9-eks-ecaa3a6
ip-192-168-49-96.ap-south-1.compute.internal    Ready    <none>   54m   v1.32.9-eks-ecaa3a6
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl describe node ip-192-168-12-156.ap-south-1.compute.internal
Name:               ip-192-168-12-156.ap-south-1.compute.internal
Roles:              <none>
Labels:             alpha.eksctl.io/cluster-name=EKS-GFG40-17
                    alpha.eksctl.io/nodegroup-name=node2
                    beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/instance-type=t3.medium
                    beta.kubernetes.io/os=linux
                    eks.amazonaws.com/capacityType=ON_DEMAND
                    eks.amazonaws.com/nodegroup=node2
                    eks.amazonaws.com/nodegroup-image=ami-04dfb346693754022
                    eks.amazonaws.com/sourceLaunchTemplateId=lt-0c5d10d0f36df0f62
                    eks.amazonaws.com/sourceLaunchTemplateVersion=1
                    failure-domain.beta.kubernetes.io/region=ap-south-1
                    failure-domain.beta.kubernetes.io/zone=ap-south-1a
                    k8s.io/cloud-provider-aws=9cc6909191e7f4110bad5b3ae2ac498a
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=ip-192-168-12-156.ap-south-1.compute.internal
                    kubernetes.io/os=linux
                    node.kubernetes.io/instance-type=t3.medium
                    topology.ebs.csi.aws.com/zone=ap-south-1a
                    topology.k8s.aws/zone-id=aps1-az1
                    topology.kubernetes.io/region=ap-south-1
                    topology.kubernetes.io/zone=ap-south-1a
Annotations:        alpha.kubernetes.io/provided-node-ip: 192.168.12.156
                    csi.volume.kubernetes.io/nodeid: {"ebs.csi.aws.com":"i-008ec86cc8d41d0ad"}
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Sat, 17 Jan 2026 05:59:25 +0000
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  ip-192-168-12-156.ap-south-1.compute.internal
  AcquireTime:     <unset>
  RenewTime:       Sat, 17 Jan 2026 06:53:55 +0000
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  MemoryPressure   False   Sat, 17 Jan 2026 06:52:27 +0000   Sat, 17 Jan 2026 05:59:21 +0000   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Sat, 17 Jan 2026 06:52:27 +0000   Sat, 17 Jan 2026 05:59:21 +0000   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Sat, 17 Jan 2026 06:52:27 +0000   Sat, 17 Jan 2026 05:59:21 +0000   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Sat, 17 Jan 2026 06:52:27 +0000   Sat, 17 Jan 2026 05:59:37 +0000   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:   192.168.12.156
  ExternalIP:   13.232.170.245
  InternalDNS:  ip-192-168-12-156.ap-south-1.compute.internal
  Hostname:     ip-192-168-12-156.ap-south-1.compute.internal
  ExternalDNS:  ec2-13-232-170-245.ap-south-1.compute.amazonaws.com
Capacity:
  cpu:                2
  ephemeral-storage:  20893676Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             3931728Ki
  pods:               17
Allocatable:
  cpu:                1930m
  ephemeral-storage:  18181869946
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             3376720Ki
  pods:               17
System Info:
  Machine ID:                 ec2bcdc85ae1c1b0b502c42d8dc8ac11
  System UUID:                ec2bcdc8-5ae1-c1b0-b502-c42d8dc8ac11
  Boot ID:                    46d541cc-db33-4056-b522-2a92b3e5ae8c
  Kernel Version:             6.1.159-181.297.amzn2023.x86_64
  OS Image:                   Amazon Linux 2023.10.20260105
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://2.1.5
  Kubelet Version:            v1.32.9-eks-ecaa3a6
  Kube-Proxy Version:         v1.32.9-eks-ecaa3a6
ProviderID:                   aws:///ap-south-1a/i-008ec86cc8d41d0ad
Non-terminated Pods:          (16 in total)
  Namespace                   Name                                         CPU Requests  CPU Limits  Memory Requests  Memory Limits  AGE
  ---------                   ----                                         ------------  ----------  ---------------  -------------  ---
  default                     mongo-0                                      500m (25%)    600m (31%)  300Mi (9%)       500Mi (15%)    38m
  default                     webapp-deployment-5f95578997-f5bd2           150m (7%)     300m (15%)  100Mi (3%)       200Mi (6%)     5m2s
  default                     webapp-deployment-5f95578997-plwlz           150m (7%)     300m (15%)  100Mi (3%)       200Mi (6%)     4m17s
  default                     webapp-deployment-5f95578997-vqjnn           150m (7%)     300m (15%)  100Mi (3%)       200Mi (6%)     34m
  default                     webapp-deployment-5f95578997-w6s8m           150m (7%)     300m (15%)  100Mi (3%)       200Mi (6%)     4m47s
  default                     webapp-deployment-5f95578997-x7vfd           150m (7%)     300m (15%)  100Mi (3%)       200Mi (6%)     4m17s
  default                     webapp-deployment-5f95578997-xfbb4           150m (7%)     300m (15%)  100Mi (3%)       200Mi (6%)     4m47s
  kube-system                 aws-node-hv82n                               50m (2%)      0 (0%)      0 (0%)           0 (0%)         54m
  kube-system                 coredns-6799d65cb-c9g4z                      100m (5%)     0 (0%)      70Mi (2%)        170Mi (5%)     64m
  kube-system                 ebs-csi-controller-6c6cd7b87d-tvrlp          0 (0%)        0 (0%)      0 (0%)           0 (0%)         47m
  kube-system                 ebs-csi-node-bc4m8                           0 (0%)        0 (0%)      0 (0%)           0 (0%)         47m
  kube-system                 kube-proxy-z5zwl                             100m (5%)     0 (0%)      0 (0%)           0 (0%)         54m
  kube-system                 metrics-server-6489f6d86b-x7z6t              100m (5%)     0 (0%)      200Mi (6%)       400Mi (12%)    62m
  kube-system                 vpa-admission-controller-77f9b89f68-hlxfc    50m (2%)      200m (10%)  200Mi (6%)       500Mi (15%)    27m
  kube-system                 vpa-recommender-74477d86cf-cxv2h             50m (2%)      200m (10%)  500Mi (15%)      1000Mi (30%)   27m
  kube-system                 vpa-updater-c4b976bd8-tmsgb                  50m (2%)      200m (10%)  500Mi (15%)      1000Mi (30%)   27m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests      Limits
  --------           --------      ------
  cpu                1900m (98%)   3 (155%)
  memory             2370Mi (71%)  4770Mi (144%)
  ephemeral-storage  0 (0%)        0 (0%)
  hugepages-1Gi      0 (0%)        0 (0%)
  hugepages-2Mi      0 (0%)        0 (0%)
Events:
  Type     Reason                   Age                From        Message
  ----     ------                   ----               ----        -------
  Normal   Starting                 54m                kube-proxy  
  Warning  InvalidDiskCapacity      54m                kubelet     invalid capacity 0 on image filesystem
  Normal   NodeHasSufficientMemory  54m (x2 over 54m)  kubelet     Node ip-192-168-12-156.ap-south-1.compute.internal status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    54m (x2 over 54m)  kubelet     Node ip-192-168-12-156.ap-south-1.compute.internal status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     54m (x2 over 54m)  kubelet     Node ip-192-168-12-156.ap-south-1.compute.internal status is now: NodeHasSufficientPID
  Normal   NodeAllocatableEnforced  54m                kubelet     Updated Node Allocatable limit across pods
  Normal   Starting                 54m                kubelet     Starting kubelet.
  Normal   NodeReady                54m                kubelet     Node ip-192-168-12-156.ap-south-1.compute.internal status is now: NodeReady
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS           MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 41%/30%   1         10        10         9m38s
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# vi hpa.yaml 
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl apply -f hpa.yaml 
horizontalpodautoscaler.autoscaling/my-expressapp-hpa configured
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS           MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 41%/95%   1         10        10         10m
[root@ip-172-31-35-71 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          41m
mongo-1                              1/1     Running     0          41m
mongo-2                              1/1     Running     0          40m
mongo-create-user-8s4jv              0/1     Completed   0          39m
mongo-init-jjt8t                     0/1     Completed   0          41m
webapp-deployment-5f95578997-82lpg   0/1     Pending     0          7m51s
webapp-deployment-5f95578997-f5bd2   1/1     Running     0          8m36s
webapp-deployment-5f95578997-hzmmv   1/1     Running     0          8m36s
webapp-deployment-5f95578997-plwlz   1/1     Running     0          7m51s
webapp-deployment-5f95578997-rxdz4   1/1     Running     0          8m21s
webapp-deployment-5f95578997-vqjnn   1/1     Running     0          38m
webapp-deployment-5f95578997-w6s8m   1/1     Running     0          8m21s
webapp-deployment-5f95578997-x7vfd   1/1     Running     0          7m51s
webapp-deployment-5f95578997-xfbb4   1/1     Running     0          8m21s
webapp-deployment-5f95578997-xxhtc   1/1     Running     0          9m6s