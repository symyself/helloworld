/*
 * =====================================================================================
 *
 *       Filename:  show-bytes.c
 *    Description:  以十六进制打印int,float,指针不同类型对应的字节表示
 *                  参考 第二章 28页
 *        Created:  2015年11月15日 20时44分35秒
 *
 * =====================================================================================
 */
#include <stdlib.h>
#include<stdio.h>
typedef unsigned char * byte_pointer;

void show_bytes(byte_pointer start, int len)
{
    int i;
    for ( i=0;i<len;i++)
        printf(" %.2x",start[i]);
    printf("\n");
}

void show_int(int x)
{
    show_bytes( (byte_pointer)&x,sizeof(int));
}

void show_float( float x)
{
    show_bytes( (byte_pointer)&x,sizeof(float));
}

void show_pointer( void *x)
{
    show_bytes( (byte_pointer)&x,sizeof(void *));
}

void test_show_bytes( int val)
{
    int ival = val;
    float fval = (float) ival;
    int * pval = &ival;

    show_int( ival );
    show_float( fval);
    show_pointer( pval);
}

int main( void )
{
    test_show_bytes( 12345 );
    return 0;
}
