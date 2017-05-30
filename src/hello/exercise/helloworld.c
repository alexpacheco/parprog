#include <stdio.h>
/* Include omp.h ? */
int main() {
  #pragma omp parallel
  {
    printf("Hello world from thread %d out of %d threads\n",
	   omp_get_thread_num(), omp_get_thread_num());
  }
}
