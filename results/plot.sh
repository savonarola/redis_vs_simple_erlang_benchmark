#!/bin/bash

set -x
set -e

for plot_script in $(ls *.gp)
do
  gnuplot -c $plot_script
done
