mob/proc/Cursing_Doll(mob/attacker)
	src.cursing = 0
	var/mob/human/Puppet/Cursed_Doll/puppet = new/mob/human/Puppet/Cursed_Doll(src.loc,attacker)
	Poof(src.x,src.y,src.z)

	puppet.realname = "[attacker]'s Cursed Doll"
	puppet.name = "[attacker]'s Cursed Doll"
	puppet.faction = src.faction
	puppet.CreateName(255, 255, 255)
	puppet.connected_mob = attacker
	spawn() puppet.PuppetRegen(src)




mob/proc/Drunk(var/duration)
	src.Timed_Move_Stun(duration,5)
	var/times = 0
	src.movement_map = list()
	var/list/dirs = list(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
	var/list/dirs2 = dirs.Copy()
	for(var/orig_dir in dirs)
		var/new_dir = pick(dirs2)
		dirs2 -= new_dir
		src.movement_map["[orig_dir]"] = new_dir
	sleep(3)
	src.client:dir = EAST
	sleep(3)
	src.client:dir = SOUTH
	sleep(3)
	src.client:dir = WEST
	sleep(3)
	src.client:dir = NORTH
	times+=1
	if(times>=duration)
		times=0
		if(src) src.movement_map = null
		return
	else
		spawn(0)
			src.Drunk()



//Leaving this here for now
client
	var/mob/Controling=0
	var/mob/hellno=0
	North()
		if(hellno)
			return
		if(Controling) step(Controling,NORTH)
	South()
		if(hellno)
			return
		if(Controling) step(Controling,SOUTH)
	East()
		if(hellno)
			return
		if(Controling) step(Controling,EAST)
	West()
		if(hellno)
			return
		if(Controling) step(Controling,WEST)
	Northwest()
		if(hellno)
			return
		if(Controling) step(Controling,NORTHWEST)
	Northeast()
		if(hellno)
			return
		if(Controling) step(Controling,NORTHEAST)
	Southeast()
		if(hellno)
			return
		if(Controling) step(Controling,SOUTHEAST)
	Southwest()
		if(hellno)
			return
		if(Controling) step(Controling,SOUTHWEST)
