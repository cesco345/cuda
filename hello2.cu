#include <stdio.h>

__global__ void hello_cuda()
{
	printf("Hello CUDA world \n");
}

int main()
{
	int nx, ny;
	nx = 2;
	ny = 2;

	dim3 block(2, 1);
	dim3 grid(nx / block.x,ny / block.y);

	hello_cuda << < 2,2 >> > ();
	cudaDeviceSynchronize();

	cudaDeviceReset();
	return 0;
}

