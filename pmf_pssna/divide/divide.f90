program mumwcounts
	implicit none
	integer i,j,s(54,40000)
  real(kind=8) a(54,40000),b(54,40000)
  character(20) output

	do i=1,54
		do j=1,40000
			s(i,j)=0
			a(i,j)=0
			b(i,j)=0
		end do
	end do

	open(unit=100,file='window_files.txt',status='unknown')
	open(unit=1,file='out.colvars.traj',status='unknown')

	do i=1,54
		do j=1,10000
			read(1,*)
		end do
		do j=1,40000
			read(1,*)s(i,j),a(i,j),b(i,j)
		end do
	end do
	
	do i=1,54

		read(100,*)output
		open(unit=i+1,file=output,status='unknown')

		do j=1,40000
			write(i+1,*)s(i,j),a(i,j),b(i,j)
		end do
		
		CLOSE (i+1)
			
	end do
	
	CLOSE(1)
	CLOSE(100)
END