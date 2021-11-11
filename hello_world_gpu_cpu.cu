// A simple Hello World CUDA program.

// #include the entire body of the cuPrintf code
//#include "util/cuPrintf.cu"

// #include <stdio.h> for host printf
#include <stdio.h>


__global__ void device_greetings(void)
{
   printf("Hello, world from the device!\n");
}


int main(void)
{
 // greet from the host
   printf("Hello, world from the host!\n");

   // initialize cuPrintf
   //cudaPrintfInit();

   // launch a kernel with a single thread to greet from th>
   device_greetings<<<1,1>>>();

  // display the device's greeting
   cudaDeviceSynchronize();

   //cudaDeviceReset;
   return 0;
 }
