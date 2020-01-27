#!/bin/sh
#XBOW --instance_type=p2.xlarge
#XBOW --upload=bpti-md.tpr
#
# Run a short MD simulation on BPTI
pinda install gromacs 2019-cuda
~/bin/gmx mdrun -deffnm bpti-md
