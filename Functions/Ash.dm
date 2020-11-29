proc/Ash(dx,dy,dz,dur)
	var/list/X=new
	X+= new/obj/Ash/f5(locate(dx,dy,dz))
	X+= new/obj/Ash/f5(locate(dx+1,dy,dz))
	X+= new/obj/Ash/f5(locate(dx+2,dy,dz))
	X+= new/obj/Ash/f5(locate(dx+3,dy,dz))
	X+= new/obj/Ash/f5(locate(dx-1,dy,dz))
	X+= new/obj/Ash/f5(locate(dx-2,dy,dz))
	X+= new/obj/Ash/f5(locate(dx-3,dy,dz))
	X+= new/obj/Ash/f5(locate(dx,dy+1,dz))
	X+= new/obj/Ash/f5(locate(dx,dy+2,dz))
	X+= new/obj/Ash/f5(locate(dx,dy+3,dz))
	X+= new/obj/Ash/f5(locate(dx,dy-1,dz))
	X+= new/obj/Ash/f5(locate(dx,dy-2,dz))
	X+= new/obj/Ash/f5(locate(dx,dy-3,dz))

	X+= new/obj/Ash/f5(locate(dx+1,dy+3,dz))
	X+= new/obj/Ash/f5(locate(dx+2,dy+3,dz))
	X+= new/obj/Ash/f5(locate(dx-1,dy+3,dz))
	X+= new/obj/Ash/f5(locate(dx-2,dy+3,dz))
	X+= new/obj/Ash/f5(locate(dx+1,dy-3,dz))
	X+= new/obj/Ash/f5(locate(dx+2,dy-3,dz))
	X+= new/obj/Ash/f5(locate(dx-1,dy-3,dz))
	X+= new/obj/Ash/f5(locate(dx-2,dy-3,dz))
	X+= new/obj/Ash/f5(locate(dx+1,dy+2,dz))
	X+= new/obj/Ash/f5(locate(dx+2,dy+2,dz))
	X+= new/obj/Ash/f5(locate(dx-1,dy+2,dz))
	X+= new/obj/Ash/f5(locate(dx-2,dy+2,dz))
	X+= new/obj/Ash/f5(locate(dx+1,dy-2,dz))
	X+= new/obj/Ash/f5(locate(dx+2,dy-2,dz))
	X+= new/obj/Ash/f5(locate(dx-1,dy-2,dz))
	X+= new/obj/Ash/f5(locate(dx-2,dy-2,dz))
	X+= new/obj/Ash/f5(locate(dx-3,dy+2,dz))
	X+= new/obj/Ash/f5(locate(dx+3,dy+2,dz))
	X+= new/obj/Ash/f5(locate(dx+3,dy-2,dz))
	X+= new/obj/Ash/f5(locate(dx-3,dy-2,dz))
	X+= new/obj/Ash/f5(locate(dx+1,dy+1,dz))
	X+= new/obj/Ash/f5(locate(dx+2,dy+1,dz))
	X+= new/obj/Ash/f5(locate(dx-1,dy+1,dz))
	X+= new/obj/Ash/f5(locate(dx-2,dy+1,dz))
	X+= new/obj/Ash/f5(locate(dx+1,dy-1,dz))
	X+= new/obj/Ash/f5(locate(dx+2,dy-1,dz))
	X+= new/obj/Ash/f5(locate(dx-1,dy-1,dz))
	X+= new/obj/Ash/f5(locate(dx-2,dy-1,dz))
	X+= new/obj/Ash/f5(locate(dx-3,dy+1,dz))
	X+= new/obj/Ash/f5(locate(dx+3,dy+1,dz))
	X+= new/obj/Ash/f5(locate(dx+3,dy-1,dz))
	X+= new/obj/Ash/f5(locate(dx-3,dy-1,dz))

	X+= new/obj/Ash/f4(locate(dx,dy+4,dz))
	X+= new/obj/Ash/f4(locate(dx-1,dy+4,dz))
	X+= new/obj/Ash/f4(locate(dx+1,dy+4,dz))

	X+= new/obj/Ash/f6(locate(dx,dy-4,dz))
	X+= new/obj/Ash/f6(locate(dx-1,dy-4,dz))
	X+= new/obj/Ash/f6(locate(dx+1,dy-4,dz))

	X+= new/obj/Ash/f8(locate(dx+4,dy,dz))
	X+= new/obj/Ash/f8(locate(dx+4,dy+1,dz))
	X+= new/obj/Ash/f8(locate(dx+4,dy-1,dz))

	X+= new/obj/Ash/f2(locate(dx-4,dy-1,dz))
	X+= new/obj/Ash/f2(locate(dx-4,dy+1,dz))
	X+= new/obj/Ash/f2(locate(dx-4,dy,dz))

	X+= new/obj/Ash/f1(locate(dx-4,dy+2,dz))
	X+= new/obj/Ash/f1(locate(dx-3,dy+3,dz))
	X+= new/obj/Ash/f1(locate(dx-2,dy+4,dz))

	X+= new/obj/Ash/f7(locate(dx+4,dy+2,dz))
	X+= new/obj/Ash/f7(locate(dx+3,dy+3,dz))
	X+= new/obj/Ash/f7(locate(dx+2,dy+4,dz))

	X+= new/obj/Ash/f3(locate(dx-4,dy-2,dz))
	X+= new/obj/Ash/f3(locate(dx-3,dy-3,dz))
	X+= new/obj/Ash/f3(locate(dx-2,dy-4,dz))

	X+= new/obj/Ash/f9(locate(dx+4,dy-2,dz))
	X+= new/obj/Ash/f9(locate(dx+3,dy-3,dz))
	X+= new/obj/Ash/f9(locate(dx+2,dy-4,dz))
	for(var/obj/O1 in X)
		O1.projdisturber=1
	spawn()
		sleep(dur)
		for(var/obj/O in X)
			O.loc = null