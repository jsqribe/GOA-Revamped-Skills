proc/Electricity(dx, dy, dz, dur)
	var/obj/elec/o = new /obj/elec(locate(dx, dy, dz))
	var/i = dur
	while(o && i > 0)
		var/r = rand(1, 15)
		o.icon_state = "[r]"
		sleep(1)
		i--
	if(o) o.loc = null

obj
	elec
		icon = 'icons/electricity.dmi'
		icon_state = ""
		density = 0

	var
		mob/Causer