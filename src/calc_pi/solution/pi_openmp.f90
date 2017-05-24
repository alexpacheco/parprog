program pi_omp
  implicit none
  integer,parameter :: n=1000000
  real*8,parameter :: r=1.0
  integer i,sum
  real*8 x,y,d,pi
  sum=0
  !$omp parallel do private(i,d,x,y) 
  do i=1,n
     call random_number(x)
     call random_number(y)
     d=(2*x*r-r)**2+(2*y*r-r)**2
     if (d.lt.r**2) sum=sum+1
  enddo
  !$omp end parallel do
  pi=4*float(sum)/float(n)
  print *,'The value of pi is',pi
end program pi_omp
  
