obj
	Bonespire
		var
			causer = 0
		icon = 'icons/sawarabi.dmi'
		layer = MOB_LAYER-0.1
		density = 1

		New(loc, mob/human/cause)
			..()

			var/conbuff = 1

			if(cause)
				conbuff = cause.ControlDamageMultiplier()

			spawn(1)
				src.icon_state = "fin"
				flick("flick", src)

				for(var/mob/human/player/X in loc)
					if(!X.icon_state)
						flick("hurt", X)
					//world << "[X]"
					X.Damage(round(rand(2000, 3000) + rand(700,700) * conbuff), 10, cause, "Bonespire", "Normal")
					X.Hostile(cause)
					spawn() Blood2(X)
					X.Timed_Move_Stun(30)

				sleep(400)
				src.loc = null
