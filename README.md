# Yang et al. (2009) Profile Fitting Tool for OpenFOAM

Companion code repository for manuscript under review.

## Overview

This repository contains:
- `runFit.sh`: bash script to manage the optimization loop
- `plotFitProf.R`: R script that performs the inlet–outlet fit and calculates metrics
- the cleaned and adjusted OpenFOAM configuration case for demonstration of the optimization

## Prerequisites

- **OpenFOAM**: v2312
- **R**: ≥ 4.0

## OpenFOAM Setup

To facilitate the external optimization loop, minor modifications were made to the standard baseline OpenFOAM dictionary files (`0.orig/U`, `0.orig/k`, `0.orig/epsilon`, `0.orig/include/ABLConditions`, `system/controlDict`).

Also, the case was converted from 3D to 2D (modifications in `system/blockMeshDict`).

ALL user-defined changes and variations from the tutorial case released with v2312:

`tutorials/verificationAndValidation/atmosphericModels/atmDownstreamDevelopment/setups.orig/kEpsilon/common/`

are explicitly enclosed within the following comment markers:

```cpp
// rv start
... [Modified keywords or parameter values] ...
// rv end

## Usage

# Source OpenFOAM environment
source /path/to/openfoam-v2312/etc/bashrc

# Run the optimization loop
./runFit.sh

## License

[GPL-3.0](LICENSE)