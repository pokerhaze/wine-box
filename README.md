# wine-box
## docker steps
```
docker buildx create --use
docker buildx inspect --bootstrap
docker buildx build --platform linux/arm64 -t kccy/wine-box:latest --push .
docker run -it -p 5900:5900 -p 8090:8080 kccy/wine-box
```
Only for ARM64, OCP is ok.
