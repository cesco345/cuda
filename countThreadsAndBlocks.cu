#include <stdio.h>
#include <stdlib.h>
#include <iostream>

__global__ void countThreads(void){
           int block_id = blockIdx.x + blockIdx.y * gridDim.x + blockIdx.z * gridDim.x * gridDim.y;

           int block_offset = block_id * blockDim.x * blockDim.y * blockDim.z;

/* int block_id =
         blockIdx.x +
         blockIdx.y * gridDim.x +
         blockIdx.z * gridDim.x * gridDim.y;

           int block_offset = 
                block_id *
                blockDim.x * blockDim.y * blockDim.z;
*/

}


int main( int argc, char **argv)
{
        int thread_offset =  threadIdx.x + threadIdx.y * blockDim.x + threadIdx.z * blockDim.x * blockDim.y;
        int id = block_offset + thread_offset;

        const int b_x = 2, b_y = 3, b_z = 4;
        const int t_x = 3, t_y = 3, t_z = 3;

        int blocks_per_grid = b_x * b_y * b_z;
        int threads_per_block = t_x * t_y * t_z;

        printf("%d blocs per grid\n", blocks_per_grid);
        printf("%d threads per block\n", threads_per_block);
        printf("%d total threads\n", blocks_per_grid * threads_per_block);

        dim3 blocksPerGrid(b_x, b_y, b_z);
        dim3 threadsPerBlock(t_x, t_y, t_z);

        countThreads<<<blocksPerGrid, threadsPerBlock>>>();
        cudaDeviceSynchronize();

        printf("%04d    |    Block(%d %d %d)   =   %3d    |     Thread(%d %d %d)   = %3d\n",
            id,
            blockIdx.x, blockIdx.y, blockIdx.z, block_offset, 
            threadIdx.x, threadIdx.y, threadIdx.z, thread_offset);
        return 0 ;

}
