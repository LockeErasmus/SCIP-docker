# you can pass the argument while building the image
ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}-bullseye

ARG SCIP_VERSION

# Install SCIP dependencies
RUN apt-get update \
    &&  apt-get install -y --no-install-recommends \
        gcc \
        libblas3 \
        libcliquer1 \
        libgfortran5 \
        libgsl25 \
        liblapack3 \
        libopenblas0 \
        libtbb2

# Add SCIP optimization suite installer into container.
COPY ./scip_releases/SCIPOptSuite-${SCIP_VERSION}-Linux-debian.deb /opt/pyscipopt/

WORKDIR /opt/pyscipopt/

# Install SCIP optimization suite and remove installer.
RUN dpkg -i SCIPOptSuite-${SCIP_VERSION}-Linux-debian.deb && \
    rm SCIPOptSuite-${SCIP_VERSION}-Linux-debian.deb 

# Install cvxpy and SCIP Python API
COPY requirements.txt /opt/pyscipopt/
RUN pip install --upgrade pip pip-tools && python -m piptools sync

# Add examples
COPY examples/* /scip_examples/

CMD /bin/bash
