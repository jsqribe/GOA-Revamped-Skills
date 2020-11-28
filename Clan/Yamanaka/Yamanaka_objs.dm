obj
	petal
		icon='icons/petal_dance_flick.dmi'
		layer=MOB_LAYER+1
		New()
			..()
			flick("flick",src)

obj/flick
	var
		list/dependants=new
	New()
		spawn()..()
		spawn()
			dependants+=new/obj/petal(locate(src.x,src.y,src.z))
	Del()
		for(var/obj/x in src.dependants)
			x.loc=null //del is expensive so just set to null and let gc take care of it.
		..()