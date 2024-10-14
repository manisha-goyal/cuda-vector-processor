
# CUDA Vector Processing

This project involves writing a simple CUDA program to process vectors. The goal is to perform vector operations on both the CPU and GPU, measure the execution time for each, and analyze the speedup achieved using various configurations of blocks and threads on the GPU.

## Project Overview

The task is to compute the operation `c[i] += a[i] * b[i]` for three dynamically allocated arrays (`a`, `b`, and `c`) of size `n`. This operation is performed sequentially on the CPU and in parallel on the GPU. The execution time for both implementations is measured and compared.

### Key Features:
- Dynamically allocate and initialize arrays with random floating point numbers.
- Perform vector multiplication both on the CPU and GPU.
- Measure and compare the execution time of CPU and GPU implementations.
- Experiment with different CUDA configurations (blocks and threads).

## Compilation and Execution

### Prerequisites

- CUDA Toolkit
- nvcc (NVIDIA CUDA Compiler)
- Access to a CUDA-compatible GPU

### Compiling the Program

Once you have transferred the `vectors.cu` file to the server, navigate to the directory where it is located and run the following command to compile the program:

```bash
nvcc -o vectorprog vectors.cu
```

This command will compile the `vectors.cu` file and generate an executable called `vectorprog`.

### Running the Program

To run the program, execute the compiled binary and provide the number of elements `n` as an argument. For example, to run the program with 1,000,000 elements:

```bash
./vectorprog 1000000
```

#### **Modifying Block and Thread Count:**
Before running the program, ensure that you modify the block and thread count in the code to match your experimental setup. These constants can be found at the top of the source code (`vectors.cu`):

```cpp
#define BLOCKS 8
#define THREADS_PER_BLOCK 500
```

You need to change these values based on your experiment. For example:
- For 4 blocks and 500 threads per block:
  ```cpp
  #define BLOCKS 4
  #define THREADS_PER_BLOCK 500
  ```

The program will calculate how many threads and blocks to use based on these constants.

### Expected Output

The program will print:
- The time taken for the sequential operation on the CPU.
- The time taken for the parallel operation on the GPU.
- Any mismatches between the results of the sequential and parallel operations, if present.

For example:

```bash
Each vector will have 100 elements
Total time taken by the sequential part = 0.000004
Configuration: 8 blocks and 500 threads per block
Total time taken by the GPU part = 0.000454
```

## Notes

- The floating-point precision between the CPU and GPU may slightly differ. Results are compared up to the second decimal place to ensure correctness.
- Ensure that the number of blocks and threads per block matches the configuration specified for each experiment.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.