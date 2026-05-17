Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
Waiting for mongo-0 to be reachable...
mongo-0 is reachable.
Waiting for mongo-1 to be reachable...
Waiting for mongo-1 to be reachable...
Waiting for mongo-1 to be reachable...
Waiting for mongo-1 to be reachable...
mongo-1 is reachable.
Waiting for mongo-2 to be reachable...
Waiting for mongo-2 to be reachable...
mongo-2 is reachable.
All MongoDB instances are reachable. Initializing replica set...
MongoDB shell version v5.0.33
connecting to: mongodb://mongo-0.mongo:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("92cbda97-ee71-4f9a-824a-feacfd366f08") }
MongoDB server version: 5.0.33
{ "ok" : 1 }
Replica set initialized. Adding other members (if not already added by initiate).
MongoDB shell version v5.0.33
connecting to: mongodb://mongo-0.mongo:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("55f8855d-5e82-4edd-a0d5-bd46c97e35b7") }
MongoDB server version: 5.0.33
{
        "topologyVersion" : {
                "processId" : ObjectId("6a096843d474c7f7b2f3c731"),
                "counter" : NumberLong(3)
        },
        "ok" : 0,
        "errmsg" : "New config is rejected :: caused by :: replSetReconfig should only be run on a writable PRIMARY. Current state SECONDARY;",
        "code" : 10107,
        "codeName" : "NotWritablePrimary",
        "$clusterTime" : {
                "clusterTime" : Timestamp(1779001449, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        },
        "operationTime" : Timestamp(1779001449, 1)
}
MongoDB shell version v5.0.33
connecting to: mongodb://mongo-0.mongo:27017/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("c00c2398-ff1a-4c3a-a21d-8e28bfd861d3") }
MongoDB server version: 5.0.33
{
        "topologyVersion" : {
                "processId" : ObjectId("6a096843d474c7f7b2f3c731"),
                "counter" : NumberLong(3)
        },
        "ok" : 0,
        "errmsg" : "New config is rejected :: caused by :: replSetReconfig should only be run on a writable PRIMARY. Current state SECONDARY;",
        "code" : 10107,
        "codeName" : "NotWritablePrimary",
        "$clusterTime" : {
                "clusterTime" : Timestamp(1779001449, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        },
        "operationTime" : Timestamp(1779001449, 1)
}
Checking replica set status for full readiness...
Replica set configuration complete and all members are healthy.
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                      READY   STATUS      RESTARTS   AGE
mongo-0                   1/1     Running     0          5m20s
mongo-1                   1/1     Running     0          5m17s
mongo-2                   1/1     Running     0          4m52s
mongo-create-user-jwwzj   0/1     Completed   0          2m53s
mongo-init-cpg5l          0/1     Completed   0          11m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl logs mongo-create-user-jwwzj
Waiting for primary mongo pod to be ready...
Primary pod reachable. Checking if user exists...
User does not exist. Creating admin user...
{
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1779001559, i: 4 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1779001559, i: 4 })
}
Admin user created.
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)     AGE
kubernetes   ClusterIP   10.100.0.1   <none>        443/TCP     61m
mongo        ClusterIP   None         <none>        27017/TCP   12m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pvc
NAME                               STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS        VOLUMEATTRIBUTESCLASS   AGE
mongo-persistent-storage-mongo-0   Bound    pvc-226ea8ff-b5cc-48f5-b0a5-c6914c021929   1Gi        RWO            ebs-storage-class   <unset>                 13m
mongo-persistent-storage-mongo-1   Bound    pvc-66748bdc-07aa-4fc0-8c22-cfd40ab6c338   1Gi        RWO            ebs-storage-class   <unset>                 7m35s
mongo-persistent-storage-mongo-2   Bound    pvc-55561c51-6991-458a-9516-65028ab458e9   1Gi        RWO            ebs-storage-class   <unset>                 7m10s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                      STORAGECLASS        VOLUMEATTRIBUTESCLASS   REASON   AGE
pvc-226ea8ff-b5cc-48f5-b0a5-c6914c021929   1Gi        RWO            Retain           Bound    default/mongo-persistent-storage-mongo-0   ebs-storage-class   <unset>                          13m
pvc-55561c51-6991-458a-9516-65028ab458e9   1Gi        RWO            Retain           Bound    default/mongo-persistent-storage-mongo-2   ebs-storage-class   <unset>                          7m11s
pvc-66748bdc-07aa-4fc0-8c22-cfd40ab6c338   1Gi        RWO            Retain           Bound    default/mongo-persistent-storage-mongo-1   ebs-storage-class   <unset>                          7m36s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl apply -f mongo-express-webapp.yml
deployment.apps/webapp-deployment created
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              1/1     Running             0          8m35s
mongo-1                              1/1     Running             0          8m32s
mongo-2                              1/1     Running             0          8m7s
mongo-create-user-jwwzj              0/1     Completed           0          6m8s
mongo-init-cpg5l                     0/1     Completed           0          14m
webapp-deployment-54955bcb9b-ldwrb   0/1     ContainerCreating   0          6s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl apply -f webapp-service.yml 
service/webapp-service created
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get svc
NAME             TYPE           CLUSTER-IP       EXTERNAL-IP                                                               PORT(S)          AGE
kubernetes       ClusterIP      10.100.0.1       <none>                                                                    443/TCP          67m
mongo            ClusterIP      None             <none>                                                                    27017/TCP        18m
webapp-service   LoadBalancer   10.100.176.226   ae787dfdc575e434ea552566ae283502-124813500.ap-south-1.elb.amazonaws.com   8081:31672/TCP   2m28s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          13m
mongo-1                              1/1     Running     0          13m
mongo-2                              1/1     Running     0          13m
mongo-create-user-jwwzj              0/1     Completed   0          11m
mongo-init-cpg5l                     0/1     Completed   0          19m
webapp-deployment-54955bcb9b-ldwrb   1/1     Running     0          5m6s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# 
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# 
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# 
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl exec -it mongo-0 bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@mongo-0:/# 
root@mongo-0:/# 
root@mongo-0:/# 
root@mongo-0:/# 
root@mongo-0:/# mongosh -u admin -p redhat
Current Mongosh Log ID: 6a096c0f4acae1e14e9df8a2
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.8.3
Using MongoDB:          5.0.33
Using Mongosh:          2.8.3

For mongosh info see: https://www.mongodb.com/docs/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2026-05-17T07:03:31.900+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
   2026-05-17T07:03:33.400+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2026-05-17T07:03:33.400+00:00: You are running this process as the root user, which is not recommended
------

rs0 [direct: primary] test> rs.status()
{
  set: 'rs0',
  date: ISODate('2026-05-17T07:19:54.797Z'),
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
    lastCommittedOpTime: { ts: Timestamp({ t: 1779002390, i: 1 }), t: Long('1') },
    lastCommittedWallTime: ISODate('2026-05-17T07:19:50.535Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1779002390, i: 1 }), t: Long('1') },
    appliedOpTime: { ts: Timestamp({ t: 1779002390, i: 1 }), t: Long('1') },
    durableOpTime: { ts: Timestamp({ t: 1779002390, i: 1 }), t: Long('1') },
    lastAppliedWallTime: ISODate('2026-05-17T07:19:50.535Z'),
    lastDurableWallTime: ISODate('2026-05-17T07:19:50.535Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1779002340, i: 1 }),
  electionCandidateMetrics: {
    lastElectionReason: 'electionTimeout',
    lastElectionDate: ISODate('2026-05-17T07:04:20.440Z'),
    electionTerm: Long('1'),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1779001449, i: 1 }), t: Long('-1') },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1779001449, i: 1 }), t: Long('-1') },
    numVotesNeeded: 2,
    priorityAtElection: 1,
    electionTimeoutMillis: Long('10000'),
    numCatchUpOps: Long('0'),
    newTermStartDate: ISODate('2026-05-17T07:04:20.491Z'),
    wMajorityWriteAvailabilityDate: ISODate('2026-05-17T07:04:21.671Z')
  },
  members: [
    {
      _id: 0,
      name: 'mongo-0.mongo:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 983,
      optime: { ts: Timestamp({ t: 1779002390, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2026-05-17T07:19:50.000Z'),
      lastAppliedWallTime: ISODate('2026-05-17T07:19:50.535Z'),
      lastDurableWallTime: ISODate('2026-05-17T07:19:50.535Z'),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1779001460, i: 1 }),
      electionDate: ISODate('2026-05-17T07:04:20.000Z'),
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
      uptime: 944,
      optime: { ts: Timestamp({ t: 1779002390, i: 1 }), t: Long('1') },
      optimeDurable: { ts: Timestamp({ t: 1779002390, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2026-05-17T07:19:50.000Z'),
      optimeDurableDate: ISODate('2026-05-17T07:19:50.000Z'),
      lastAppliedWallTime: ISODate('2026-05-17T07:19:50.535Z'),
      lastDurableWallTime: ISODate('2026-05-17T07:19:50.535Z'),
      lastHeartbeat: ISODate('2026-05-17T07:19:52.938Z'),
      lastHeartbeatRecv: ISODate('2026-05-17T07:19:54.440Z'),
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
      uptime: 944,
      optime: { ts: Timestamp({ t: 1779002390, i: 1 }), t: Long('1') },
      optimeDurable: { ts: Timestamp({ t: 1779002390, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2026-05-17T07:19:50.000Z'),
      optimeDurableDate: ISODate('2026-05-17T07:19:50.000Z'),
      lastAppliedWallTime: ISODate('2026-05-17T07:19:50.535Z'),
      lastDurableWallTime: ISODate('2026-05-17T07:19:50.535Z'),
      lastHeartbeat: ISODate('2026-05-17T07:19:54.470Z'),
      lastHeartbeatRecv: ISODate('2026-05-17T07:19:53.970Z'),
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
    clusterTime: Timestamp({ t: 1779002390, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1779002390, i: 1 })
}
rs0 [direct: primary] test> exit
root@mongo-0:/# exit
exit
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          20m
mongo-1                              1/1     Running     0          20m
mongo-2                              1/1     Running     0          19m
mongo-create-user-jwwzj              0/1     Completed   0          17m
mongo-init-cpg5l                     0/1     Completed   0          26m
webapp-deployment-54955bcb9b-ldwrb   1/1     Running     0          11m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl delete pod mongo-0
pod "mongo-0" deleted
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              0/1     ContainerCreating   0          4s
mongo-1                              1/1     Running             0          20m
mongo-2                              1/1     Running             0          20m
mongo-create-user-jwwzj              0/1     Completed           0          18m
mongo-init-cpg5l                     0/1     Completed           0          26m
webapp-deployment-54955bcb9b-ldwrb   1/1     Running             0          12m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          19s
mongo-1                              1/1     Running     0          21m
mongo-2                              1/1     Running     0          20m
mongo-create-user-jwwzj              0/1     Completed   0          18m
mongo-init-cpg5l                     0/1     Completed   0          27m
webapp-deployment-54955bcb9b-ldwrb   1/1     Running     0          12m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          22s
mongo-1                              1/1     Running     0          21m
mongo-2                              1/1     Running     0          20m
mongo-create-user-jwwzj              0/1     Completed   0          18m
mongo-init-cpg5l                     0/1     Completed   0          27m
webapp-deployment-54955bcb9b-ldwrb   1/1     Running     0          12m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl exec -it mongo-0 bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@mongo-0:/# mongosh -u admin -p redhat
Current Mongosh Log ID: 6a096d5c6e2191e3049df8a2
Connecting to:          mongodb://<credentials>@127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.8.3
Using MongoDB:          5.0.33
Using Mongosh:          2.8.3

For mongosh info see: https://www.mongodb.com/docs/mongodb-shell/

------
   The server generated these startup warnings when booting
   2026-05-17T07:24:27.798+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
   2026-05-17T07:24:29.314+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2026-05-17T07:24:29.314+00:00: You are running this process as the root user, which is not recommended
------

rs0 [direct: secondary] test> rs.status()
{
  set: 'rs0',
  date: ISODate('2026-05-17T07:25:19.168Z'),
  myState: 2,
  term: Long('2'),
  syncSourceHost: 'mongo-2.mongo:27017',
  syncSourceId: 2,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 3,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1779002717, i: 1 }), t: Long('2') },
    lastCommittedWallTime: ISODate('2026-05-17T07:25:17.410Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1779002717, i: 1 }), t: Long('2') },
    appliedOpTime: { ts: Timestamp({ t: 1779002717, i: 1 }), t: Long('2') },
    durableOpTime: { ts: Timestamp({ t: 1779002717, i: 1 }), t: Long('2') },
    lastAppliedWallTime: ISODate('2026-05-17T07:25:17.410Z'),
    lastDurableWallTime: ISODate('2026-05-17T07:25:17.410Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1779002657, i: 1 }),
  members: [
    {
      _id: 0,
      name: 'mongo-0.mongo:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 52,
      optime: { ts: Timestamp({ t: 1779002717, i: 1 }), t: Long('2') },
      optimeDate: ISODate('2026-05-17T07:25:17.000Z'),
      lastAppliedWallTime: ISODate('2026-05-17T07:25:17.410Z'),
      lastDurableWallTime: ISODate('2026-05-17T07:25:17.410Z'),
      syncSourceHost: 'mongo-2.mongo:27017',
      syncSourceId: 2,
      infoMessage: '',
      configVersion: 1,
      configTerm: 2,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 1,
      name: 'mongo-1.mongo:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 45,
      optime: { ts: Timestamp({ t: 1779002717, i: 1 }), t: Long('2') },
      optimeDurable: { ts: Timestamp({ t: 1779002717, i: 1 }), t: Long('2') },
      optimeDate: ISODate('2026-05-17T07:25:17.000Z'),
      optimeDurableDate: ISODate('2026-05-17T07:25:17.000Z'),
      lastAppliedWallTime: ISODate('2026-05-17T07:25:17.410Z'),
      lastDurableWallTime: ISODate('2026-05-17T07:25:17.410Z'),
      lastHeartbeat: ISODate('2026-05-17T07:25:18.972Z'),
      lastHeartbeatRecv: ISODate('2026-05-17T07:25:17.458Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1779002647, i: 1 }),
      electionDate: ISODate('2026-05-17T07:24:07.000Z'),
      configVersion: 1,
      configTerm: 2
    },
    {
      _id: 2,
      name: 'mongo-2.mongo:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 45,
      optime: { ts: Timestamp({ t: 1779002717, i: 1 }), t: Long('2') },
      optimeDurable: { ts: Timestamp({ t: 1779002717, i: 1 }), t: Long('2') },
      optimeDate: ISODate('2026-05-17T07:25:17.000Z'),
      optimeDurableDate: ISODate('2026-05-17T07:25:17.000Z'),
      lastAppliedWallTime: ISODate('2026-05-17T07:25:17.410Z'),
      lastDurableWallTime: ISODate('2026-05-17T07:25:17.410Z'),
      lastHeartbeat: ISODate('2026-05-17T07:25:18.966Z'),
      lastHeartbeatRecv: ISODate('2026-05-17T07:25:18.571Z'),
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
    clusterTime: Timestamp({ t: 1779002717, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('AAAAAAAAAAAAAAAAAAAAAAAAAAA=', 0),
      keyId: Long('0')
    }
  },
  operationTime: Timestamp({ t: 1779002717, i: 1 })
}
rs0 [direct: secondary] test> exit
root@mongo-0:/# exit
exit
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# vi secret.yml 
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
kubeNAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          7m20s
mongo-1                              1/1     Running     0          28m
mongo-2                              1/1     Running     0          27m
mongo-create-user-jwwzj              0/1     Completed   0          25m
mongo-init-cpg5l                     0/1     Completed   0          34m
webapp-deployment-54955bcb9b-ldwrb   1/1     Running     0          19m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get deployment
NAME                READY   UP-TO-DATE   AVAILABLE   AGE
webapp-deployment   1/1     1            1           19m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl scale deployment webapp-deployment --replicas 3
deployment.apps/webapp-deployment scaled
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS              RESTARTS   AGE
mongo-0                              1/1     Running             0          7m46s
mongo-1                              1/1     Running             0          28m
mongo-2                              1/1     Running             0          28m
mongo-create-user-jwwzj              0/1     Completed           0          26m
mongo-init-cpg5l                     0/1     Completed           0          34m
webapp-deployment-54955bcb9b-4phjw   0/1     ContainerCreating   0          5s
webapp-deployment-54955bcb9b-fsh5g   1/1     Running             0          5s
webapp-deployment-54955bcb9b-ldwrb   1/1     Running             0          20m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl top pods
NAME                                 CPU(cores)   MEMORY(bytes)   
mongo-0                              9m           178Mi           
mongo-1                              10m          80Mi            
mongo-2                              9m           81Mi            
webapp-deployment-54955bcb9b-4phjw   111m         57Mi            
webapp-deployment-54955bcb9b-fsh5g   91m          56Mi            
webapp-deployment-54955bcb9b-ldwrb   1m           50Mi            
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl apply -f hpa.yaml 
horizontalpodautoscaler.autoscaling/my-expressapp-hpa created
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS                 MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: <unknown>/95%   1         10        0          5s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS           MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 43%/95%   1         10        3          46s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods -n kube-system
NAME                                  READY   STATUS    RESTARTS   AGE
aws-node-2954k                        2/2     Running   0          69m
aws-node-mzvvq                        2/2     Running   0          69m
coredns-66cff8d9f9-6kj7h              1/1     Running   0          86m
coredns-66cff8d9f9-p6ksr              1/1     Running   0          86m
ebs-csi-controller-86d756687f-dwgbs   6/6     Running   0          50m
ebs-csi-controller-86d756687f-ffdzf   6/6     Running   0          50m
ebs-csi-node-b9lsx                    3/3     Running   0          50m
ebs-csi-node-fm94m                    3/3     Running   0          50m
kube-proxy-4ptpw                      1/1     Running   0          69m
kube-proxy-ddk7j                      1/1     Running   0          69m
metrics-server-85769fc6bd-hpfr8       1/1     Running   0          84m
metrics-server-85769fc6bd-sw4t5       1/1     Running   0          84m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS           MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 43%/95%   1         10        3          110s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          14m
mongo-1                              1/1     Running     0          35m
mongo-2                              1/1     Running     0          34m
mongo-create-user-jwwzj              0/1     Completed   0          32m
mongo-init-cpg5l                     0/1     Completed   0          41m
webapp-deployment-54955bcb9b-4phjw   1/1     Running     0          6m34s
webapp-deployment-54955bcb9b-fsh5g   1/1     Running     0          6m34s
webapp-deployment-54955bcb9b-ldwrb   1/1     Running     0          26m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          14m
mongo-1                              1/1     Running     0          35m
mongo-2                              1/1     Running     0          35m
mongo-create-user-jwwzj              0/1     Completed   0          33m
mongo-init-cpg5l                     0/1     Completed   0          41m
webapp-deployment-54955bcb9b-4phjw   1/1     Running     0          7m7s
webapp-deployment-54955bcb9b-fsh5g   1/1     Running     0          7m7s
webapp-deployment-54955bcb9b-ldwrb   1/1     Running     0          27m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# vi mongo-express-webapp.yml 
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl apply -f mongo-express-webapp.yml 
deployment.apps/webapp-deployment configured
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl top pods
NAME      CPU(cores)   MEMORY(bytes)   
mongo-0   9m           175Mi           
mongo-1   8m           81Mi            
mongo-2   10m          83Mi            
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          16m
mongo-1                              1/1     Running     0          36m
mongo-2                              1/1     Running     0          36m
mongo-create-user-jwwzj              0/1     Completed   0          34m
mongo-init-cpg5l                     0/1     Completed   0          42m
webapp-deployment-675b7cb98b-mb797   1/1     Running     0          16s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          16m
mongo-1                              1/1     Running     0          36m
mongo-2                              1/1     Running     0          36m
mongo-create-user-jwwzj              0/1     Completed   0          34m
mongo-init-cpg5l                     0/1     Completed   0          43m
webapp-deployment-675b7cb98b-mb797   1/1     Running     0          20s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl top pods
NAME                                 CPU(cores)   MEMORY(bytes)   
mongo-0                              9m           175Mi           
mongo-1                              9m           81Mi            
mongo-2                              9m           82Mi            
webapp-deployment-675b7cb98b-mb797   128m         55Mi            
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# cat mongo-express-webapp.yml 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp-deployment
  labels:
    app: webapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
      - name: webapp
        image: mongo-express
        resources:
          requests:
            memory: "20Mi"
            cpu: 150m
          limits:
            memory: "200Mi"
            cpu: 300m
        ports:
          - containerPort: 8081
        env:
        - name: ME_CONFIG_MONGODB_URL
          valueFrom:
            secretKeyRef:
              name: mongo-secret
              key: mongo-url 
        - name: ME_CONFIG_MONGODB_PORT
          value: "27017"
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# 
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# 
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS            MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 279%/95%   1         10        3          4m49s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          17m
mongo-1                              1/1     Running     0          38m
mongo-2                              1/1     Running     0          37m
mongo-create-user-jwwzj              0/1     Completed   0          35m
mongo-init-cpg5l                     0/1     Completed   0          44m
webapp-deployment-675b7cb98b-6crj9   1/1     Running     0          25s
webapp-deployment-675b7cb98b-749jq   1/1     Running     0          40s
webapp-deployment-675b7cb98b-992m7   1/1     Running     0          40s
webapp-deployment-675b7cb98b-9vknw   1/1     Running     0          25s
webapp-deployment-675b7cb98b-bh29h   1/1     Running     0          40s
webapp-deployment-675b7cb98b-crxbp   1/1     Running     0          70s
webapp-deployment-675b7cb98b-mb797   1/1     Running     0          95s
webapp-deployment-675b7cb98b-ppnl5   1/1     Running     0          10s
webapp-deployment-675b7cb98b-sjvhz   1/1     Running     0          70s
webapp-deployment-675b7cb98b-wjcld   1/1     Running     0          25s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          17m
mongo-1                              1/1     Running     0          38m
mongo-2                              1/1     Running     0          38m
mongo-create-user-jwwzj              0/1     Completed   0          36m
mongo-init-cpg5l                     0/1     Completed   0          44m
webapp-deployment-675b7cb98b-6crj9   1/1     Running     0          58s
webapp-deployment-675b7cb98b-749jq   1/1     Running     0          73s
webapp-deployment-675b7cb98b-992m7   1/1     Running     0          73s
webapp-deployment-675b7cb98b-9vknw   1/1     Running     0          58s
webapp-deployment-675b7cb98b-bh29h   1/1     Running     0          73s
webapp-deployment-675b7cb98b-crxbp   1/1     Running     0          103s
webapp-deployment-675b7cb98b-mb797   1/1     Running     0          2m8s
webapp-deployment-675b7cb98b-ppnl5   1/1     Running     0          43s
webapp-deployment-675b7cb98b-sjvhz   1/1     Running     0          103s
webapp-deployment-675b7cb98b-wjcld   1/1     Running     0          58s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS            MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 274%/95%   1         10        10         6m7s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# vi mongo-express-webapp.yml 
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl apply -f mongo-express-webapp.yml 
deployment.apps/webapp-deployment configured
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS            MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 198%/95%   1         10        1          7m1s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS            MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 198%/95%   1         10        1          7m3s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl top pods
NAME      CPU(cores)   MEMORY(bytes)   
mongo-0   9m           174Mi           
mongo-1   10m          84Mi            
mongo-2   10m          83Mi            
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl top pods
NAME      CPU(cores)   MEMORY(bytes)   
mongo-0   9m           174Mi           
mongo-1   10m          84Mi            
mongo-2   10m          83Mi            
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl top pods
NAME                                 CPU(cores)   MEMORY(bytes)   
mongo-0                              10m          173Mi           
mongo-1                              11m          84Mi            
mongo-2                              9m           83Mi            
webapp-deployment-65cf87d5bf-4js44   76m          56Mi            
webapp-deployment-65cf87d5bf-5vp5g   130m         55Mi            
webapp-deployment-65cf87d5bf-pzbqf   47m          55Mi            
webapp-deployment-65cf87d5bf-qzpgq   109m         56Mi            
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS           MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 93%/95%   1         10        4          7m41s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          19m
mongo-1                              1/1     Running     0          40m
mongo-2                              1/1     Running     0          40m
mongo-create-user-jwwzj              0/1     Completed   0          38m
mongo-init-cpg5l                     0/1     Completed   0          46m
webapp-deployment-65cf87d5bf-46v2z   1/1     Running     0          4s
webapp-deployment-65cf87d5bf-4js44   1/1     Running     0          47s
webapp-deployment-65cf87d5bf-5vp5g   1/1     Running     0          52s
webapp-deployment-65cf87d5bf-bzkxl   1/1     Running     0          19s
webapp-deployment-65cf87d5bf-cfwbj   1/1     Running     0          19s
webapp-deployment-65cf87d5bf-dxj8h   1/1     Running     0          19s
webapp-deployment-65cf87d5bf-jqn9s   1/1     Running     0          4s
webapp-deployment-65cf87d5bf-pzbqf   1/1     Running     0          50s
webapp-deployment-65cf87d5bf-qzpgq   1/1     Running     0          49s
webapp-deployment-65cf87d5bf-r66kf   1/1     Running     0          19s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get vpa
error: the server doesn't have a resource type "vpa"
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# git clone https://github.com/kubernetes/autoscaler.git
Cloning into 'autoscaler'...
remote: Enumerating objects: 243037, done.
remote: Counting objects: 100% (1581/1581), done.
remote: Compressing objects: 100% (1123/1123), done.
remote: Total 243037 (delta 997), reused 460 (delta 458), pack-reused 241456 (from 2)
Receiving objects: 100% (243037/243037), 259.56 MiB | 17.00 MiB/s, done.
Resolving deltas: 100% (158434/158434), done.
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# cd autoscaler/vertical-pod-autoscaler/hack/
[root@ip-172-31-45-62 hack]# ./vpa-up.sh 
HEAD is now at 9196162ba Update VPA default version to 1.6.0
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
[root@ip-172-31-45-62 hack]# cd /K8s-MERN-App-Deployment/
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl apply -f vpa.yml 
verticalpodautoscaler.autoscaling.k8s.io/mongo-statefulset-vpa created
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get vpa
NAME                    MODE       CPU   MEM   PROVIDED   AGE
mongo-statefulset-vpa   Recreate                          5s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          29m
mongo-1                              1/1     Running     0          50m
mongo-2                              1/1     Running     0          50m
mongo-create-user-jwwzj              0/1     Completed   0          48m
mongo-init-cpg5l                     0/1     Completed   0          56m
webapp-deployment-65cf87d5bf-46v2z   1/1     Running     0          9m54s
webapp-deployment-65cf87d5bf-4js44   1/1     Running     0          10m
webapp-deployment-65cf87d5bf-5vp5g   1/1     Running     0          10m
webapp-deployment-65cf87d5bf-bzkxl   1/1     Running     0          10m
webapp-deployment-65cf87d5bf-cfwbj   1/1     Running     0          10m
webapp-deployment-65cf87d5bf-dxj8h   1/1     Running     0          10m
webapp-deployment-65cf87d5bf-jqn9s   1/1     Running     0          9m54s
webapp-deployment-65cf87d5bf-qzpgq   1/1     Running     0          10m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get vpa
NAME                    MODE       CPU   MEM     PROVIDED   AGE
mongo-statefulset-vpa   Recreate   25m   250Mi   True       89s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl top pods
NAME                                 CPU(cores)   MEMORY(bytes)   
mongo-0                              9m           175Mi           
mongo-1                              9m           85Mi            
mongo-2                              10m          84Mi            
webapp-deployment-65cf87d5bf-46v2z   1m           40Mi            
webapp-deployment-65cf87d5bf-4js44   1m           40Mi            
webapp-deployment-65cf87d5bf-5vp5g   1m           40Mi            
webapp-deployment-65cf87d5bf-bzkxl   1m           39Mi            
webapp-deployment-65cf87d5bf-cfwbj   1m           40Mi            
webapp-deployment-65cf87d5bf-dxj8h   1m           40Mi            
webapp-deployment-65cf87d5bf-jqn9s   1m           39Mi            
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get hpa
NAME                REFERENCE                      TARGETS           MINPODS   MAXPODS   REPLICAS   AGE
my-expressapp-hpa   Deployment/webapp-deployment   memory: 66%/95%   1         10        6          20m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get vpa
NAME                    MODE       CPU   MEM     PROVIDED   AGE
mongo-statefulset-vpa   Recreate   25m   250Mi   True       2m58s
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl describe vpa
Name:         mongo-statefulset-vpa
Namespace:    default
Labels:       <none>
Annotations:  <none>
API Version:  autoscaling.k8s.io/v1
Kind:         VerticalPodAutoscaler
Metadata:
  Creation Timestamp:  2026-05-17T07:53:42Z
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
    Time:         2026-05-17T07:53:42Z
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
    Time:            2026-05-17T07:56:41Z
  Resource Version:  22156
  UID:               1f404078-712d-4adf-8c33-aec01562ab34
Spec:
  Target Ref:
    API Version:  apps/v1
    Kind:         StatefulSet
    Name:         mongo
  Update Policy:
    Update Mode:  Recreate
Status:
  Conditions:
    Last Transition Time:  2026-05-17T07:54:41Z
    Status:                True
    Type:                  RecommendationProvided
  Recommendation:
    Container Recommendations:
      Container Name:  mongo
      Lower Bound:
        Cpu:     25m
        Memory:  250Mi
      Target:
        Cpu:     25m
        Memory:  250Mi
      Uncapped Target:
        Cpu:     25m
        Memory:  250Mi
      Upper Bound:
        Cpu:     10764m
        Memory:  105485927954
Events:          <none>
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          33m
mongo-1                              1/1     Running     0          53m
mongo-2                              1/1     Running     0          53m
mongo-create-user-jwwzj              0/1     Completed   0          51m
mongo-init-cpg5l                     0/1     Completed   0          60m
webapp-deployment-65cf87d5bf-4js44   1/1     Running     0          14m
webapp-deployment-65cf87d5bf-5vp5g   1/1     Running     0          14m
webapp-deployment-65cf87d5bf-bzkxl   1/1     Running     0          13m
webapp-deployment-65cf87d5bf-cfwbj   1/1     Running     0          13m
webapp-deployment-65cf87d5bf-dxj8h   1/1     Running     0          13m
webapp-deployment-65cf87d5bf-jqn9s   1/1     Running     0          13m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          43m
mongo-1                              1/1     Running     0          64m
mongo-2                              1/1     Running     0          64m
mongo-create-user-jwwzj              0/1     Completed   0          62m
mongo-init-cpg5l                     0/1     Completed   0          70m
webapp-deployment-65cf87d5bf-4js44   1/1     Running     0          24m
webapp-deployment-65cf87d5bf-5vp5g   1/1     Running     0          24m
webapp-deployment-65cf87d5bf-bzkxl   1/1     Running     0          24m
webapp-deployment-65cf87d5bf-dxj8h   1/1     Running     0          24m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
mongo-0                              1/1     Running     0          47m
mongo-1                              1/1     Running     0          67m
mongo-2                              1/1     Running     0          67m
mongo-create-user-jwwzj              0/1     Completed   0          65m
mongo-init-cpg5l                     0/1     Completed   0          74m
webapp-deployment-65cf87d5bf-4js44   1/1     Running     0          28m
webapp-deployment-65cf87d5bf-5vp5g   1/1     Running     0          28m
webapp-deployment-65cf87d5bf-bzkxl   1/1     Running     0          27m
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# history
    1  cd /
    2  aws configure 
    3  clear
    4  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    5  sudo mv /tmp/eksctl /usr/local/bin
    6  eksctl version
    7  curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
    8  chmod +x ./kubectl
    9  sudo mv ./kubectl /usr/local/bin
   10  kubectl version --short --client
   11  eksctl create cluster --name=EKS-17                       --region=ap-south-1                       --zones=ap-south-1a,ap-south-1b                       --without-nodegroup
   12  eksctl utils associate-iam-oidc-provider     --region ap-south-1     --cluster EKS-17     --approve
   13  eksctl create nodegroup --cluster=EKS-17                       --region=ap-south-1                       --name=node2                       --node-type=t3.medium                       --nodes=2                       --nodes-min=2                       --nodes-max=2                       --node-volume-size=20                       --ssh-access                       --ssh-public-key=DevOps                       --managed                       --asg-access                       --external-dns-access                       --full-ecr-access                       --appmesh-access                       --alb-ingress-access
   14  yum install git -y
   15  git clone https://github.com/sudhanshuvlog/K8s-MERN-App-Deployment.git
   16  cd K8s-MERN-App-Deployment/
   17  ls
   18  kubectl -n kube-system describe configmap aws-auth
   19  kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.4"
   20  kubectl get pods
   21  kubectl get namespace
   22  kubectl get pod -n default
   23  kubectl get pod -n kube-system
   24  kubectl get pod -n kube-public
   25  kubectl apply -f secret.yml 
   26  kubectl describe secret
   27  kubectl apply -f storageclass.yml 
   28  kubectl get storageclass
   29  kubectl get pv
   30  kubectl get pvc
   31  kubectl apply -f mongo-app.yml 
   32  kubectl get pods
   33  kubectl get pods
   34  kubectl get pvc
   35  kubectl get pv
   36  kubectl get pod
   37  kubectl get statefulset
   38  kubectl describe pod mongo-0
   39  kubectl get nodes
   40  vi mongo-app.yml 
   41  kubectl apply -f mongo-app.yml 
   42  kubectl get pods
   43  kubectl delete pod mongo-0
   44  kubectl get pods
   45  kubectl get pods
   46  kubectl get pods
   47  kubectl get pods
   48  kubectl apply -f create-db-user-job.yaml 
   49  kubectl get pods
   50  kubectl get pods
   51  kubectl logs mongo-init-cpg5l
   52  kubectl get pods
   53  kubectl logs mongo-create-user-jwwzj
   54  kubectl get svc
   55  kubectl get pvc
   56  kubectl get pv
   57  kubectl apply -f mongo-express-webapp.yml
   58  kubectl get pods
   59  kubectl apply -f webapp-service.yml 
   60  kubectl get svc
   61  kubectl get pods
   62  kubectl exec -it mongo-0 bash
   63  kubectl get pods
   64  kubectl delete pod mongo-0
   65  kubectl get pods
   66  kubectl get pods
   67  kubectl get pods
   68  kubectl exec -it mongo-0 bash
   69  vi secret.yml 
   70  kubectl get pods
   71  kubectl get deployment
   72  kubectl scale deployment webapp-deployment --replicas 3
   73  kubectl get pods
   74  kubectl top pods
   75  kubectl apply -f hpa.yaml 
   76  kubectl get hpa
   77  kubectl get hpa
   78  kubectl get pods -n kube-system
   79  kubectl get hpa
   80  kubectl get pods
   81  kubectl get pods
   82  vi mongo-express-webapp.yml 
   83  kubectl apply -f mongo-express-webapp.yml 
   84  kubectl top pods
   85  kubectl get pods
   86  kubectl get pods
   87  kubectl top pods
   88  cat mongo-express-webapp.yml 
   89  kubectl get hpa
   90  kubectl get pods
   91  kubectl get pods
   92  kubectl get hpa
   93  vi mongo-express-webapp.yml 
   94  kubectl apply -f mongo-express-webapp.yml 
   95  kubectl get hpa
   96  kubectl get hpa
   97  kubectl top pods
   98  kubectl top pods
   99  kubectl top pods
  100  kubectl get hpa
  101  kubectl get pods
  102  kubectl get vpa
  103  git clone https://github.com/kubernetes/autoscaler.git
  104  cd autoscaler/vertical-pod-autoscaler/hack/
  105  ./vpa-up.sh 
  106  cd /K8s-MERN-App-Deployment/
  107  kubectl apply -f vpa.yml 
  108  kubectl get vpa
  109  kubectl get pods
  110  kubectl get vpa
  111  kubectl top pods
  112  kubectl get hpa
  113  kubectl get vpa
  114  kubectl describe vpa
  115  kubectl get pods
  116  kubectl get pods
  117  kubectl get pods
  118  history
[root@ip-172-31-45-62 K8s-MERN-App-Deployment]# eksctl delete cluster --name EKS-17 --region ap-south-1