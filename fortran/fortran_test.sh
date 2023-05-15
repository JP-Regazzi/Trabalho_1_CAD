#!/bin/bash

n=2000
order=1

for i in {1..20}
do
    echo "Running program with n=$n and order=$order"
    ./fortran_main $n $order
    n=$((n+2000))
done