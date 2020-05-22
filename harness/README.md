Note: This is work in progress.

Usage:
1. Update hq/scripts/setenv.sh with your ACCOUNT_ID and API_KEY. 
2. Update HQ_HOME to the location where hq is cloned
3. source setenv.sh 

How to Test

$ hq 

Usage: hq <module/query.hql> VAR1 VAR2 VAR3...

# Example 1 - Get Application Id
```
$ hq id/App.hql MyApp
WHlkfu9VS1uXDj-kyucJuQ
```
# Example 2 - List Apps
```
$ hq list/Apps.hql 2 | jq  .
{
  "data": {
    "applications": {
      "nodes": [
        {
          "id": "4KFbkqNyQcmAvQASSjqIkw",
          "name": "123Test"
        },
        {
          "id": "iLmllOuFQo6Feyhw9jT-9g",
          "name": "Demo Sample App"
        }
      ]
    }
  }
}
```
# Example 3 - Using scripts
```
$ hq/scripts/getCP.sh | jq .
{
  "data": {
    "cloudProviders": {
      "nodes": [
        {
          "name": "Harness Sample K8s Cloud Provider",
          "id": "Z_2b4geyRReu6VUqZmIv3Q"
        },
        {
          "name": "k3s-cluster-venkat",
          "id": "mMurjz-dRLCz-9wlRU4NQg"
        }
      ]
    }
  }
}
```

