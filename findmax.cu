#include <stdio.h>


__global__ void add(int *a,int *b,int *c)
{
	int tID = blockIdx.x;
	if(tID<10)
	{
		c[tID]=a[tID]+b[tID];
	}
}


int main()
{
	int a[10],b[10],c[10],i;
	int *da,*db,*dc;
	cudaMalloc((void **) &da, 10*sizeof(int));
	cudaMalloc((void **) &db, 10*sizeof(int));
	cudaMalloc((void **) &dc, 10*sizeof(int));
	for(i=0;i<10;i++)
	{
		a[i]=i;
		b[i]=2*i;
	}
	

	cudaMemcpy(da, a, 10*sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(db, b, 10*sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(dc, c, 10*sizeof(int), cudaMemcpyHostToDevice);

	add<<<10,1>>>(da, db, dc);
	cudaMemcpy(c, dc, 10*sizeof(int), cudaMemcpyDeviceToHost);
	
	for(i=0;i<10;i++)
	{
		printf("%d + %d = %d\n",a[i],b[i],c[i]);
	}
	return 0;
}
