#include <cuda.h>
#include <stdio.h>
#include <time.h>

#define SIZE 3

__global__ void max(int *a , int *c )
{
extern __shared__ int sdata[];

unsigned int tid = threadIdx.x;
unsigned int i = blockIdx.x*blockDim.x + threadIdx.x;

sdata[tid] = a[i];

__syncthreads();

///////////////////////////
for(unsigned int s=1; s<blockDim.x; s*=2)
{
int index = 2 * s * tid;
if(index < blockDim.x)
{
sdata[index] += sdata[index + s];
}
//////////////////////////////
__syncthreads();
}
if(tid == 0) c[blockIdx.x] = sdata[0];

}
//////////////////////////
int main()
{
int i;
srand(time(NULL));

int *a;
a = (int*)malloc(SIZE * sizeof(int));
int c;

int *dev_a, *dev_c;

cudaMalloc((void **) &dev_a, SIZE*sizeof(int));
cudaMalloc((void **) &dev_c, SIZE*sizeof(int));

for( i = 0 ; i < SIZE ; i++)
{
a[i] = rand()% 20 + 1;
}
for( i = 0 ; i < SIZE ; i++)
{
printf("%d ",a[i]);
}

cudaMemcpy(dev_a , a, SIZE*sizeof(int),cudaMemcpyHostToDevice);
max<<<1,SIZE>>>(dev_a,dev_c);
cudaMemcpy(&c, dev_c, SIZE*sizeof(int),cudaMemcpyDeviceToHost);

printf("
sum =  %d 
",c);

cudaFree(dev_a);
cudaFree(dev_c);

printf("
");

return 0;
}
#4

