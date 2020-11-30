proc/AOEPoison(xx, xy, xz, radius, stamdamage, duration, mob/human/attacker, poi, stun)
	var/obj/entertrigger/poisonsmoke/o = new/obj/entertrigger/poisonsmoke(locate(xx, xy, xz))
	var/i = duration
	while(i > 0)
		i -= 10
		sleep(10)
	o.loc = null
