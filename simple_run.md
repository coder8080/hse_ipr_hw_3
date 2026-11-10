**Application**
```bash
$ docker build -t hse . && docker run --name hse --rm -p 8080:8000 -e GREETING='Custom Greeting' hse
[+] Building 0.5s (9/9) FINISHED                                                                                                docker:default
 => [internal] load build definition from Dockerfile                                                                                      0.0s
 => => transferring dockerfile: 318B                                                                                                      0.0s
 => [internal] load metadata for docker.io/library/python:3.15.2-slim-trixie@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e  0.1s
 => [internal] load .dockerignore                                                                                                         0.0s
 => => transferring context: 2B                                                                                                           0.0s
 => [1/4] FROM docker.io/library/python:3.15.2-slim-trixie@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928        0.1s
 => => resolve docker.io/library/python:3.15.2-slim-trixie@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928        0.0s
 => [internal] load build context                                                                                                         0.0s
 => => transferring context: 127B                                                                                                         0.0s
 => CACHED [2/4] WORKDIR /app                                                                                                             0.0s
 => CACHED [3/4] COPY app/* .                                                                                                             0.0s
 => CACHED [4/4] RUN /usr/local/bin/pip install -r /app/requirements.txt                                                                  0.0s
 => exporting to image                                                                                                                    0.2s
 => => exporting layers                                                                                                                   0.0s
 => => exporting manifest sha256:a604420f83a6fe1429763539b0d7145161f1a89aa226101622f8694b988203b3                                         0.0s
 => => exporting config sha256:25bde371b6746e7b36db692a7961f9810f24b1182047dce4b75c6acc3478c0e4                                           0.0s
 => => exporting attestation manifest sha256:1b14d1ae5a3a34c8ba0670caf15e08d348bf8f5005bbe563d86a85a4de3e3736                             0.0s
 => => exporting manifest list sha256:d77532f980faf011bc6ae31f21ec3252b9e5dff6e04c68637689ebd2aff56b22                                    0.0s
 => => naming to docker.io/library/hse:latest                                                                                             0.0s
 => => unpacking to docker.io/library/hse:latest                                                                                          0.0s
2026-11-10 07:33:07,531 listening port=8000 storage=sqlite
2026-11-10 07:33:10,738 http 172.17.0.1 "GET / HTTP/1.1" 200 -
2026-11-10 07:33:15,447 http 172.17.0.1 "POST /increment HTTP/1.1" 200 -
2026-11-10 07:33:19,733 http 172.17.0.1 "GET /readyz HTTP/1.1" 200 -
```

**Checks**
```bash
$ curl -fsS http://127.0.0.1:8080/
{"greeting": "Custom Greeting", "count": 0, "hostname": "f09b9d14146d", "storage": "sqlite"}%
```

```bash
$ curl -fsS -X POST http://127.0.0.1:8080/increment
{"greeting": "Custom Greeting", "count": 1, "hostname": "f09b9d14146d", "storage": "sqlite"}%
```

```bash
$ curl -fsS http://127.0.0.1:8080/readyz
{"status": "ready", "storage": "sqlite"}%
```
