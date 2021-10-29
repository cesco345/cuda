#include <stdio.h>
#include <stdlib.h>

#define N 10

__global__ 
void add(int *a, int *b, int *c)
{
    int tid = blockIdx.x;
    if (tid < N)
        c[tid] = a[tid] + b[tid];
}


int main(){

    // create the arrays that will hold the data in the CPU
    int a[N], b[N], c[N];    

    // create the pointers that will hold the data in the GPU
    int *dev_a, *dev_b, *dev_c;

    // allocate the memory to the GPU
    cudaMalloc((void**)&dev_a, N * sizeof(int));
    cudaMalloc((void**)&dev_b, N * sizeof(int));
    cudaMalloc((void**)&dev_c, N * sizeof(int));

    // fill the arrays 'a' and 'b' on the CPU
    for (int i = 0; i<N ; i++)
    {
        a[i] = -i;
        b[i] = i * i;
    }

    // copy memory from host to device (GPU)
    cudaMemcpy(dev_a, a, (N) * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, (N) * sizeof(int), cudaMemcpyHostToDevice);
    
    add<<< N, 1 >>>(dev_a, dev_b, dev_c);

    cudaMemcpy(c, dev_c, N * sizeof(int), cudaMemcpyDeviceToHost);

    // display the results
    for(int i=0; i<N; i++)
    {
        printf("%d + %d = %d \n", a[i], b[i], c[i]);
    }

    cudaFree(dev_a); 
    cudaFree(dev_b); 
    cudaFree(dev_c);

    printf("\n");

    return 0;
}
