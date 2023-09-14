# SCIP docker

Clone this repository to build docker image for `SCIPOptSuite` (see https://scipopt.org/) together with `cvxpy` (https://www.cvxpy.org/). Builded image can be used to develop solutions using the SCIP solver together with cvxpy.

## Building docker image

1. Clone this repository
2. Go to https://scipopt.org/ and download `SCIPOptSuite-<version>-Linux-debian.deb` (your prefered version)
3. Put this version into `/scip_releases`
4. Run

```
docker build . -t ${SCIP_DOCKER_TAG} --build-arg SCIP_VERSION=${SCIP_VERSION} --build-arg PYTHON_VERSION=${PYTHON_VERSION}
```

with your own arguments.

Example (`SCIPOptSuite-8.0.3-Linux-debian.deb` is located in `/scip_releases`):

```
docker build . -t "scip_base" --build-arg SCIP_VERSION="8.0.3" --build-arg PYTHON_VERSION="3.10"
```

## Testing

To test docker image is builded correctly, letsb build random non-trivial LP using cvxpy and solve it using SCIP solver:

```
docker run scip_base python /scip_examples/01_generic_linear_program.py
```






