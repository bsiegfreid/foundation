# foundation

Full featured Python application base container image.

## build

All build commands assume `buildx` is enabled.

Create a local image for testing.

```
docker build --platform linux/amd64 -t bsiegfreid/foundation:latest --load .
```

To build an official release:

```
docker build \
--load \
--platform linux/amd64,linux/arm64 \
-t bsiegfreid/foundation:1.0.0 \
-t bsiegfreid/foundation:latest \
--push .
```
