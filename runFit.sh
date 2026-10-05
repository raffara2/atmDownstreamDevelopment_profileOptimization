#!/bin/bash
# Copyright (C) 2026 Maria Raffaella Vuolo
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# See <https://www.gnu.org/licenses/> for details.
#####################################################################################################

# Script to run OpenFOAM while the inlet and outlet profile differ more than a user-defined threshold
# or number of iterations reaches a user-defined maximum.
# Inlet-outlet discrepancy metrics are calculated with the script plotFitProf.R
# C1 and C2 coefficients are optimized iteratively in the R script by fitting the inlet
# analytical curve (Yang et al., 2009) to the calculated outlet
# Note: sampling inlet and outlet is performed with a dedicated function in controlDict when running OpenFOAM

shopt -s extglob 
relErrTol="0.0"
calcGrads="FALSE"
#calcGrads="TRUE"

Nmax=10
stopLoop=0
i=0
dirout="./fitOut"
fileLogOptim=$dirout"/logOptim.csv"

mkdir -p $dirout
rm $dirout/*
rm -r postProcessing_0
cp 0.orig/include/save_ABLConditions 0.orig/include/ABLConditions
cp 0.orig/include/save_U  0.orig/U
./Allclean
./Allrun-parallel
cp -r postProcessing postProcessing_0
Rscript plotFitProf.R $relErrTol $calcGrads

while [[ $stopLoop -lt 1 && $i -lt $Nmax ]]; do
    stopLoop=`awk 'END {print $NF}' $fileLogOptim`
    echo "Iteration $i"
    i=$((i+1))
    Rscript plotFitProf.R $relErrTol $calcGrads
    ./Allclean
    ./Allrun-parallel
done
