program hello
  
  implicit none
  integer :: omp_get_thread_num, omp_get_num_threads
  
  !$omp parallel
  print *,'Hello from thread',omp_get_thread_num(),&
       'out of ', omp_get_num_threads(),' threads'
  !$end omp parallel

end program hello
