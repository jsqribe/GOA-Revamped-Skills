obj
	mirror
		layer=MOB_LAYER
		density=1




		Back
			icon='icons/Haku.dmi'
			icon_state="Back"




		Front
			icon='icons/Haku.dmi'
			icon_state="Front"



		New()
			..()
			spawn(900)
				loc = null




	waterblob
		icon='icons/Haku.dmi'
		icon_state="water"
		layer=MOB_LAYER+3
		density=0




	iceneedle
		icon='icons/Haku.dmi'
		icon_state="Needles"
		layer=MOB_LAYER+3
		density=0
		var/tmp/mob/human/muser


		New()
			..()
			flick("formNeedles",src)

		Move()
			..()
			for(var/mob/human/player/O in src.loc)
				if(istype(O, /mob/human/player))
					if(O != muser)
						O = O.Replacement_Start(muser)
						O.Timed_Move_Stun(10)
						//O.move_stun+=3
						var/conmult = muser.ControlDamageMultiplier()
						O.Damage((rand(200,300)+70*conmult), 0, muser, "Ice Needles", "Normal")
						//O.Dec_Stam((rand(200,300)+70*conmult),0,user)
						O.Hostile(muser)
						Blood2(O,muser)
						spawn(5) if(O) O.Replacement_End()


