```bash
docker build -t linux_zayac:0.0.1 .
```

```bash
docker run --rm -d \
    --name linux_zayac \
    --hostname linux_zayac \
    --memory=2g \
    --cpus=2 \
    linux_zayac:0.0.1 \
    tail -f /dev/null
```

```bash
docker exec -it \
    linux_zayac\
    /bin/bash
```