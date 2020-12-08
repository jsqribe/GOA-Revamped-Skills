proc/Doton_Cage(dx, dy, dz, dur)
	var/obj/cage = new /obj/earthcage(locate(dx, dy, dz))
	cage.owner = usr
	flick("Creation", cage)
	sleep(dur)
	cage.loc = null
