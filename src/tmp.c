#include <omp.h>

int main() {
  int i = 0, n = 100, a[100];
  #pragma omp parallel for
  for (i = 0; i < n ; i++) {
    a[i] = (i+1) * (i+2);
  }

#pragma omp parallel
  {
#pragma omp sections
    {
#pragma omp section
      some_calculation();
#pragma omp section
      some_more_calculation();
#pragma omp section
      yet_some_more_calculation();
    }
  }
}

#include <omp.h>
int main() {
  int i, n = 100, sum , a[100], b[100];
  for (i = 0; i < n; i++) {
    a[i] = i;
    b[i] = 1;
  }
  sum = 0;
#pragma omp parallel for reduction(+:sum)
  for (i = 0; i < n ; i++) {
    sum += a[i] * b[i];
  }
}


#include <stdio.h>
#include <time.h>

int main() {
  int i;
  long long int n=1000000;
  float a=2.0;
  float x[n];
  float y[n];
  clock_t start_time[2], end_time[2];

  #pragma acc kernels 
  {
    for (i = 0; i < n; i++){
      x[i] = 1.0 ;
      y[i] = 2.0 ;
    }
    
    for (i = 0; i < n; i++){
      y[i] = a*x[i] + y[i];
    }
  }
  #pragma acc parallel
  {
    for (i = 0; i < n; i++){
      x[i] = 1.0 ;
      y[i] = 2.0 ;
    }
    
    for (i = 0; i < n; i++){
      y[i] = a*x[i] + y[i];
    }
  }
  #pragma acc loop
  for (i = 0; i < n; i++){
    y[i] = a*x[i] + y[i];
  }
  printf ("SAXPY Time: %f\n",(double)(end_time[1] - start_time[1])/CLOCKS_PER_SEC);
  
}
