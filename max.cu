#include <stdio.h>


__global__ void maxi(int *a,int *ans)
{

        int tID = blockIdx.x;
        if(tID<10)
        {

                if(a[tID]>*ans)
                {
                     *ans=a[tID];

                }

        }

}


int main()
{
        int a[10],i;
        int c=0;
        int *da,*ans;
        cudaMalloc((void **) &da, 10*sizeof(int));
        cudaMalloc((void **) &ans, 1*sizeof(int));
        printf("dya");
        for(i=0;i<10;i++)
        {
                scanf("%d",&a[i]);

        }
        printf("var");
        cudaMemcpy(da, a, 10*sizeof(int), cudaMemcpyHostToDevice);
        printf("khali");
        cudaMemcpy(ans,&a[0],1*sizeof(int), cudaMemcpyHostToDevice);

        maxi<<<10,1>>>(da,ans);
        cudaMemcpy(&c, ans, sizeof(int), cudaMemcpyDeviceToHost);
        printf("\nmax:%d",c);

        return 0;
}

