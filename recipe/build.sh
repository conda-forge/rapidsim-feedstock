#!/usr/bin/env bash
set -eu

mkdir build
cd build

export EVTGEN_ROOT=${PREFIX}

cmake \
    $CMAKE_ARGS \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" \
    -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
    -DRAPIDSIM_ROOT="${PREFIX}/share/rapidsim" \
    ..

make -j${CPU_COUNT}
make install

# Set RAPIDSIM_ROOT on environment activation
mkdir -p "${PREFIX}/etc/conda/env_vars.d"
cat > "${PREFIX}/etc/conda/env_vars.d/${PKG_NAME}.json" << EOF
{
  "RAPIDSIM_ROOT": "${PREFIX}/share/rapidsim"
}
EOF
