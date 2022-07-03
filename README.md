# foundation

Full featured Python application base container image.

This image is built on the Red Hat Universal Base Image for safety and
reliability. The full version of Red Hat was selected to provide the tools that
are often necessary to build and install additional software to create a
platform for an application.

The next layer is the latest version of Python. Within the image it exists
under the python3 name.

Following that, PostgreSQL is installed to provide access to all components
necessary to compile high-performance clients. However, it is not configured to
be used as a database server.

Finally, a selection of Python libraries are installed. These have been
selected to provide easy access to high speed computation.

# Versions

Red Hat UBI: 9.0.0
Python: 3.10.4
PostgreSQL: 14.4
Pscyopg: 3.0.15

# Libraries

setuptools
cython
numpy
scipy
astropy
psycopg[binary,pool]==3.0.15

## build

All build commands assume `buildx` is enabled.

Create a local image for testing. The AMD64 target is specified as this image
was developed on an Apple M1 system.

```
docker build --platform linux/amd64 -t bsiegfreid/foundation:latest --load .
```

To build an official release:

```
docker build \
--platform linux/amd64,linux/arm64 \
-t bsiegfreid/foundation:1.0.0 \
-t bsiegfreid/foundation:latest \
--push .
```
