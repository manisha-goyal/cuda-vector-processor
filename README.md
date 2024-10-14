
# CUDA Vector Processing

This project involves writing a simple CUDA program to process vectors. The goal is to perform vector operations on both the CPU and GPU, measure the execution time for each, and analyze the speedup achieved using various configurations of blocks and threads on the GPU.

## Project Overview

The task is to compute the operation `c[i] += a[i] * b[i]` for three dynamically allocated arrays (`a`, `b`, and `c`) of size `n`. This operation is performed sequentially on the CPU and in parallel on the GPU. The execution time for both implementations is measured and compared.

### Key Features:
- Dynamically allocate and initialize arrays with random floating point numbers.
- Perform vector multiplication both on the CPU and GPU.
- Measure and compare the execution time of CPU and GPU implementations.
- Experiment with different CUDA configurations (blocks and threads).
  
## Experiments

### Experiment 1:
**Objective**: Investigate the speedup achieved using various configurations of blocks and threads.

- Fix `n = 1,000,000` (one million).
- Compare speedup for the following configurations:
  - (4 blocks, 500 threads)
  - (8 blocks, 500 threads)
  - (16 blocks, 500 threads)
  - (4 blocks, 250 threads)
  - (8 blocks, 250 threads)
  - (16 blocks, 250 threads)
  
- **Output**: Bar graph showing the speedup for each configuration.

### Experiment 2:
**Objective**: Analyze the speedup as the problem size `n` increases.

- Fix the configuration to 8 blocks and 500 threads.
- Measure speedup for `n = 100`, `1000`, `10000`, `100000`, `1,000,000`, `10,000,000`, and `100,000,000`.

- **Output**: Bar graph showing speedup for each value of `n`.

## Getting Started

### Prerequisites

- CUDA Toolkit
- nvcc (NVIDIA CUDA Compiler)
- Access to a CUDA-compatible GPU

### Compilation and Execution

1. Clone the repository:
   ```bash
   git clone https://github.com/manisha-goyal/cuda-vector-processing.git
   ```
   
2. Navigate to the project directory:
   ```bash
   cd cuda-vector-processing
   ```

3. Compile the program using `nvcc`:
   ```bash
   nvcc -o vectorprog vectors.cu -lm
   ```

4. Run the program:
   ```bash
   ./vectorprog
   ```

### Expected Output

The program will print:
- The time taken for the sequential operation on the CPU.
- The time taken for the parallel operation on the GPU.
- A comparison of the results to ensure correctness.

## Files

- **vectors.cu**: Main source code for the program.
- **experiments.pdf**: Contains results and analysis of experiments.

## Notes

- The floating-point precision between the CPU and GPU can slightly differ. Results are compared up to the second decimal point to ensure correctness.
- In case of memory limitations for large values of `n`, note the maximum supported size and report it.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
