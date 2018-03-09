#!/bin/bash
set -e -x

# https://github.com/pypa/python-manylinux-demo/blob/master/travis/build-wheels.sh

PYTHONS="/opt/python/cp27*/bin"

# Compile wheels
for PYBIN in $PYTHONS; do
#    "${PYBIN}/pip" install -r /io/dev-requirements.txt
    "${PYBIN}/pip" wheel /io/src -w wheelhouse/
done

# Bundle external shared libraries into the wheels
for whl in wheelhouse/*.whl; do
    auditwheel repair "$whl" -w /io/wheelhouse/
done

# Install packages and test
for PYBIN in $PYTHONS; do
    "${PYBIN}/pip" install python-manylinux-demo --no-index -f /io/wheelhouse
    (cd "$HOME"; "${PYBIN}/nosetests" pymanylinuxdemo)
done
