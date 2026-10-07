program his
    implicit none
    integer i,j,k,s,maxbin,bin
    parameter(maxbin=100)
  real(kind=8) a(54,40000),b(54,40000),numo(maxbin,54),binz(maxbin),poss(maxbin)
    real(kind=8) oz,zmax,zmin,boxc,deltaz

    do i=1,54
        do j=1,40000
            a(i,j)=0
            b(i,j)=0
        end do
    end do
    
        do i=0,maxbin
            do j=0,54
                numo(i,j)=0
            end do
        end do

    open(unit=1,file='out.colvars.traj',status='unknown')
    open(unit=2,file='his.txt',status='unknown')

        zmin=20
        zmax=90
        boxc=zmax-zmin
        deltaz=boxc/maxbin
        
    do i=1,54
        do j=1,10000
            read(1,*)
        end do
        do j=1,40000
            read(1,*)s,a(i,j),b(i,j)
        end do
    end do

    do i=1,54
        do j=1,40000
            oz=a(i,j)-zmin
            bin=int(oz/deltaz)+1
            numo(bin,i)=numo(bin,i)+1
        end do
    end do

        do bin=1,maxbin
            binz(bin)=bin*deltaz-deltaz/2+20
    write(2,*)binz(bin),numo(bin,1),numo(bin,2),numo(bin,3),numo(bin,4),numo(bin,5),numo(bin,6),numo(bin,7),numo(bin,8),numo(bin,9)&
&,numo(bin,10),numo(bin,11),numo(bin,12),numo(bin,13),numo(bin,14),numo(bin,15),numo(bin,16),numo(bin,17),numo(bin,18)&
&,numo(bin,19),numo(bin,20),numo(bin,21),numo(bin,22),numo(bin,23),numo(bin,24),numo(bin,25),numo(bin,26),numo(bin,27)&
&,numo(bin,28),numo(bin,29),numo(bin,30),numo(bin,31),numo(bin,32),numo(bin,33),numo(bin,34),numo(bin,35),numo(bin,36)&
&,numo(bin,37),numo(bin,38),numo(bin,39),numo(bin,40),numo(bin,41),numo(bin,42),numo(bin,43),numo(bin,44),numo(bin,45)&
&,numo(bin,46),numo(bin,47),numo(bin,48),numo(bin,49),numo(bin,50),numo(bin,51),numo(bin,52),numo(bin,53),numo(bin,54)
        end do
    
    close(1)
    close(2)
end
