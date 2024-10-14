#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda.h>

#define RANGE 17.78
// Constants for blocks and threads per block
#define BLOCKS 4
#define THREADS_PER_BLOCK 500

/*** TODO: insert the declaration of the kernel function below this line ***/
__global__ void vecGPU(float *ad, float *bd, float *cd, int n);
/**** end of the kernel declaration ***/


int main(int argc, char *argv[]){

	int n = 0; //number of elements in the arrays
	int i;  //loop index
	float *a, *b, *c; // The arrays that will be processed in the host.
	float *temp;  //array in host used in the sequential code.
	float *ad, *bd, *cd; //The arrays that will be processed in the device.
	clock_t start, end; // to meaure the time taken by a specific part of code
	
	if(argc != 2){
		printf("usage:  ./vectorprog n\n");
		printf("n = number of elements in each vector\n");
		exit(1);
		}
		
	n = atoi(argv[1]);
	printf("Each vector will have %d elements\n", n);
	
	
	//Allocating the arrays in the host
	
	if( !(a = (float *)malloc(n*sizeof(float))) )
	{
	   printf("Error allocating array a\n");
	   exit(1);
	}
	
	if( !(b = (float *)malloc(n*sizeof(float))) )
	{
	   printf("Error allocating array b\n");
	   exit(1);
	}
	
	if( !(c = (float *)malloc(n*sizeof(float))) )
	{
	   printf("Error allocating array c\n");
	   exit(1);
	}
	
	if( !(temp = (float *)malloc(n*sizeof(float))) )
	{
	   printf("Error allocating array temp\n");
	   exit(1);
	}
	
	//Fill out the arrays with random numbers between 0 and RANGE;
	srand((unsigned int)time(NULL));
	for (i = 0; i < n;  i++){
        a[i] = ((float)rand()/(float)(RAND_MAX)) * RANGE;
		b[i] = ((float)rand()/(float)(RAND_MAX)) * RANGE;
		c[i] = ((float)rand()/(float)(RAND_MAX)) * RANGE;
		temp[i] = c[i]; //temp is just another copy of C
	}
	
    //The sequential part
	start = clock();
	for(i = 0; i < n; i++)
		temp[i] += a[i] * b[i];
	end = clock();
	printf("Total time taken by the sequential part = %lf\n", (double)(end - start) / CLOCKS_PER_SEC);

    /******************  The start GPU part: Do not modify anything in main() above this line  ************/
	//The GPU part
	
	/* TODO: in this part you need to do the following:
		1. allocate ad, bd, and cd in the device
		2. send a, b, and c to the device  
	*/
	int size = n * sizeof(float);

	//Allocate the arrays in the device

	if (cudaMalloc((void **)&ad, size) != cudaSuccess)
	{
		printf("Error allocating array ad of %d elements on device\n", n);
		exit(1);
	}

	if (cudaMalloc((void **)&bd, size) != cudaSuccess)
	{
		printf("Error allocating array bd of %d elements on device\n", n);
		exit(1);
	}

	if (cudaMalloc((void **)&cd, size) != cudaSuccess)
	{
		printf("Error allocating array cd of %d elements on device\n", n);
		exit(1);
	}

	//Copy a, b, and c to the device

	if (cudaMemcpy(ad, a, size, cudaMemcpyHostToDevice) != cudaSuccess) {
        printf("Error copying array a from host to device\n");
        exit(1);
    }

	if (cudaMemcpy(bd, b, size, cudaMemcpyHostToDevice) != cudaSuccess) {
        printf("Error copying array b from host to device\n");
        exit(1);
    }

	if (cudaMemcpy(cd, c, size, cudaMemcpyHostToDevice) != cudaSuccess) {
        printf("Error copying array c from host to device\n");
        exit(1);
    }

	start = clock();

	/* TODO: 	
		3. write the kernel, call it: vecGPU
		4. call the kernel (the kernel itself will be written at the comment at the end of this file), 
		   you need to decide about the number of threads, blocks, etc and their geometry.
	*/

	int threadsPerBlock = THREADS_PER_BLOCK;
    int blocksPerGrid = BLOCKS;

	//Launch the kernel
	vecGPU<<<blocksPerGrid, threadsPerBlock>>>(ad, bd, cd, n);

	//Block host till device is done
	cudaDeviceSynchronize();

	end = clock();

	/* TODO: 
		5. bring the cd array back from the device and store it in c array (declared earlier in main)
		6. free ad, bd, and cd
	*/
	
	//Copy result back to host
	if (cudaMemcpy(c, cd, size, cudaMemcpyDeviceToHost) != cudaSuccess) {
        printf("Error copying array c from device to host\n");
        exit(1);
    }

	//Free the arrays in the device
    cudaFree(ad);
    cudaFree(bd);
    cudaFree(cd);
	
	printf("Total time taken by the GPU part = %lf\n", (double)(end - start) / CLOCKS_PER_SEC);
	/******************  The end of the GPU part: Do not modify anything in main() below this line  ************/
	
	//checking the correctness of the GPU part
	for(i = 0; i < n; i++)
	  if( fabs(temp[i] - c[i]) >= 0.009) //compare up to the second degit in floating point
		printf("Element %d in the result array does not match the sequential version\n", i);
		
	// Free the arrays in the host
	free(a); free(b); free(c); free(temp);

	return 0;
}


/**** TODO: Write the kernel itself below this line *****/

__global__ void vecGPU(float *ad, float *bd, float *cd, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        cd[idx] += ad[idx] * bd[idx];
    }
}