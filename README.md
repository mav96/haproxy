# haproxy
Testing haproxy


```
docker build . -f Dockerfile_haproxy -t ha_proxy
```

```
docker build . -f Dockerfile_app -t ha_app
```


```
docker stack deploy -c docker-compose.yml ha
```


```
curl "http://127.0.0.1:8080" -H "Host: test"
```
