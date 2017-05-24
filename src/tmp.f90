program paralleldo

  implicit none
  integer :: i, n, a(100)
  
  i = 0
  n = 100
  !$omp parallel do
  do i = 1, n
     a(i) = i * (i+1)
  end do
  !$omp end parallel do

  !$omp parallel
  !$omp sections
  !$omp section
  call some_calculation
  !$omp section
  call some_more_calculation
  !$omp section
  call yet_some_more_calculation
  !$omp end sections
  !$omp end parallel
end program paralleldo


program reduction
  
  implicit none
  integer :: i, n, sum , a(100), b(100)

  n = 100 ; b = 1; sum = 0
  do i = 1 , n
     a(i) = i
  end do
  !$omp parallel do reduction(+:sum)
  do i = 1, n
     sum = sum + a(i) * b(i)
  end do
  !$omp end parallel do

end program reduction


program pitfalls
  use omp_lib
  implicit none
  integer :: i, n, nthreads,myid,max
  real*8 :: a(n),some_function(n),x,b

  !$omp parallel
  myid = omp_get_thread_num()
  nthreads = omp_get_numthreads()
  do i = myid+1, n , nthreads
     a(i) = some_function(i)
  end do
  !$omp end parallel

  !$omp parallel do
  do i = 1, n
     if (a(i) > max) then
        max = a(i)
     end if
  end do
  !$omp end parallel do

  !$omp parallel do
  do i = 1, n
     b = some_function(i)
     !$omp critical
     call some_routine(b,x)
  end do
  !$omp end parallel do

  !$omp parallel do
  do i = 1, n
     b = some_function(i)
     !$omp atomic
     x = x + b
  end do
  !$omp end parallel do
end program pitfalls


program saxpy

  use omp_lib 

  implicit none
  integer :: i,n
  real,dimension(:),allocatable :: x, y
  real :: a,start_time, end_time

  n=100000000
  allocate(x(n),y(n))
  a = 2.0

  !$acc kernels
  do i = 1, n
     x(i) = 1.0
     y(i) = 2.0
  end do

  do i = 1, n
     y(i) = y(i) + a * x(i)
  end do
  !$acc end kernels
  deallocate(x,y)
  
  print '(a,f15.6,a)', 'SAXPY Time: ', end_time - start_time, 'in secs'
  
end program saxpy

program saxpy

  use omp_lib 

  implicit none
  integer :: i,n
  real,dimension(:),allocatable :: x, y
  real :: a,start_time, end_time

  n=100000000
  allocate(x(n),y(n))
  a = 2.0

  !$acc parallel
  do i = 1, n
     x(i) = 1.0
     y(i) = 2.0
  end do

  do i = 1, n
     y(i) = y(i) + a * x(i)
  end do
  !$acc end parallel

  !$acc parallel
  !$acc loop
  do i = 1, n
     y(i) = y(i) + a * x(i)
  end do
  !$acc end loop
  !$acc end parallel
  deallocate(x,y)
  
  print '(a,f15.6,a)', 'SAXPY Time: ', end_time - start_time, 'in secs'
  
end program saxpy
    
