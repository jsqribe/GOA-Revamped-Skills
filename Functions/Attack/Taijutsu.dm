mob/proc
	Taijutsu(mob/M)
		if(M)
			if(M.larch)
				spawn()
					Blood2(src)
					src.Damage(rand(100,500),rand(5,10),M,"Taijutsu Larch","Normal")
					src.Hostile(M)
					src.Timed_Move_Stun(3)
			if(M.sandshield)
				spawn()
					var/obj/sandshield/shield = locate(/obj/sandshield) in M.loc
					flick("[src.dir]",shield)
					Blood2(src)
					src.Damage(rand(100,500),rand(5,10),M,"Taijutsu Sandshield","Normal")
					src.Hostile(M)
					src.Timed_Move_Stun(3)

	Fallpwn()
		var/E=src.pixel_y
		while(E>10)
			E-=10
			src.pixel_y-=10
			sleep(1)
		sleep(1)
		src.pixel_y=0
		explosion(1,src.x,src.y,src.z,src,1)
		src.incombo=0
		src.pixel_x=0
		src.End_Stun()
		spawn() src.Timed_Stun(20)
		sleep(20)
		src.icon_state=""
		src.layer=MOB_LAYER