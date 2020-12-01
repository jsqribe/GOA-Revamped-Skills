obj/entertrigger/poisonsmoke
	icon = 'icons/smoke2.dmi'
	icon_state = "poison"
	pixel_x = -32
	pixel_y = -32
	layer = 6.1
	step_size = 32
	var/tmp/mob/human/muser

	New()
		for(var/mob/M in src.loc)
			if(istype(M,/mob/human/player) && M.client && !M.ko && !M.IsProtected())
				PosionHit(M,muser)
		..()

	SteppedOn(mob/human/player/M)
		if(istype(M,/mob/human/player) && M.client && !M.ko && !M.IsProtected())
			PosionHit(M,muser)






proc/PosionHit(mob/M,mob/attacker)
		if(attacker) M.Poison += 10 + attacker.skillspassive[23]*0.25
		//M.combat("You have been affected by posion")
		//world << "Affected Mob([M.x],[M.y]) by Object([src.x],[src.y])"
		spawn() M.Timed_Move_Stun(10) //lags out?
		M.Hostile(attacker)
		M.Damage(200,0,attacker,"Medical: Poison Mist","Normal")