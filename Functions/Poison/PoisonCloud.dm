proc/PoisonCloud(dx,dy,dz,mag,dur)
	//world<<"proced [dx],[dy],[dz],[mag],[dur]"
	var/list/xlist=new
	if(mag==1)

		var/obj/P1= new/obj/Poison(locate(dx-1,dy+1,dz))
		P1.pixel_x=12
		P1.pixel_y=-12
		var/obj/P2= new/obj/Poison(locate(dx-1,dy,dz))
		P2.pixel_x=8

		var/obj/P3= new/obj/Poison(locate(dx-1,dy-1,dz))
		P3.pixel_x=12
		P3.pixel_y=12

		var/obj/P4= new/obj/Poison(locate(dx,dy+1,dz))
		P4.pixel_y=-8


		var/obj/P5= new/obj/Poison(locate(dx,dy-1,dz))
		P5.pixel_y=8
		var/obj/P6= new/obj/Poison(locate(dx+1,dy+1,dz))
		P6.pixel_x=-12
		P6.pixel_y=-12
		var/obj/P7= new/obj/Poison(locate(dx+1,dy,dz))
		P7.pixel_x=-8

		var/obj/P8= new/obj/Poison(locate(dx+1,dy-1,dz))
		P8.pixel_x=-12
		P8.pixel_y=12
		xlist+= new/obj/Poison(locate(dx,dy,dz))
		xlist+=P1
		xlist+=P2
		xlist+=P3
		xlist+=P4
		xlist+=P5
		xlist+=P6
		xlist+=P7
		xlist+=P8
	for(var/obj/vx in xlist)
		vx.projdisturber=1

	spawn()
		sleep(dur)
		for(var/obj/vv in xlist)
			vv.loc = null