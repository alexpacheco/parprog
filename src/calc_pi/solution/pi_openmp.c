#include <omp.h>
#include <math.h>
#include <stdio.h>
int main() {
  int N=1000000;
  double x,y,d;
  double pi,r=1.0;
  int i,sum=0;
#pragma omp parallel for private(i,d,x,y) 
  for (i=0;i<N;i++) {
    x = (double)(rand())/((double)(RAND_MAX)+(double)(1));
    y = (double)(rand())/((double)(RAND_MAX)+(double)(1));
    d = pow(2.*r*x-r,2)+pow(2.*r*y-r,2);
    if (d<pow(r,2)) sum++;
  }
  pi = 4.*(double)(sum)/(double)(N);
  printf("The value of pi is %f\n",pi);
}
  
