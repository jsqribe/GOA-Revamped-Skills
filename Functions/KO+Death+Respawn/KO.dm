mob
	proc
		KO()
			if(curstamina > 0 && curchakra > 0) return
			if(ko) return
			if(!pk)
				curstamina = stamina
				curwound = 0

			else if(gate >= 2)
				Damage(0, rand(32, 37), null, "KO", "Internal")
				curstamina = stamina * ((maxwound - curwound) / maxwound)
				curchakra = max(round(chakra / 4), curchakra)



			else if(src.izanagi_active)
				src.curstamina=src.stamina
				src.curwound-=30
				if(src.curwound<0)
					src.curwound=0
				src.Begin_Stun()
				src.ko = 0
				src.curchakra=src.chakra
				viewers(src) << output ("<font color = white> [src]: Izanagi.....", "combat_output")
				src.izanagi_active=0
				sleep(10)
				flick("Danzou",src)
				src.invisibility = 100
				sleep(5)
				var/mob/human/player/x = usr.MainTarget()
				if(x)
					src.AppearBehind(x)
				else
					src.loc=locate(src.x+6,src.y+6,src.z)
				src.eye_collection-=1
				src.End_Stun()
			//	src << "You have [src.eye_collection] left"
				src.invisibility = 0
				src.halfb = 1
				src.client.screen += new /obj/black2
				return

			else
				if(src.pill)
					if(src.pill>=2)
						src.overlays-='icons/Chakra_Shroud.dmi'
					if(src.pill==3)
						src.overlays-='icons/Butterfly Aura.dmi'
						Damage(0, rand(150, 200), null, "KO", "Internal")
					src.conbuff=0
					src.strbuff=0
					src.pill=0
					src.combat("The effects from the pill(s) wore off.")


				if(src.adren > 0)
					src.adren = src.adren/2 //lose half boost on ko
					//src.strbuff = 0
					//src.conbuff = 0
					//src.rfxbuff = 0


				if(src.sage_mode)
					src.sage_mode = 0
					src.strbuff = 0
					src.conbuff = 0
					src.rfxbuff = 0
					src.naturechakra = 0

				if(src.human_puppet>=1)
					src.human_puppet = 0
					Affirm_Icon()

				if(src.sandfist >= 1)
					src.sandfist = 0
					src.special=0
					src.pixel_y-=32
					src.Fly = 0
					src.density = TRUE
					src.layer = 0
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "1", pixel_x = -32, pixel_y = -48)
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "2", pixel_y = -48)
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "3", pixel_x = 32, pixel_y = -48)
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "4", pixel_x = -32, pixel_y = -16)
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "5", pixel_y = -16)
					src.underlays -= image('New/ArenaGaara.dmi', icon_state = "6", pixel_x = 32, pixel_y = -16)

				if(src.sharingan > 0)
					src.strbuff = 0
					src.conbuff = 0
					src.rfxbuff = 0
					src.intbuff = 0
					src.sharingan = 0
					src.Affirm_Icon()
					src.Load_Overlays()

				if(src.impbyakugan > 0)
					src.see_infrared = 0
					src.impbyakugan = 0
					src.Affirm_Icon()
					src.Load_Overlays()

				if(src.impsharingan > 0)
					src.strbuff = 0
					src.conbuff = 0
					src.rfxbuff = 0
					src.intbuff = 0
					src.impsharingan = 0
					src.Affirm_Icon()
					src.Load_Overlays()
					src.see_infrared = 0

				if(src.shukaku == 1 || src.nibi == 1 || src.sanbi == 1 || src.yonbi == 1 || src.gobi == 1 || src.rokubi == 1 || src.shichibi == 1 || src.hachibi == 1 || src.kyuubi == 1)
					src.shukaku=0
					src.nibi=0
					src.sanbi=0
					src.yonbi=0
					src.gobi=0
					src.rokubi=0
					src.shichibi=0
					src.hachibi=0
					src.kyuubi=0


				Poison = 0
				Damage(0, rand(32, 37), null, "KO", "Internal")
				curstamina=0
				stunned=1
				ko = 1
				//Dipic: Clear stuns on KO
			//	Reset_Stun()
			//	Reset_Move_Stun()

				sleep(10)

				flick("Knockout", src)

				icon_state = "Dead"
				layer = TURF_LAYER
				/*
				for(var/obj/items/Heavenscroll/II in contents)
					//world.log << "Dropped [II]"
					II.Drop()
				for(var/obj/items/Earthscroll/EI in contents)
					EI.Drop()
				*/
				for(var/obj/items/equipable/newsys/SAnbu_Armor/TS in contents)
					world.log << "Dropped [TS]"
					TS.Drop(src)

				for(var/obj/entertrigger/CTF_Flag/F in contents)
					src<<"You dropped the [F.flagname] flag."
					F.Drop(src)
				has_flag=0
				move_stun=0
				movepenalty = 0
				overlays-='icons/faction_icons/star-mouse.dmi'

				// TODO: These vars are calculated and recalcualted all over the place, when they shouldn't even change much!
				var/maxwound1 = 100
				if(clan == "Will of Fire")
					maxwound1 = 130
				else if(clan == "Jashin")
					maxwound1=150
					if(immortality)
						maxwound1=300
				if(warlord==1)
					maxwound1 = maxwound1+15

				if(curwound < maxwound1 || (immortality && cexam != 5))
					sleep(curwound + 100)
					if(ko && curwound < 300)
						if(clan == "Will of Fire")
							curstamina = stamina
							if(curwound > 100)
								curstamina = stamina * 1.25
								curchakra = chakra * 1.25
						else
							curstamina = stamina * min(0.5, 1 - curwound / (2 * maxwound))
						if(curchakra < chakra / 5)
							curchakra = chakra / 5 + 20

					Protect(30)
					End_Stun()
					Reset_Stun()
					Reset_Move_Stun()
					ko = 0
					CombatFlag()
					icon_state = ""
				else
					Die()