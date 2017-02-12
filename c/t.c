#include <stdlib.h>
#include<stdio.h>
int main()
{
    int i;
    //for( i=0;i<=9; printf("\b\b\b%3d%3d%3d%3d%3d%3d%3d%3d%3d",1,4,7,10,13,16,19,22,i+=25) )
    for( i=0;i<=9; printf("\r%3d%3d%3d%3d%3d%3d%3d%3d%3d",1,4,7,10,13,16,19,22,i+=25) )
        printf("%3d",i);
    return 1;
}

