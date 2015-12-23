/*
 * =====================================================================================
 *       Filename:  bool.c
 *    Description:  bool 交换数组顺序，第二章 34，35页
 *        Created:  2015年11月15日 21时26分43秒
 *       Compiler:  gcc
 * =====================================================================================
 */
#include <stdlib.h>
#include<stdio.h>
void print_x_y( int x,int y)
{
    printf("x=%d y=%d\n",x,y);
}
void inplace_swap( int * x,int* y)
{
    print_x_y( *x,*y);
    *y = *x ^ *y;
    print_x_y( *x,*y);
    *x = *x ^ *y;
    print_x_y( *x,*y);
    *y = *x ^ *y;
    print_x_y( *x,*y);
}
void print_array( int a[],int cnt )
{
    int i;
    for ( i=0;i<cnt;i++)
        printf("%d ",a[i]);
    printf("\n");
}
void reverse_array( int a[],int cnt)
{
    print_array( a,cnt);
    int first=0,last=cnt-1;
    //for(;first<=last;first++,last--)
    for(;first<last;first++,last--)
        inplace_swap( &a[first],&a[last]);
        print_array( a,cnt);
    print_array( a,cnt);
}

int main( void )
{
    int a[4]={4,2,3,4};
    int b[5]={5,2,3,4,5};
    reverse_array( a,4);
    reverse_array( b,5);
    int k=5;
    inplace_swap( &k,&k);
    printf("%d\n",k);
    int u=5,v=5;
    inplace_swap( &u ,&v);
    printf("%d\t%d\n",u,v);
    return 0;
}
