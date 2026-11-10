**Application startup**

```bash
docker compose up --build -d
[+] up 7/8
 ⠴ Image valkey/valkey:9.1.3-trixie@sha256:3add1a336a920ea54770a001ab6feb3da5fceea96a40373a3a2cd469b815f0b7 [⣿⣿⣿⣿⣿⣿⣿] Pulling              3.6s
[+] Building 13.9s (13/13) FINISHED
 => [internal] load local bake definitions                                                                                                0.0s
 => => reading from stdin 516B                                                                                                            0.0s
 => [internal] load build definition from Dockerfile                                                                                      0.0s
 => => transferring dockerfile: 479B                                                                                                      0.0s
 => [internal] load metadata for docker.io/library/python:3.15.2-slim-trixie@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e  0.9s
 => [internal] load .dockerignore                                                                                                         0.0s
 => => transferring context: 2B                                                                                                           0.0s
 => [1/6] FROM docker.io/library/python:3.15.2-slim-trixie@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928        2.8s
 => => resolve docker.io/library/python:3.15.2-slim-trixie@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928        0.1s
 => => sha256:f01b8d07ba2aedfee532b6ef060890497b36bfbf331936d61b1ec8daca364716 249B / 249B                                                0.1s
 => => sha256:ba56bf6127ad2b67230d545572f827a2f23ad144cf9956ff1358115f2c2b74f5 13.16MB / 13.16MB                                          0.3s
 => => sha256:490d435ea3632a742a946aeca973fe266efc4478e415ba8ce4f47b7f33844ebe 1.29MB / 1.29MB                                            0.3s
 => => sha256:37fb86c2a767b88d500c6872195f88078f64765fe0d2f9cc375cc2efbd4c0a41 29.86MB / 29.86MB                                          0.4s
 => => extracting sha256:37fb86c2a767b88d500c6872195f88078f64765fe0d2f9cc375cc2efbd4c0a41                                                 0.7s
 => => extracting sha256:490d435ea3632a742a946aeca973fe266efc4478e415ba8ce4f47b7f33844ebe                                                 0.4s
 => => extracting sha256:ba56bf6127ad2b67230d545572f827a2f23ad144cf9956ff1358115f2c2b74f5                                                 0.8s
 => => extracting sha256:f01b8d07ba2aedfee532b6ef060890497b36bfbf331936d61b1ec8daca364716                                                 0.1s
 => [internal] load build context                                                                                                         0.1s
 => => transferring context: 8.87kB                                                                                                       0.0s
 => [2/6] RUN apt-get update && apt-get install --no-install-recommends -y curl && rm -rf /var/lib/apt/lists/*                            5.4s
 => [3/6] WORKDIR /app                                                                                                                    0.1s
 => [4/6] COPY app/requirements.txt .                                                                                                     0.1s
 => [5/6] RUN /usr/local/bin/pip install -r /app/requirements.txt                                                                         2.5s
 => [6/6] COPY app/* .                                                                                                                    0.1s
 => exporting to image                                                                                                                    1.7s
 => => exporting layers                                                                                                                   0.8s
 => => exporting manifest sha256:74835214a4a51a126647e87f06c3cb103b5c3d08b54b3f70d6a7310c76aff2ee                                         0.0s
 => => exporting config sha256:09a5cc653dc580c76ee30dc067c35f06fbdf5c2432e0dd409b0467e10c2a5475                                           0.0s
 => => exporting attestation manifest sha256:170b55a206d1e02e45e292df0dd6860398a9a42462ba97a6f3e072d7cf12d438                             0.0s
 => => exporting manifest list sha256:7748cdd0bee6b7e912ce551d32420ec31b74ef95752c510214993c00870b351f                                    0.0s
 => => naming to docker.io/library/hse_ipr_hw_3-app:latest                                                                                0.0s
[+] up 13/13king to docker.io/library/hse_ipr_hw_3-app:latest                                                                             0.7s
 ✔ Image valkey/valkey:9.1.3-trixie@sha256:3add1a336a920ea54770a001ab6feb3da5fceea96a40373a3a2cd469b815f0b7 Pulled                         3.6s
 ✔ Image hse_ipr_hw_3-app                                                                                   Built                         14.0s
 ✔ Network hse_ipr_hw_3_default                                                                             Created                        0.0s
 ✔ Volume hse_ipr_hw_3_hse_redis                                                                            Created                        0.0s
 ✔ Container hse_redis                                                                                      Healthy                        5.9s
 ✔ Container hse_counter                                                                                    Started
```

**Checks**

```bash
$ curl -fsS -X POST http://localhost:8081/increment
{"greeting": "Custom env greeting", "count": 1, "hostname": "3168da587b4c", "storage": "redis"}
$ curl -fsS -X POST http://localhost:8081/increment
{"greeting": "Custom env greeting", "count": 2, "hostname": "3168da587b4c", "storage": "redis"}
$ curl -fsS -X POST http://localhost:8081/increment
{"greeting": "Custom env greeting", "count": 3, "hostname": "3168da587b4c", "storage": "redis"}
$ docker compose down
[+] down 3/3
 ✔ Container hse_counter        Removed                                                                                                   10.3s
 ✔ Container hse_redis          Removed                                                                                                    0.2s
 ✔ Network hse_ipr_hw_3_default Removed                                                                                                    0.1s
$ docker compose up --build -d
[+] Building 0.5s (13/13) FINISHED
 => [internal] load local bake definitions                                                                                                0.0s
 => => reading from stdin 516B                                                                                                            0.0s
 => [internal] load build definition from Dockerfile                                                                                      0.0s
 => => transferring dockerfile: 479B                                                                                                      0.0s
 => [internal] load metadata for docker.io/library/python:3.15.2-slim-trixie@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e  0.1s
 => [internal] load .dockerignore                                                                                                         0.0s
 => => transferring context: 2B                                                                                                           0.0s
 => [1/6] FROM docker.io/library/python:3.15.2-slim-trixie@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928        0.1s
 => => resolve docker.io/library/python:3.15.2-slim-trixie@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928        0.0s
 => [internal] load build context                                                                                                         0.0s
 => => transferring context: 127B                                                                                                         0.0s
 => CACHED [2/6] RUN apt-get update && apt-get install --no-install-recommends -y curl && rm -rf /var/lib/apt/lists/*                     0.0s
 => CACHED [3/6] WORKDIR /app                                                                                                             0.0s
 => CACHED [4/6] COPY app/requirements.txt .                                                                                              0.0s
 => CACHED [5/6] RUN /usr/local/bin/pip install -r /app/requirements.txt                                                                  0.0s
 => CACHED [6/6] COPY app/* .                                                                                                             0.0s
 => exporting to image                                                                                                                    0.1s
 => => exporting layers                                                                                                                   0.0s
 => => exporting manifest sha256:74835214a4a51a126647e87f06c3cb103b5c3d08b54b3f70d6a7310c76aff2ee                                         0.0s
 => => exporting config sha256:09a5cc653dc580c76ee30dc067c35f06fbdf5c2432e0dd409b0467e10c2a5475                                           0.0s
 => => exporting attestation manifest sha256:dd889687f6a7fbfa53f4044b815ff2e032b0c00a00f5da45934cc88708ba4099                             0.0s
 => => exporting manifest list sha256:9833e249aee89db8cd5f4573a19f732a0ae4772bf8c5787278c4145e4a163260                                    0.0s
 => => naming to docker.io/library/hse_ipr_hw_3-app:latest                                                                                0.0s
 => => unpacking to docker.io/library/hse_ipr_hw_3-app:latest                                                                             0.0s
 => resolving provenance for metadata file                                                                                                0.0s
[+] up 4/4
 ✔ Image hse_ipr_hw_3-app       Built                                                                                                      0.6s
 ✔ Network hse_ipr_hw_3_default Created                                                                                                    0.0s
 ✔ Container hse_redis          Healthy                                                                                                    5.9s
 ✔ Container hse_counter        Started                                                                                                    6.0s
$ curl -fsS http://localhost:8081/
{"greeting": "Custom env greeting", "count": 3, "hostname": "dbd673f8fb62", "storage": "redis"}
$ docker compose stop redis
[+] stop 1/1
 ✔ Container hse_redis Stopped                                                                                                             0.4s
$ curl -fsS http://localhost:8081/healthz
{"status": "alive"}
$ curl -fsS http://localhost:8081/readyz
curl: (22) The requested URL returned error: 503
$ curl -fsS -X POST http://localhost:8081/increment
curl: (22) The requested URL returned error: 503
$ docker compose start redis
[+] start 1/1
 ✔ Container hse_redis Started                                                                                                             0.2s
$ curl -fsS http://localhost:8081/
{"greeting": "Custom env greeting", "count": 3, "hostname": "dbd673f8fb62", "storage": "redis"}
$ curl -fsS -X POST http://localhost:8081/increment
{"greeting": "Custom env greeting", "count": 4, "hostname": "dbd673f8fb62", "storage": "redis"}
```
