mob
	proc/BurnDOT(mob/human/attacker,burndmg,id)
		if(src.IsProtected() || src.chambered) return
		if(src.burning)
			if(src.burnid == "nail" && src.burner == attacker)
				src.burning += burndmg
				src.burndur = 100
				return 1
			else if(burndmg >= src.burning)	//stronger flames take over (or equal flames reset duration)
				src.burning = burndmg	//setting burning (the damage) to the new damage
				src.burndur = 100	//and resetting the burn duration
				src.burner = attacker
				src.burnid = id
				return 1
			else				//weaker, squelched by the previous flames
				return 0		//returning here
		else
			src.burning = burndmg
			src.burndur = 100
			src.burner = attacker
			src.burnid = id
			src.overlays += 'icons/base_m_fire.dmi'
			spawn()
				while(src && !src.IsProtected() && src.burndur)
					src.burndur -= 10
					sleep 10
				src.overlays -= 'icons/base_m_fire.dmi'
				src.burning = 0
				src.burndur = 0