program his
    implicit none
    integer i,j,k,s,maxbin,bin
    parameter(maxbin=100)
  real(kind=8) a(20,80000),b(20,80000),numo(maxbin,20),binz(maxbin),poss(maxbin)
    real(kind=8) oz,zmax,zmin,boxc,deltaz

    do i=1,20
        do j=1,80000
            a(i,j)=0
            b(i,j)=0
        end do
    end do
    
        do i=0,maxbin
            do j=0,20
                numo(i,j)=0
            end do
        end do

    open(unit=1,file='out.colvars.traj',status='unknown')
    open(unit=2,file='his.txt',status='unknown')

        zmin=20
        zmax=90
        boxc=zmax-zmin
        deltaz=boxc/maxbin
        
    do i=1,20
        do j=1,20000
            read(1,*)
        end do
        do j=1,80000
            read(1,*)s,a(i,j),b(i,j)
        end do
    end do

    do i=1,20
        do j=1,80000
            oz=a(i,j)-zmin
            bin=int(oz/deltaz)+1
            numo(bin,i)=numo(bin,i)+1
        end do
    end do

        do bin=1,maxbin
            binz(bin)=bin*deltaz-deltaz/2+20
    write(2,*)binz(bin),numo(bin,1),numo(bin,2),numo(bin,3),numo(bin,4),numo(bin,5),numo(bin,6),numo(bin,7),numo(bin,8),numo(bin,9)&
&,numo(bin,10),numo(bin,11),numo(bin,12),numo(bin,13),numo(bin,14),numo(bin,15),numo(bin,16),numo(bin,17),numo(bin,18)&
&,numo(bin,19),numo(bin,20)
        end do
    
    close(1)
    close(2)
end
