#!/bin/bash
#XBOW --instance_type=t2.small
#XBOW --job_name=mysim
#XBOW --upload=input1.dat
#XBOW --upload=input2.dat

cat input1.dat input2.dat > output.dat
