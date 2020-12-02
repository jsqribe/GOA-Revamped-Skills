mob/human
	proc
		defendv()
			set name = "Defend"
			set hidden = 1

			//if(inslymind)
			//	return

			if(client.Controling)
				return

			if(taiclash)
				PressAButton="D"
				return

			if(drowning)
				drownD--
				return

			if(startclash)
				return

			for(var/mob/human/sandmonster/M in pet)
				spawn() if(M) M.Return_Sand_Pet(src)

			if(usr.keys["shift"] && usr.sharingan==7 && usr.madarasusano==1)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.madarasusano=0
			 usr.scalpol=0
			 src.overlays-=image('icons/MadaraDef.dmi',pixel_x=-8,pixel_y=-8)
			 usr<<"Susanoo (DEACTIVATED!)"
			 return
			if(usr.keys["shift"] && usr.sharingan==7 && usr.madarasusano==0)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.madarasusano=1
			 usr<<"Susanoo (ACTIVATED!)"
			 return

			if(usr.keys["shift"] && usr.sharingan==5 && usr.sasukesusano==1)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.sasukesusano=0
			 src.overlays-=image('icons/SasukeDef.dmi',pixel_x=-8,pixel_y=-8)
			// src.overlays-=image('icons/SasAttck.dmi',pixel_x=-96,pixel_y=-96)
			 usr<<"Susanoo (DEACTIVATED!)"
			 return
			if(usr.keys["shift"] && usr.sharingan==5 && usr.sasukesusano==0)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.sasukesusano=1
			 usr<<"Susanoo (ACTIVATED!)"
			 return

			if(usr.keys["shift"] && usr.sharingan==6 && usr.itachisusano==1)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.itachisusano=0
			 src.overlays-=image('icons/ItachiDef.dmi',pixel_x=-8,pixel_y=-8)
			// src.overlays-=image('icons/SasAttck.dmi',pixel_x=-96,pixel_y=-96)
			 usr<<"Susanoo (DEACTIVATED!)"
			 return
			if(usr.keys["shift"] && usr.sharingan==6 && usr.itachisusano==0)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Susanoo with ironskin on"
			 	return
			 usr.itachisusano=1
			 usr<<"Susanoo (ACTIVATED!)"
			 return

			if(usr.keys["shift"] && usr.human_puppet==2)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate Defense mode with ironskin on"
			 	return
			 usr.human_puppet=1
			 usr<<"Defense Mode (DEACTIVATED!)"
			 usr.Affirm_Icon()
			 usr.Load_Overlays()
			 return
			if(usr.keys["shift"] && usr.human_puppet==1)
			 if(usr.ironskin==1)
			 	usr<<"You cant activate defense mode with ironskin on"
			 	return
			 usr.human_puppet=2
			 usr<<"Defense Mode (ACTIVATED!)"
			 usr.overlays=0
			 usr.Affirm_Icon()
			 usr.Load_Overlays()
			 return

			if(Size || Tank || Partial)
				return

			//usedelay++

			if(src.Transfered||src.controlling_yamanaka)
				return

			if(usr.twinlion==2)
			 usr.twinlion=1
			 usr<<"Twin Lions (DEACTIVATED!)"
			 return
			if(usr.twinlion==1)
			 usr.twinlion=2
			 usr<<"Twin Lions (ACTIVATED!)"
			 return


			if(pet)
				for(var/mob/human/player/npc/p in usr.pet)
					spawn()
						if(usr && p)
							var/list/options = list()
							if(options.len)
								var/skill/x
								do
									x = pick(options)
									options -= x
								while(options.len && !x.IsUsable(p))
								if(x && x.IsUsable(p))
									x.Activate(p)
									return

			if(leading)
				leading.stop_following()
				return

			if(cantreact || spectate || larch || sleeping || mane || ko || !canattack)
				return

			if(skillspassive[CONCENTRATION] && gen_effective_int && !gen_cancel_cooldown)
				var/cancel_roll = Roll_Against(gen_effective_int, (con + conbuff - conneg) * (1 + 0.05 * (skillspassive[21] - 1)), 100)
				if(cancel_roll < 3)
					if(sight == (BLIND|SEE_SELF|SEE_OBJS)) // darkness gen
						sight = 0

				gen_cancel_cooldown = 1
				spawn(100)
					gen_cancel_cooldown = 0

			if(MainTarget()) FaceTowards(MainTarget())
			else
				var/mob/nearesttarget = NearestTarget(range=64)
				if(nearesttarget) FaceTowards(nearesttarget)

			if(rasengan == 1)
				Rasengan_Fail()
			if(rasengan == 2)
				ORasengan_Fail()
			if(rasengan == 6)
				SRasengan_Fail()
			//Why is this missing rasenshuriken?

			if(controlmob)
				// More stuff that should just be handled by killing uses of usr and calling controlmob.blah()
				usr = controlmob
				src = controlmob

			if(stunned || kstun || handseal_stun)
				return

			if(!isguard)
				icon_state = "Seal"
				if(madarasusano==1)
					src.overlays+=image('icons/MadaraDef.dmi',pixel_x=-8,pixel_y=-8)
				isguard = 1
				if(sasukesusano == 1)
					src.overlays+=image('icons/SasukeDef.dmi',pixel_x=-8,pixel_y=-8)
				//	src.overlays+=image('icons/SasAttck.dmi',pixel_x=-96,pixel_y=-96)
				isguard = 1

				if(itachisusano == 1)
					src.overlays+=image('icons/ItachiDef.dmi',pixel_x=-8,pixel_y=-8)
				isguard = 1

				if(ironmass == 1)
					src.overlays+=image('icons/magnetdef.dmi',pixel_x=-32,pixel_y=-32)
				isguard = 1
