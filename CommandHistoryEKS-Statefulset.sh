yum install git -y 
git clone https://github.com/sudhanshuvlog/K8s-MERN-App-Deployment.git
git switch dev
aws configure
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --short --client


eksctl create cluster --name=EKS-1 \
                      --region=ap-south-1 \
                      --zones=ap-south-1a,ap-south-1b \
                      --without-nodegroup

eksctl utils associate-iam-oidc-provider \
    --region ap-south-1 \
    --cluster EKS-1 \
    --approve

eksctl create nodegroup --cluster=EKS-1 \
                       --region=ap-south-1 \
                       --name=node2 \
                       --node-type=t3.medium \
                       --nodes=2 \
                       --nodes-min=2 \
                       --nodes-max=2 \
                       --node-volume-size=20 \
                       --ssh-access \
                       --ssh-public-key=DevOps \
                       --managed \
                       --asg-access \
                       --external-dns-access \
                       --full-ecr-access \
                       --appmesh-access \
                       --alb-ingress-access

Create an IAM Policy with the below access
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AttachVolume",
                "ec2:CreateSnapshot",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:DeleteSnapshot",
                "ec2:DeleteTags",
                "ec2:DeleteVolume",
                "ec2:DescribeInstances",
                "ec2:DescribeSnapshots",
                "ec2:DescribeTags",
                "ec2:DescribeVolumes",
                "ec2:DetachVolume"
            ],
            "Resource": "*"
        }
    ]
}

kubectl -n kube-system describe configmap aws-auth
go to the role and attach the policy

kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.4"

kubectl apply -f secret.yml
run the service account and then mongo-app


####Command History from here ####

[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl exec -it mongo-0 -- bash
root@mongo-0:/# mongosh -u admin -p redhat
Current Mongosh Log ID: 69634de0de5544232a8de665
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.5.10
MongoServerError: Authentication failed.
root@mongo-0:/# mongosh -u root -p redhat
Current Mongosh Log ID: 69634de7209493f6f18de665
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.5.10
MongoServerError: Authentication failed.
root@mongo-0:/# exit
exit
command terminated with exit code 1
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME               READY   STATUS      RESTARTS   AGE
mongo-0            1/1     Running     0          10m
mongo-1            1/1     Running     0          10m
mongo-2            1/1     Running     0          9m53s
mongo-init-kr96q   0/1     Completed   0          10m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubect apply -f create-db-user-job.yaml 
bash: kubect: command not found
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl apply -f create-db-user-job.yaml 
kjob.batch/mongo-create-user created
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                      READY   STATUS      RESTARTS   AGE
mongo-0                   1/1     Running     0          11m
mongo-1                   1/1     Running     0          10m
mongo-2                   1/1     Running     0          10m
mongo-create-user-fsdmk   0/1     Completed   0          3s
mongo-init-kr96q          0/1     Completed   0          11m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl exec -it mongo-0 -- bash
root@mongo-0:/# mongosh -u admin -p redhat
Current Mongosh Log ID: 69634ee4d3bb1563b28de665
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.5.10
Using MongoDB:          5.0.32
Using Mongosh:          2.5.10

For mongosh info see: https://www.mongodb.com/docs/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2026-01-11T07:07:53.971+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
   2026-01-11T07:07:54.550+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2026-01-11T07:07:54.550+00:00: You are running this process as the root user, which is not recommended
------

rs0 [direct: primary] test> rs.status()
{
  set: 'rs0',
  date: ISODate('2026-01-11T07:19:12.514Z'),
  myState: 1,
  term: Long('1'),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1768115943, i: 1 }), t: Long('1') },
    lastCommittedWallTime: ISODate('2026-01-11T07:19:03.451Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1768115943, i: 1 }), t: Long('1') },
    appliedOpTime: { ts: Timestamp({ t: 1768115943, i: 1 }), t: Long('1') },
    durableOpTime: { ts: Timestamp({ t: 1768115943, i: 1 }), t: Long('1') },
    lastAppliedWallTime: ISODate('2026-01-11T07:19:03.451Z'),
    lastDurableWallTime: ISODate('2026-01-11T07:19:03.451Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1768115921, i: 4 }),
  electionCandidateMetrics: {
    lastElectionReason: 'electionTimeout',
    lastElectionDate: ISODate('2026-01-11T07:09:03.371Z'),
    electionTerm: Long('1'),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1768115332, i: 1 }), t: Long('-1') },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1768115332, i: 1 }), t: Long('-1') },
    numVotesNeeded: 2,
    priorityAtElection: 1,
    electionTimeoutMillis: Long('10000'),
    numCatchUpOps: Long('0'),
    newTermStartDate: ISODate('2026-01-11T07:09:03.418Z'),
    wMajorityWriteAvailabilityDate: ISODate('2026-01-11T07:09:03.951Z')
  },
  members: [
    {
      _id: 0,
      name: 'mongo-0.mongo:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 679,
      optime: { ts: Timestamp({ t: 1768115943, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2026-01-11T07:19:03.000Z'),
      lastAppliedWallTime: ISODate('2026-01-11T07:19:03.451Z'),
      lastDurableWallTime: ISODate('2026-01-11T07:19:03.451Z'),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1768115343, i: 1 }),
      electionDate: ISODate('2026-01-11T07:09:03.000Z'),
      configVersion: 1,
      configTerm: 1,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 1,
      name: 'mongo-1.mongo:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 620,
      optime: { ts: Timestamp({ t: 1768115943, i: 1 }), t: Long('1') },
      optimeDurable: { ts: Timestamp({ t: 1768115943, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2026-01-11T07:19:03.000Z'),
      optimeDurableDate: ISODate('2026-01-11T07:19:03.000Z'),
      lastAppliedWallTime: ISODate('2026-01-11T07:19:03.451Z'),
      lastDurableWallTime: ISODate('2026-01-11T07:19:03.451Z'),
      lastHeartbeat: ISODate('2026-01-11T07:19:11.707Z'),
      lastHeartbeatRecv: ISODate('2026-01-11T07:19:10.746Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongo-0.mongo:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 1,
      configTerm: 1
    },
    {
      _id: 2,
      name: 'mongo-2.mongo:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 620,
      optime: { ts: Timestamp({ t: 1768115943, i: 1 }), t: Long('1') },
      optimeDurable: { ts: Timestamp({ t: 1768115943, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2026-01-11T07:19:03.000Z'),
      optimeDurableDate: ISODate('2026-01-11T07:19:03.000Z'),
      lastAppliedWallTime: ISODate('2026-01-11T07:19:03.451Z'),
      lastDurableWallTime: ISODate('2026-01-11T07:19:03.451Z'),
      lastHeartbeat: ISODate('2026-01-11T07:19:11.402Z'),
      lastHeartbeatRecv: ISODate('2026-01-11T07:19:12.415Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongo-0.mongo:27017',
      syncSourceId: 0,
      infoMessage: '',
      configVersion: 1,
      configTerm: 1
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1768115943, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1768115943, i: 1 })
}
rs0 [direct: primary] test> exit
root@mongo-0:/# exit
exit
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                      READY   STATUS      RESTARTS   AGE
mongo-0                   1/1     Running     0          13m
mongo-1                   1/1     Running     0          12m
mongo-2                   1/1     Running     0          12m
mongo-create-user-fsdmk   0/1     Completed   0          2m5s
mongo-init-kr96q          0/1     Completed   0          13m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get statefulset
NAME    READY   AGE
mongo   3/3     13m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl apply -f mongo-config.yml 
configmap/mongo-config created
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get configmap
NAME               DATA   AGE
kube-root-ca.crt   1      67m
mongo-config       1      6s
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl apply -f mongo-express-webapp.yml 
deployment.apps/webapp-deployment created
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              1/1     Running             0          15m
mongo-1                              1/1     Running             0          14m
mongo-2                              1/1     Running             0          14m
mongo-create-user-fsdmk              0/1     Completed           0          4m18s
mongo-init-kr96q                     0/1     Completed           0          15m
webapp-deployment-69b6bb6b79-6r44h   0/1     ContainerCreating   0          4s
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl apply -f webapp-service.yml 
service/webapp-service created
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get svc
NAME             TYPE           CLUSTER-IP       EXTERNAL-IP                                                               PORT(S)          AGE
kubernetes       ClusterIP      10.100.0.1       <none>                                                                    443/TCP          69m
mongo            ClusterIP      None             <none>                                                                    27017/TCP        16m
webapp-service   LoadBalancer   10.100.141.175   a45700aea5fe64919b9a7ea8a4b63491-462594386.ap-south-1.elb.amazonaws.com   8081:31715/TCP   3s
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get nodes
NAME                                           STATUS   ROLES    AGE   VERSION
ip-192-168-48-75.ap-south-1.compute.internal   Ready    <none>   62m   v1.32.9-eks-ecaa3a6
ip-192-168-9-74.ap-south-1.compute.internal    Ready    <none>   62m   v1.32.9-eks-ecaa3a6
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pod
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          17m
mongo-1                              1/1     Running     0          16m
mongo-2                              1/1     Running     0          16m
mongo-create-user-fsdmk              0/1     Completed   0          6m27s
mongo-init-kr96q                     0/1     Completed   0          17m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running     0          2m13s
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl describe pod mongo-0
Name:         mongo-0
Namespace:    default
Priority:     0
Node:         ip-192-168-9-74.ap-south-1.compute.internal/192.168.9.74
Start Time:   Sun, 11 Jan 2026 07:07:32 +0000
Labels:       app=mongo
              apps.kubernetes.io/pod-index=0
              controller-revision-hash=mongo-695dff95f
              statefulset.kubernetes.io/pod-name=mongo-0
Annotations:  <none>
Status:       Running
IP:           192.168.3.108
IPs:
  IP:           192.168.3.108
Controlled By:  StatefulSet/mongo
Containers:
  mongo:
    Container ID:  containerd://c6a0d6ce08d04f281d0c1c8a7fa2574ff5f86481531d3e2558748d6a61340a2e
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
      Started:      Sun, 11 Jan 2026 07:07:53 +0000
    Ready:          True
    Restart Count:  0
    Readiness:      exec [mongosh --eval db.adminCommand('ping')] delay=10s timeout=1s period=10s #success=1 #failure=3
    Environment:
      MONGO_INITDB_ROOT_USERNAME:  <set to the key 'mongo-user' in secret 'mongo-secret'>      Optional: false
      MONGO_INITDB_ROOT_PASSWORD:  <set to the key 'mongo-password' in secret 'mongo-secret'>  Optional: false
    Mounts:
      /data/db from mongo-persistent-storage (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-xrwxz (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  mongo-persistent-storage:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  mongo-persistent-storage-mongo-0
    ReadOnly:   false
  kube-api-access-xrwxz:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason                  Age                From                     Message
  ----     ------                  ----               ----                     -------
  Normal   Scheduled               18m                default-scheduler        Successfully assigned default/mongo-0 to ip-192-168-9-74.ap-south-1.compute.internal
  Normal   SuccessfulAttachVolume  18m                attachdetach-controller  AttachVolume.Attach succeeded for volume "pvc-8b590b3c-1da7-4038-b1c5-bbec957873bb"
  Normal   Pulling                 18m                kubelet                  Pulling image "mongo:5.0"
  Normal   Pulled                  17m                kubelet                  Successfully pulled image "mongo:5.0" in 16.987s (16.987s including waiting). Image size: 287269680 bytes.
  Normal   Created                 17m                kubelet                  Created container: mongo
  Normal   Started                 17m                kubelet                  Started container mongo
  Warning  Unhealthy               14m (x2 over 16m)  kubelet                  Readiness probe failed: command timed out: "mongosh --eval db.adminCommand('ping')" timed out after 1s
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pod
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          18m
mongo-1                              1/1     Running     0          17m
mongo-2                              1/1     Running     0          17m
mongo-create-user-fsdmk              0/1     Completed   0          7m7s
mongo-init-kr96q                     0/1     Completed   0          18m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running     0          2m53s
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get nodes
NAME                                           STATUS   ROLES    AGE   VERSION
ip-192-168-48-75.ap-south-1.compute.internal   Ready    <none>   62m   v1.32.9-eks-ecaa3a6
ip-192-168-9-74.ap-south-1.compute.internal    Ready    <none>   62m   v1.32.9-eks-ecaa3a6
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl describe pod mongo-1
Name:         mongo-1
Namespace:    default
Priority:     0
Node:         ip-192-168-48-75.ap-south-1.compute.internal/192.168.48.75
Start Time:   Sun, 11 Jan 2026 07:08:11 +0000
Labels:       app=mongo
              apps.kubernetes.io/pod-index=1
              controller-revision-hash=mongo-695dff95f
              statefulset.kubernetes.io/pod-name=mongo-1
Annotations:  <none>
Status:       Running
IP:           192.168.47.159
IPs:
  IP:           192.168.47.159
Controlled By:  StatefulSet/mongo
Containers:
  mongo:
    Container ID:  containerd://0d78d776a0422f1a8e84f64676eb661e7969c6f57e3dd53a3290d9f77ef630c9
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
      Started:      Sun, 11 Jan 2026 07:08:14 +0000
    Ready:          True
    Restart Count:  0
    Readiness:      exec [mongosh --eval db.adminCommand('ping')] delay=10s timeout=1s period=10s #success=1 #failure=3
    Environment:
      MONGO_INITDB_ROOT_USERNAME:  <set to the key 'mongo-user' in secret 'mongo-secret'>      Optional: false
      MONGO_INITDB_ROOT_PASSWORD:  <set to the key 'mongo-password' in secret 'mongo-secret'>  Optional: false
    Mounts:
      /data/db from mongo-persistent-storage (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-59q9k (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  mongo-persistent-storage:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  mongo-persistent-storage-mongo-1
    ReadOnly:   false
  kube-api-access-59q9k:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason                  Age   From                     Message
  ----     ------                  ----  ----                     -------
  Normal   Scheduled               17m   default-scheduler        Successfully assigned default/mongo-1 to ip-192-168-48-75.ap-south-1.compute.internal
  Normal   SuccessfulAttachVolume  17m   attachdetach-controller  AttachVolume.Attach succeeded for volume "pvc-28afcbc1-7aa5-4cfb-a5a9-5c797f0f3486"
  Normal   Pulled                  17m   kubelet                  Container image "mongo:5.0" already present on machine
  Normal   Created                 17m   kubelet                  Created container: mongo
  Normal   Started                 17m   kubelet                  Started container mongo
  Warning  Unhealthy               13m   kubelet                  Readiness probe failed: command timed out: "mongosh --eval db.adminCommand('ping')" timed out after 1s
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get nodes
NAME                                           STATUS   ROLES    AGE   VERSION
ip-192-168-48-75.ap-south-1.compute.internal   Ready    <none>   63m   v1.32.9-eks-ecaa3a6
ip-192-168-9-74.ap-south-1.compute.internal    Ready    <none>   63m   v1.32.9-eks-ecaa3a6
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          20m
mongo-1                              1/1     Running     0          20m
mongo-2                              1/1     Running     0          19m
mongo-create-user-fsdmk              0/1     Completed   0          9m39s
mongo-init-kr96q                     0/1     Completed   0          20m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running     0          5m25s
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl delete pod mongo-0
kpod "mongo-0" deleted
ubectl get pods[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              0/1     ContainerCreating   0          3s
mongo-1                              1/1     Running             0          22m
mongo-2                              1/1     Running             0          21m
mongo-create-user-fsdmk              0/1     Completed           0          11m
mongo-init-kr96q                     0/1     Completed           0          22m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running             0          7m16s
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          43s
mongo-1                              1/1     Running     0          22m
mongo-2                              1/1     Running     0          22m
mongo-create-user-fsdmk              0/1     Completed   0          12m
mongo-init-kr96q                     0/1     Completed   0          23m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running     0          7m56s
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl exec mongo-1 -- bash
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl exec mongo-1 -- bash
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl exec mongo-0 -- bash
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl exec -it mongo-1 -- bash
root@mongo-1:/# 
root@mongo-1:/# 
root@mongo-1:/# mogosh -u admin -p redhat
bash: mogosh: command not found
root@mongo-1:/# mongosh -u admin -p redhat
Current Mongosh Log ID: 69635202683caa6cbb8de665
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.5.10
Using MongoDB:          5.0.32
Using Mongosh:          2.5.10

For mongosh info see: https://www.mongodb.com/docs/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2026-01-11T07:08:14.771+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
   2026-01-11T07:08:15.355+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2026-01-11T07:08:15.355+00:00: You are running this process as the root user, which is not recommended
------

rs0 [direct: primary] test> rs.status()
{
  set: 'rs0',
  date: ISODate('2026-01-11T07:32:31.211Z'),
  myState: 1,
  term: Long('2'),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1768116749, i: 1 }), t: Long('2') },
    lastCommittedWallTime: ISODate('2026-01-11T07:32:29.346Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1768116749, i: 1 }), t: Long('2') },
    appliedOpTime: { ts: Timestamp({ t: 1768116749, i: 1 }), t: Long('2') },
    durableOpTime: { ts: Timestamp({ t: 1768116749, i: 1 }), t: Long('2') },
    lastAppliedWallTime: ISODate('2026-01-11T07:32:29.346Z'),
    lastDurableWallTime: ISODate('2026-01-11T07:32:29.346Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1768116719, i: 1 }),
  electionCandidateMetrics: {
    lastElectionReason: 'stepUpRequestSkipDryRun',
    lastElectionDate: ISODate('2026-01-11T07:29:49.329Z'),
    electionTerm: Long('2'),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1768116583, i: 1 }), t: Long('1') },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1768116583, i: 1 }), t: Long('1') },
    numVotesNeeded: 2,
    priorityAtElection: 1,
    electionTimeoutMillis: Long('10000'),
    priorPrimaryMemberId: 0,
    numCatchUpOps: Long('0'),
    newTermStartDate: ISODate('2026-01-11T07:29:49.340Z'),
    wMajorityWriteAvailabilityDate: ISODate('2026-01-11T07:29:50.353Z')
  },
  electionParticipantMetrics: {
    votedForCandidate: true,
    electionTerm: Long('1'),
    lastVoteDate: ISODate('2026-01-11T07:09:03.375Z'),
    electionCandidateMemberId: 0,
    voteReason: '',
    lastAppliedOpTimeAtElection: { ts: Timestamp({ t: 1768115332, i: 1 }), t: Long('-1') },
    maxAppliedOpTimeInSet: { ts: Timestamp({ t: 1768115332, i: 1 }), t: Long('-1') },
    priorityAtElection: 1
  },
  members: [
    {
      _id: 0,
      name: 'mongo-0.mongo:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 113,
      optime: { ts: Timestamp({ t: 1768116749, i: 1 }), t: Long('2') },
      optimeDurable: { ts: Timestamp({ t: 1768116749, i: 1 }), t: Long('2') },
      optimeDate: ISODate('2026-01-11T07:32:29.000Z'),
      optimeDurableDate: ISODate('2026-01-11T07:32:29.000Z'),
      lastAppliedWallTime: ISODate('2026-01-11T07:32:29.346Z'),
      lastDurableWallTime: ISODate('2026-01-11T07:32:29.346Z'),
      lastHeartbeat: ISODate('2026-01-11T07:32:29.517Z'),
      lastHeartbeatRecv: ISODate('2026-01-11T07:32:29.701Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongo-2.mongo:27017',
      syncSourceId: 2,
      infoMessage: '',
      configVersion: 1,
      configTerm: 2
    },
    {
      _id: 1,
      name: 'mongo-1.mongo:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 1457,
      optime: { ts: Timestamp({ t: 1768116749, i: 1 }), t: Long('2') },
      optimeDate: ISODate('2026-01-11T07:32:29.000Z'),
      lastAppliedWallTime: ISODate('2026-01-11T07:32:29.346Z'),
      lastDurableWallTime: ISODate('2026-01-11T07:32:29.346Z'),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1768116589, i: 1 }),
      electionDate: ISODate('2026-01-11T07:29:49.000Z'),
      configVersion: 1,
      configTerm: 2,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 2,
      name: 'mongo-2.mongo:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 1418,
      optime: { ts: Timestamp({ t: 1768116749, i: 1 }), t: Long('2') },
      optimeDurable: { ts: Timestamp({ t: 1768116749, i: 1 }), t: Long('2') },
      optimeDate: ISODate('2026-01-11T07:32:29.000Z'),
      optimeDurableDate: ISODate('2026-01-11T07:32:29.000Z'),
      lastAppliedWallTime: ISODate('2026-01-11T07:32:29.346Z'),
      lastDurableWallTime: ISODate('2026-01-11T07:32:29.346Z'),
      lastHeartbeat: ISODate('2026-01-11T07:32:29.421Z'),
      lastHeartbeatRecv: ISODate('2026-01-11T07:32:30.499Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongo-1.mongo:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 1,
      configTerm: 2
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1768116749, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1768116749, i: 1 })
}
rs0 [direct: primary] test> exit
root@mongo-1:/# exit
exit
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          13m
mongo-1                              1/1     Running     0          35m
mongo-2                              1/1     Running     0          34m
mongo-create-user-fsdmk              0/1     Completed   0          24m
mongo-init-kr96q                     0/1     Completed   0          35m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running     0          20m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# vi mongo-app.yml
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl top pods
NAME                                 CPU(cores)   MEMORY(bytes)   
mongo-0                              78m          181Mi           
mongo-1                              96m          82Mi            
mongo-2                              90m          83Mi            
webapp-deployment-69b6bb6b79-6r44h   1m           45Mi            
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl apply -f mongo-app.yml 
statefulset.apps/mongo configured
service/mongo unchanged
job.batch/mongo-init unchanged
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS        RESTARTS   AGE
mongo-0                              1/1     Running       0          21m
mongo-1                              1/1     Running       0          43m
mongo-2                              1/1     Terminating   0          42m
mongo-create-user-fsdmk              0/1     Completed     0          32m
mongo-init-kr96q                     0/1     Completed     0          43m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running       0          28m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              1/1     Running             0          21m
mongo-1                              1/1     Running             0          43m
mongo-2                              0/1     ContainerCreating   0          16s
mongo-create-user-fsdmk              0/1     Completed           0          32m
mongo-init-kr96q                     0/1     Completed           0          44m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running             0          28m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              1/1     Running             0          22m
mongo-1                              1/1     Running             0          44m
mongo-2                              0/1     ContainerCreating   0          73s
mongo-create-user-fsdmk              0/1     Completed           0          33m
mongo-init-kr96q                     0/1     Completed           0          45m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running             0          29m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl describe pod mongo-2
Name:           mongo-2
Namespace:      default
Priority:       0
Node:           ip-192-168-9-74.ap-south-1.compute.internal/192.168.9.74
Start Time:     Sun, 11 Jan 2026 07:51:22 +0000
Labels:         app=mongo
                apps.kubernetes.io/pod-index=2
                controller-revision-hash=mongo-7bd5fcd778
                statefulset.kubernetes.io/pod-name=mongo-2
Annotations:    <none>
Status:         Pending
IP:             
IPs:            <none>
Controlled By:  StatefulSet/mongo
Containers:
  mongo:
    Container ID:  
    Image:         mongo:5.0
    Image ID:      
    Port:          27017/TCP
    Host Port:     0/TCP
    Command:
      mongod
      --replSet
      rs0
      --bind_ip_all
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Limits:
      cpu:     160m
      memory:  150
    Requests:
      cpu:      100m
      memory:   100
    Readiness:  exec [mongosh --eval db.adminCommand('ping')] delay=10s timeout=1s period=10s #success=1 #failure=3
    Environment:
      MONGO_INITDB_ROOT_USERNAME:  <set to the key 'mongo-user' in secret 'mongo-secret'>      Optional: false
      MONGO_INITDB_ROOT_PASSWORD:  <set to the key 'mongo-password' in secret 'mongo-secret'>  Optional: false
    Mounts:
      /data/db from mongo-persistent-storage (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4vcwd (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   False 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  mongo-persistent-storage:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  mongo-persistent-storage-mongo-2
    ReadOnly:   false
  kube-api-access-4vcwd:
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
  Type     Reason       Age   From               Message
  ----     ------       ----  ----               -------
  Normal   Scheduled    90s   default-scheduler  Successfully assigned default/mongo-2 to ip-192-168-9-74.ap-south-1.compute.internal
  Warning  FailedMount  90s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-4vcwd" : write /var/lib/kubelet/pods/401a3c76-2842-4ff7-a556-afcfdd0072c4/volumes/kubernetes.io~projected/kube-api-access-4vcwd/..2026_01_11_07_51_22.1187784267/ca.crt: no space left on device
  Warning  FailedMount  90s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-4vcwd" : write /var/lib/kubelet/pods/401a3c76-2842-4ff7-a556-afcfdd0072c4/volumes/kubernetes.io~projected/kube-api-access-4vcwd/..2026_01_11_07_51_22.3310045416/ca.crt: no space left on device
  Warning  FailedMount  88s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-4vcwd" : write /var/lib/kubelet/pods/401a3c76-2842-4ff7-a556-afcfdd0072c4/volumes/kubernetes.io~projected/kube-api-access-4vcwd/..2026_01_11_07_51_24.1763394815/token: no space left on device
  Warning  FailedMount  86s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-4vcwd" : write /var/lib/kubelet/pods/401a3c76-2842-4ff7-a556-afcfdd0072c4/volumes/kubernetes.io~projected/kube-api-access-4vcwd/..2026_01_11_07_51_26.3711226488/ca.crt: no space left on device
  Warning  FailedMount  82s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-4vcwd" : write /var/lib/kubelet/pods/401a3c76-2842-4ff7-a556-afcfdd0072c4/volumes/kubernetes.io~projected/kube-api-access-4vcwd/..2026_01_11_07_51_30.1392237605/namespace: no space left on device
  Warning  FailedMount  74s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-4vcwd" : write /var/lib/kubelet/pods/401a3c76-2842-4ff7-a556-afcfdd0072c4/volumes/kubernetes.io~projected/kube-api-access-4vcwd/..2026_01_11_07_51_38.4224968057/ca.crt: no space left on device
  Warning  FailedMount  58s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-4vcwd" : write /var/lib/kubelet/pods/401a3c76-2842-4ff7-a556-afcfdd0072c4/volumes/kubernetes.io~projected/kube-api-access-4vcwd/..2026_01_11_07_51_54.1464761352/ca.crt: no space left on device
  Warning  FailedMount  26s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-4vcwd" : write /var/lib/kubelet/pods/401a3c76-2842-4ff7-a556-afcfdd0072c4/volumes/kubernetes.io~projected/kube-api-access-4vcwd/..2026_01_11_07_52_26.11996810/token: no space left on device
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get statefulset
NAME    READY   AGE
mongo   2/3     46m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              1/1     Running             0          23m
mongo-1                              1/1     Running             0          45m
mongo-2                              0/1     ContainerCreating   0          2m19s
mongo-create-user-fsdmk              0/1     Completed           0          35m
mongo-init-kr96q                     0/1     Completed           0          46m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running             0          30m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl delete statefulset mongo
statefulset.apps "mongo" deleted
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pod
NAME                                 READY   STATUS        RESTARTS   AGE
mongo-0                              1/1     Terminating   0          24m
mongo-1                              1/1     Terminating   0          46m
mongo-create-user-fsdmk              0/1     Completed     0          35m
mongo-init-kr96q                     0/1     Completed     0          46m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running       0          31m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pod
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-create-user-fsdmk              0/1     Completed   0          37m
mongo-init-kr96q                     0/1     Completed   0          48m
webapp-deployment-69b6bb6b79-6r44h   1/1     Running     0          33m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl delete job mongo-init mongo-create-user
job.batch "mongo-init" deleted
job.batch "mongo-create-user" deleted
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                      STORAGECLASS        VOLUMEATTRIBUTESCLASS   REASON   AGE
pvc-28afcbc1-7aa5-4cfb-a5a9-5c797f0f3486   1Gi        RWO            Retain           Bound    default/mongo-persistent-storage-mongo-1   ebs-storage-class   <unset>                          48m
pvc-8b590b3c-1da7-4038-b1c5-bbec957873bb   1Gi        RWO            Retain           Bound    default/mongo-persistent-storage-mongo-0   ebs-storage-class   <unset>                          48m
pvc-f7db061f-6848-40ca-945a-b5344a4021bd   1Gi        RWO            Retain           Bound    default/mongo-persistent-storage-mongo-2   ebs-storage-class   <unset>                          47m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS    RESTARTS   AGE
webapp-deployment-69b6bb6b79-6r44h   1/1     Running   0          33m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl apply -f mongo-app.yml 
statefulset.apps/mongo created
service/mongo unchanged
job.batch/mongo-init created
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pod
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              0/1     ContainerCreating   0          6s
mongo-init-4npkn                     1/1     Running             0          6s
webapp-deployment-69b6bb6b79-6r44h   1/1     Running             0          34m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              0/1     ContainerCreating   0          2m8s
mongo-init-4npkn                     1/1     Running             0          2m8s
webapp-deployment-69b6bb6b79-6r44h   1/1     Running             0          36m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl describe pod mongo-0
Name:           mongo-0
Namespace:      default
Priority:       0
Node:           ip-192-168-9-74.ap-south-1.compute.internal/192.168.9.74
Start Time:     Sun, 11 Jan 2026 07:57:01 +0000
Labels:         app=mongo
                apps.kubernetes.io/pod-index=0
                controller-revision-hash=mongo-7bd5fcd778
                statefulset.kubernetes.io/pod-name=mongo-0
Annotations:    <none>
Status:         Pending
IP:             
IPs:            <none>
Controlled By:  StatefulSet/mongo
Containers:
  mongo:
    Container ID:  
    Image:         mongo:5.0
    Image ID:      
    Port:          27017/TCP
    Host Port:     0/TCP
    Command:
      mongod
      --replSet
      rs0
      --bind_ip_all
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Limits:
      cpu:     160m
      memory:  150
    Requests:
      cpu:      100m
      memory:   100
    Readiness:  exec [mongosh --eval db.adminCommand('ping')] delay=10s timeout=1s period=10s #success=1 #failure=3
    Environment:
      MONGO_INITDB_ROOT_USERNAME:  <set to the key 'mongo-user' in secret 'mongo-secret'>      Optional: false
      MONGO_INITDB_ROOT_PASSWORD:  <set to the key 'mongo-password' in secret 'mongo-secret'>  Optional: false
    Mounts:
      /data/db from mongo-persistent-storage (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-n9bk9 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   False 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  mongo-persistent-storage:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  mongo-persistent-storage-mongo-0
    ReadOnly:   false
  kube-api-access-n9bk9:
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
  Type     Reason                  Age    From                     Message
  ----     ------                  ----   ----                     -------
  Normal   Scheduled               2m21s  default-scheduler        Successfully assigned default/mongo-0 to ip-192-168-9-74.ap-south-1.compute.internal
  Warning  FailedMount             2m22s  kubelet                  MountVolume.SetUp failed for volume "kube-api-access-n9bk9" : write /var/lib/kubelet/pods/74de3700-7676-4cd4-ab63-5aeb47c42237/volumes/kubernetes.io~projected/kube-api-access-n9bk9/..2026_01_11_07_57_01.877523774/ca.crt: no space left on device
  Warning  FailedMount             2m21s  kubelet                  MountVolume.SetUp failed for volume "kube-api-access-n9bk9" : write /var/lib/kubelet/pods/74de3700-7676-4cd4-ab63-5aeb47c42237/volumes/kubernetes.io~projected/kube-api-access-n9bk9/..2026_01_11_07_57_02.3086974579/token: no space left on device
  Warning  FailedMount             2m20s  kubelet                  MountVolume.SetUp failed for volume "kube-api-access-n9bk9" : write /var/lib/kubelet/pods/74de3700-7676-4cd4-ab63-5aeb47c42237/volumes/kubernetes.io~projected/kube-api-access-n9bk9/..2026_01_11_07_57_03.692377320/token: no space left on device
  Normal   SuccessfulAttachVolume  2m19s  attachdetach-controller  AttachVolume.Attach succeeded for volume "pvc-8b590b3c-1da7-4038-b1c5-bbec957873bb"
  Warning  FailedMount             2m18s  kubelet                  MountVolume.SetUp failed for volume "kube-api-access-n9bk9" : write /var/lib/kubelet/pods/74de3700-7676-4cd4-ab63-5aeb47c42237/volumes/kubernetes.io~projected/kube-api-access-n9bk9/..2026_01_11_07_57_05.1440646144/ca.crt: no space left on device
  Warning  FailedMount             2m14s  kubelet                  MountVolume.SetUp failed for volume "kube-api-access-n9bk9" : write /var/lib/kubelet/pods/74de3700-7676-4cd4-ab63-5aeb47c42237/volumes/kubernetes.io~projected/kube-api-access-n9bk9/..2026_01_11_07_57_09.1567165671/token: no space left on device
  Warning  FailedMount             2m6s   kubelet                  MountVolume.SetUp failed for volume "kube-api-access-n9bk9" : write /var/lib/kubelet/pods/74de3700-7676-4cd4-ab63-5aeb47c42237/volumes/kubernetes.io~projected/kube-api-access-n9bk9/..2026_01_11_07_57_17.1964082594/ca.crt: no space left on device
  Warning  FailedMount             110s   kubelet                  MountVolume.SetUp failed for volume "kube-api-access-n9bk9" : write /var/lib/kubelet/pods/74de3700-7676-4cd4-ab63-5aeb47c42237/volumes/kubernetes.io~projected/kube-api-access-n9bk9/..2026_01_11_07_57_33.184944309/ca.crt: no space left on device
  Warning  FailedMount             77s    kubelet                  MountVolume.SetUp failed for volume "kube-api-access-n9bk9" : write /var/lib/kubelet/pods/74de3700-7676-4cd4-ab63-5aeb47c42237/volumes/kubernetes.io~projected/kube-api-access-n9bk9/..2026_01_11_07_58_06.1163575123/ca.crt: no space left on device
  Warning  FailedMount             13s    kubelet                  MountVolume.SetUp failed for volume "kube-api-access-n9bk9" : write /var/lib/kubelet/pods/74de3700-7676-4cd4-ab63-5aeb47c42237/volumes/kubernetes.io~projected/kube-api-access-n9bk9/..2026_01_11_07_59_10.3148764085/ca.crt: no space left on device
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# ls
 ArchitectureDiagram.png   CommandHistoryEKS-Statefulset.sh  'Session ScreenShots'      mongo-app.yml      mongo-express-webapp.yml   storageclass.yml   webapp-service.yml
 CommandHistory.sh         README.md                          create-db-user-job.yaml   mongo-config.yml   secret.yml                 vpa.yml
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# vi mongo-express-webapp.yml 
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl apply -f mongo-express-webapp.yml 
deployment.apps/webapp-deployment configured
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              0/1     ContainerCreating   0          4m16s
mongo-init-4npkn                     1/1     Running             0          4m16s
webapp-deployment-5ff9967b65-zdtvz   0/1     ContainerCreating   0          4s
webapp-deployment-69b6bb6b79-6r44h   1/1     Running             0          38m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              0/1     ContainerCreating   0          4m23s
mongo-init-4npkn                     1/1     Running             0          4m23s
webapp-deployment-5ff9967b65-zdtvz   0/1     ContainerCreating   0          11s
webapp-deployment-69b6bb6b79-6r44h   1/1     Running             0          38m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              0/1     ContainerCreating   0          4m25s
mongo-init-4npkn                     1/1     Running             0          4m25s
webapp-deployment-5ff9967b65-zdtvz   0/1     ContainerCreating   0          13s
webapp-deployment-69b6bb6b79-6r44h   1/1     Running             0          38m
[root@ip-172-31-47-93 K8s-MERN-App-Deployment]# kubectl describe pod webapp-deployment-5ff9967b65-zdtvz
Name:           webapp-deployment-5ff9967b65-zdtvz
Namespace:      default
Priority:       0
Node:           ip-192-168-9-74.ap-south-1.compute.internal/192.168.9.74
Start Time:     Sun, 11 Jan 2026 08:01:13 +0000
Labels:         app=webapp
                pod-template-hash=5ff9967b65
Annotations:    <none>
Status:         Pending
IP:             
IPs:            <none>
Controlled By:  ReplicaSet/webapp-deployment-5ff9967b65
Containers:
  webapp:
    Container ID:   
    Image:          mongo-express
    Image ID:       
    Port:           8081/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Limits:
      cpu:     20m
      memory:  20
    Requests:
      cpu:     10m
      memory:  10
    Environment:
      ME_CONFIG_MONGODB_ADMINUSERNAME:  <set to the key 'mongo-user' in secret 'mongo-secret'>      Optional: false
      ME_CONFIG_MONGODB_ADMINPASSWORD:  <set to the key 'mongo-password' in secret 'mongo-secret'>  Optional: false
      ME_CONFIG_MONGODB_SERVER:         <set to the key 'mongo-url' of config map 'mongo-config'>   Optional: false
      ME_CONFIG_MONGODB_PORT:           27017
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-dbbvr (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   False 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-dbbvr:
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
  Type     Reason       Age   From               Message
  ----     ------       ----  ----               -------
  Normal   Scheduled    25s   default-scheduler  Successfully assigned default/webapp-deployment-5ff9967b65-zdtvz to ip-192-168-9-74.ap-south-1.compute.internal
  Warning  FailedMount  26s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-dbbvr" : write /var/lib/kubelet/pods/0cba8742-0d4b-4edb-b92d-1fa85e7ecebd/volumes/kubernetes.io~projected/kube-api-access-dbbvr/..2026_01_11_08_01_13.1884367667/namespace: no space left on device
  Warning  FailedMount  25s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-dbbvr" : write /var/lib/kubelet/pods/0cba8742-0d4b-4edb-b92d-1fa85e7ecebd/volumes/kubernetes.io~projected/kube-api-access-dbbvr/..2026_01_11_08_01_14.3168556698/token: no space left on device
  Warning  FailedMount  24s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-dbbvr" : write /var/lib/kubelet/pods/0cba8742-0d4b-4edb-b92d-1fa85e7ecebd/volumes/kubernetes.io~projected/kube-api-access-dbbvr/..2026_01_11_08_01_15.1846778309/token: no space left on device
  Warning  FailedMount  22s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-dbbvr" : write /var/lib/kubelet/pods/0cba8742-0d4b-4edb-b92d-1fa85e7ecebd/volumes/kubernetes.io~projected/kube-api-access-dbbvr/..2026_01_11_08_01_17.1155254326/ca.crt: no space left on device
  Warning  FailedMount  18s   kubelet            MountVolume.SetUp failed for volume "kube-api-access-dbbvr" : write /var/lib/kubelet/pods/0cba8742-0d4b-4edb-b92d-1fa85e7ecebd/volumes/kubernetes.io~projected/kube-api-access-dbbvr/..2026_01_11_08_01_21.3570525006/ca.crt: no space left on device
  Warning  FailedMount  9s    kubelet            MountVolume.SetUp failed for volume "kube-api-access-dbbvr" : write /var/lib/kubelet/pods/0cba8742-0d4b-4edb-b92d-1fa85e7ecebd/volumes/kubernetes.io~projected/kube-api-access-dbbvr/..2026_01_11_08_01_30.1886480530/token: no space left on device
