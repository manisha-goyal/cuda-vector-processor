#!/bin/bash

# Output file to store the results
output_file="experiment_results.csv"

# Write the header to the CSV file
echo "experiment,blocks,threads,input_size,cpu_time,gpu_time" > $output_file

# Experiment 1: Varying Blocks and Threads, Fixed Input Size (1,000,000 elements)
input_size=1000000

for threads in 500 250
do
    for blocks in 4 8 16
    do
        # Run the CUDA program and capture the output
        result=$(./vectorprog $input_size $blocks $threads)

        # Extract CPU and GPU times from the output
        cpu_time=$(echo "$result" | grep "Total time taken by the sequential part" | awk '{print $9}')
        gpu_time=$(echo "$result" | grep "Total time taken by the GPU part" | awk '{print $9}')

        # Write the results to the CSV file
        echo "experiment1,$blocks,$threads,$input_size,$cpu_time,$gpu_time" >> $output_file
    done
done

# Experiment 2: Varying Input Sizes, Fixed Configuration (8 blocks, 500 threads per block)
blocks=8
threads=500

for input_size in 100 1000 10000 100000 1000000 10000000 100000000
do
    # Run the CUDA program and capture the output
    result=$(./vectorprog $input_size $blocks $threads)

    # Extract CPU and GPU times from the output
    cpu_time=$(echo "$result" | grep "Total time taken by the sequential part" | awk '{print $9}')
    gpu_time=$(echo "$result" | grep "Total time taken by the GPU part" | awk '{print $9}')

    # Write the results to the CSV file
    echo "experiment2,$blocks,$threads,$input_size,$cpu_time,$gpu_time" >> $output_file
done

echo "Experiments completed! Results saved in $output_file."