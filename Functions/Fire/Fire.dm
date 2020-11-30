proc/Fire(dx,dy,dz,mag,dur)
	var/list/xlist=new
	if(mag==1)
		xlist+= new/obj/Fire/f1(locate(dx-1,dy+mag,dz))
		xlist+= new/obj/Fire/f2(locate(dx-1,dy,dz))
		xlist+= new/obj/Fire/f3(locate(dx-1,dy-1,dz))
		xlist+= new/obj/Fire/f4(locate(dx,dy+1,dz))
		xlist+= new/obj/Fire/f5(locate(dx,dy,dz))
		xlist+= new/obj/Fire/f6(locate(dx,dy-1,dz))
		xlist+= new/obj/Fire/f7(locate(dx+1,dy+mag,dz))
		xlist+= new/obj/Fire/f8(locate(dx+1,dy,dz))
		xlist+= new/obj/Fire/f9(locate(dx+1,dy-mag,dz))

	if(mag>=2)

		xlist+= new/obj/Fire/f5(locate(dx-1,dy-1,dz))
		xlist+= new/obj/Fire/f5(locate(dx+1,dy-1,dz))
		xlist+= new/obj/Fire/f5(locate(dx-1,dy+1,dz))
		xlist+= new/obj/Fire/f5(locate(dx+1,dy+1,dz))
		xlist+= new/obj/Fire/f5(locate(dx,dy-1,dz))
		xlist+= new/obj/Fire/f5(locate(dx+1,dy,dz))
		xlist+= new/obj/Fire/f5(locate(dx-1,dy,dz))
		xlist+= new/obj/Fire/f5(locate(dx,dy+1,dz))


		xlist+= new/obj/Fire/f4(locate(dx,dy+2,dz))
		xlist+= new/obj/Fire/f1(locate(dx-1,dy+2,dz))
		xlist+= new/obj/Fire/f7(locate(dx+1,dy+2,dz))

		xlist+= new/obj/Fire/f1(locate(dx-2,dy+1,dz))
		xlist+= new/obj/Fire/f2(locate(dx-2,dy,dz))
		xlist+= new/obj/Fire/f3(locate(dx-2,dy-1,dz))

		xlist+= new/obj/Fire/f3(locate(dx-1,dy-2,dz))
		xlist+= new/obj/Fire/f6(locate(dx,dy-2,dz))
		xlist+= new/obj/Fire/f9(locate(dx+1,dy-2,dz))

		xlist+= new/obj/Fire/f7(locate(dx+2,dy+1,dz))
		xlist+= new/obj/Fire/f8(locate(dx+2,dy,dz))
		xlist+= new/obj/Fire/f9(locate(dx+2,dy-1,dz))

		xlist+= new/obj/Fire/f5(locate(dx,dy,dz))

	for(var/obj/vx in xlist)
		vx.projdisturber=1

	spawn()
		sleep(dur)
		for(var/obj/vv in xlist)
			vv.loc = null