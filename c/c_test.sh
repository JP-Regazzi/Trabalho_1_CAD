#!/bin/bash

n=2000
order=0

for i in {1..21}
do
    echo "Running program with n=$n and order=$order"
    ./c_main $n $order
    n=$((n+2000))
done