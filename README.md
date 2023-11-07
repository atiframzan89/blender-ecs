# blender-ecs
Blender app deployment on ecs fargate

First clone the repository
```
cd blender-ecs
$ curl -o blender-binaries.tar.gz https://mirrors.aliyun.com/blender/release/Blender3.6/blender-3.6.5-linux-x64.tar.xz
```
You can download the blender binaries command from the below url
https://mirrors.aliyun.com/blender/release/Blender3.6/blender-3.6.5-linux-x64.tar.xz

Use the below command for extracting
```
tar xf blender-binaries.tar.xz
```

## Building Dockerfile
Use the below command for dockerfile execution

```
docker build -f Dockerfile . -t blender-app
```

