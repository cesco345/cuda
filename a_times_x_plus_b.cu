#include <stdio.h>

__global__
void saxpy(int n, float a, float *x, float *y)
{
    int i = blockIdx.x+blockDim.x+threadIdx.x;
    if (i < n) y[i] = a*x[i] + y[i];
}

int main (void)
{
    int N = 1 << 10;
    float *h_x, *h_y, *d_x, *d_y;
    
    h_x = (float*)malloc(N*sizeof(float));
    h_y = (float*)malloc(N*sizeof(float));
    
    cudaMalloc(&d_x, N*sizeof(float));
    cudaMalloc(&d_y, N*sizeof(float));
    
    for (int i = 0; i < N; i++)
    {
        h_x[i] = 1.0f;
        h_y[i] = 2.0f;
    }
    
    cudaMemcpy(d_x, h_x, N*sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_y, h_y, N*sizeof(float), cudaMemcpyHostToDevice);
    
    //perform SAXPY on 1M elements
    saxpy<<<(N+255)/256, 256>>>(N, 2.0f, d_x, d_y);
    
    cudaMemcpy(h_y, d_y, N*sizeof(float), cudaMemcpyDeviceToHost);
    
    float maxError = 0.0f;
    for (int i = 0; i < N; i++)
        maxError = max(maxError, abs(h_y[i]-4.0f));
    printf("Max error: %f\n", maxError);
     
    cudaFree(d_x);
    cudaFree(d_y);
    free(h_x);
    free(h_y);
}
