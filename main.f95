program matrix_vector_multiplication_col
  implicit none
  
  integer :: n, m, i, j
  real :: matrix(100, 100), vector(100), result(100)
  real :: start_time, end_time, elapsed_time
  integer :: clock_rate, clock_start, clock_end
  
  ! Read the dimensions of the matrix and vector
  print *, "Enter the number of rows of the matrix:"
  read *, n
  print *, "Enter the number of columns of the matrix and the vector:"
  read *, m
  
  ! Initialize the random number generator with a seed
  call random_seed()
  
  ! Generate random integer values for the matrix and vector
  call random_number(matrix)
  call random_number(vector)
  matrix = int(matrix * 100)
  vector = int(vector * 100)
  
  ! Perform the matrix-vector multiplication and time it
  call system_clock(count_rate=clock_rate)
  call system_clock(count=clock_start)
  
  do j = 1, m
    result(j) = 0.0
    do i = 1, n
      result(j) = result(j) + matrix(i, j) * vector(i)
    end do
  end do
  
  call system_clock(count=clock_end)
  elapsed_time = real(clock_end - clock_start) / real(clock_rate)
  
  ! Print the result and elapsed time
  print *, "The result of the matrix-vector multiplication is:"
  do i = 1, m
    print *, result(i)
  end do
  print *, "Elapsed time: ", elapsed_time, " seconds"
  
end program matrix_vector_multiplication_col