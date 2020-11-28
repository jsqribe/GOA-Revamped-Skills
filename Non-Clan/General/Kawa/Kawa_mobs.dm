mob/human/player/npc/replacement_log
	Damage()
		return

	Dec_Stam()
		return

	Wound()
		return

	Hostile()
		return

	KO()
		return

	Replacement_Start()
		return src

	Replacement_End(state="kawa")
		Poof(x, y, z)
		if(src.exploding_log)
			icon = 'icons/exploding_log.dmi'
		else
			icon = 'icons/log.dmi'
		icon_state = state
		overlays = null
		underlays = null
		if(src.exploding_log)
			spawn(10)
				Poof(x, y, z)
				explosion(1500, x, y, z, src)
				del(src)
				spawn(20)
					loc = null
		else
			spawn(20)
				//loc = null
				del(src)//temporary fix for whispers/kage verbs as I cannot figure out what keeps the replacements around
