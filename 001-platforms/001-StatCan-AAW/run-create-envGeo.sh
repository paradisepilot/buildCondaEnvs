#!/bin/bash

echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] run-create-envGeo.sh begins"

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
pkgsCONDA=( \
    "conda=23.3.1" \
    "pip=20.0.2" \
    "r-base=4.2.3" \
    "r-terra=1.7_23" \
    "libgdal" \
    "gdal" \
    "geos" \
    "proj" \
    "sqlite" \
    "cairo" \
    "libnetcdf" \
    "earthengine-api" \
    "google-cloud-sdk" \
    "python=3.11.3" \
    "scikit-learn" \
    "pandas" \
    "numpy" \
    "scipy" \
    "stac-geoparquet" \
    "georasters" \
    "osmnx" \
    "pystac" \
    "rioxarray" \
    "sklearn-xarray" \
    # "stackstac" \
    # "pyarrow" \
    "r-arrow" \
    "r-sf=1.0_12" \
    "r-lwgeom=0.2_11" \
    "r-stars" \
    "r-spdep" \
    "r-sp" \
    "r-proj4" \
    "r-rgdal" \
    "r-gdalutils" \
    "r-cairo" \
    "r-rcpp" \
    "r-codetools" \
    "r-ncdf4" \
    "r-rsqlite" \
    # "r-tidyverse" \
    "r-leaflet" \
    "r-deldir" \
    "r-tinytest=" \
    "r-dplyr" \
    "r-ggplot2" \
    "r-googledrive" \
    "r-dggridr" \
    "r-gdistance" \
    "r-geosphere" \
    "r-ggmap" \
    "r-ggspatial" \
    "r-gstat" \
    "r-raster" \
    "r-rastervis" \
    "r-rgee" \
    "r-rgooglemaps" \
    "r-spacetime" \
    "r-spatialeco" \
    "r-spatstat" \
    # "r-cshapes" \
    # "r-gdalutilities=1.2.4" \
    # "r-openstreetmap" \
    # "r-rts" \
    # "r-vapour" \
    )

pkgsPyPI=( \
    "geowombat" \
    "geemap" \
    "geoparquet" \
    "dggrid4py" \
    "earthpy" \
    "ease-grid" \
    "easepy" \
    "pydggrid" \
    "rHEALPixDGGS" \
    )

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
timeStamp=`date +"%Y%m%d%H%M%S"`
myEnvName=envGeo${timeStamp}
myEnvPath=/home/jovyan/envs/${myEnvName}
echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] ${myEnvName} environment build begins"

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] creation of new empty environment (${myEnvName}) begins"
# conda create --yes --name ${myEnvName}
conda create --yes --prefix ${myEnvPath}
sleep 2
myEnvFolder=`conda env list | egrep "${myEnvName}" | sed 's/[ ][ ]*/ /g' | cut -d' ' -f2,2`
echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] creation of new empty environment (${myEnvName}) complete"

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] conda env list"
conda env list

echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] myEnvFolder=${myEnvFolder}"
echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] which python=`which python`"
echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] CONDA_DEFAULT_ENV=${CONDA_DEFAULT_ENV}"
echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] CONDA_PREFIX=${CONDA_PREFIX}"

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] conda packages installation begins"
for temppkg in "${pkgsCONDA[@]}"
do
    echo "    [`date +"%Y-%m-%d:%H-%M-%S"`] conda installion begins: ${temppkg}"
    # conda install --yes --name ${myEnvName} \
    conda install --yes --prefix ${myEnvPath} \
        --channel conda-forge \
        --channel "conda-forge/label/broken" \
        --channel "conda-forge/label/cf201901" \
        --channel "conda-forge/label/cf202003" \
        --channel "conda-forge/label/gcc7" \
        --channel esri \
        --channel phausamann \
        --channel r \
        --channel vfonov \
        ${temppkg} > stdout.conda-install.${temppkg} 2> stderr.conda-install.${temppkg}
    echo "    [`date +"%Y-%m-%d:%H-%M-%S"`] conda installion complete: ${temppkg}"
done
echo "[`date +"%Y-%m-%d:%H-%M-%S"`] conda packages installation complete"

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`]: pypi packages installation begins"
for temppkg in "${pkgsPyPI[@]}"
do
    echo "    [`date +"%Y-%m-%d:%H-%M-%S"`] pip installion begins: ${temppkg}"
    ${myEnvFolder}/bin/pip install --no-input ${temppkg} > stdout.pip-install.${temppkg} 2> stderr.pip-install.${temppkg}
    echo "    [`date +"%Y-%m-%d:%H-%M-%S"`] pip installion complete: ${temppkg}"
done
echo "[`date +"%Y-%m-%d:%H-%M-%S"`]: pypi packages installation complete"

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] ${myEnvName} environment build complete"

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
echo;echo "[`date +"%Y-%m-%d:%H-%M-%S"`] run-create-envGeo.sh complete"
echo;echo
