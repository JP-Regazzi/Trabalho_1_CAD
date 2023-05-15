program matrix_vector_multiplication_col
  implicit none
  
  ! Declara variáveis
  integer :: n, m, i, j, k
  real, allocatable :: matrix(:,:), vector(:), result(:)
  character(len=10) :: size, order
  real :: start_time, end_time, elapsed_time, total_time
  integer :: clock_rate, clock_start, clock_end
  
  ! Pega argumentos de execução
  call get_command_argument(1, size)
  call get_command_argument(2, order)
  read(size, *) n
  read(size, *) m

  ! Aloca memaória para matriz de entrada, vetor de entrada e vetor de resultado
  allocate(matrix(n,m))
  allocate(vector(m))
  allocate(result(n))
  
  ! Inicializa gerador de número aleatórios
  call random_seed()
  
  ! Gera valores aleatórios para preencher matriz e vetor
  call random_number(matrix)
  call random_number(vector)
  matrix = int(matrix * 100)
  vector = int(vector * 100)

  ! Itera 10 vezes pela multiplicação, para pegar tempo médio
  total_time = 0
  do k = 1, 10

    ! Pega tempo de início
    call system_clock(count_rate=clock_rate)
    call system_clock(count=clock_start)

    ! Realiza multiplicação matrix - vetor, com a ordem recebida
    if (order == '1') then ! row_col order
      do i = 1, n
          result(i) = 0.0
          do j = 1, m
              result(i) = result(i) + matrix(i,j) * vector(j)
          end do
      end do
    else if (order == '0') then ! col_row order
      do j = 1, m
          result = result + matrix(:,j) * vector(j)
      end do
    else ! Caso de erro
      print *, "Por favor, escolha uma ordem de execução válida"
      stop
    end if
  
    ! Pega tempo de execução e soma ao tempo total
    call system_clock(count=clock_end)
    elapsed_time = real(clock_end - clock_start) / real(clock_rate)
    total_time = total_time + elapsed_time 
  end do
  
  ! Imprime tempo de execução
  print *, "Tempo de execução: ", total_time/10, " segundos"

  ! Write total time to test file
  if (order == '1') then
    open(1, file='fortran_row_col.txt', status='old', action='write', position='append')
    write(1, *) "n=", n, " -> time = ", total_time/10
    close(1)
  else if (order == '0') then
    open(1, file='fortran_col_row.txt', status='old', action='write', position='append')
    write(1, *) "n =", n, ", time = ", total_time/10
    close(1)
  end if

end program matrix_vector_multiplication_col