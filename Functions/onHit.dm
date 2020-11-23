mob/proc

	targetHit()
		for(var/mob/human/o in get_step(src, dir))
			if(!o.ko && !o.IsProtected())
				return o


	onHit(mob/target, type)

		if(!target && NearestTarget()) FaceTowards(NearestTarget())

		var/mob/hit = targetHit()
		var/critdam = 0

		switch(type)
			if("rasengan")
				// And a bit more specific to the rasengans: They all do the exact same thing except with different overlays and proc calls.
				switch(rasengan)
					if(1)//Normal Rasengan
						overlays -= /obj/rasengan
						overlays += /obj/rasengan2
						flick("PunchA-1", src)
						if(hit)
							Rasengan_Hit(hit, src, dir)
						else
							Rasengan_Fail()
						return
					if(2)//Oodama Rasengan
						overlays -= /obj/oodamarasengan
						overlays += /obj/oodamarasengan2
						flick("PunchA-1", src)
						if(hit)
							ORasengan_Hit(hit, src, dir)
						else
							ORasengan_Fail()
						return
					if(3)//Rasen Shuriken
						flick("PunchA-1", src)
						if(hit)
							Rasenshuriken_Hit(hit, src, dir)
						else
							Rasenshuriken_Fail()
						return

					if(4)
						flick("PunchA-1", src)
						if(hit)
							Rasenshuriken_Hit2(hit, src, dir)
						else
							Rasenshuriken_Fail2()
						return

					if(6)
						flick("PunchA-1", src)
						if(hit)
							SRasengan_Hit(hit, src, dir)
						else
							SRasengan_Fail()

						return


			if("sakpunch")
				if(sakpunch)
					var/skill/skill = GetSkill(CHAKRA_TAI_RELEASE)
					flick("PunchA-1", src)
					if(hit)
						var/mob/M=hit
						M.Earthquake(3)

						critdam = pick(skill.EstimateStaminaDamage(src))
						M.Damage(critdam, 0, src, "Medical: Cherry Blossom Impact", "Normal")

						if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 5
						combat("Hit [M] for [critdam] damage with a chakra infused critical hit!!")
						spawn() M.Graphiked('icons/critical.dmi', -6)

						spawn() explosion3(50, M.x, M.y, M.z, src, 1)
						pixel_x = 0
						pixel_y = 0
						M.pixel_y = 0
						M.pixel_x = 0
						M.Knockback(rand(3,6), dir)

						spawn(5) if(M) M.Replacement_End()

						sakpunch = 0 //if you miss can't go again

						return

					sakpunch = 0 //if you miss can't go again


			if("tsupunch")
				if(tsupunch)
					var/skill/skill = GetSkill(CHAKRA_ENHANCEMENT)
					var/chakracost = skill.ChakraCost(src)
					if(curchakra >= chakracost)
						curchakra -= chakracost
						flick("PunchA-1", src)
						if(hit)
							var/mob/M=hit
							M.Earthquake(3)

							critdam = pick(skill.EstimateStaminaDamage(src))
							M.Damage(critdam, 0, src, "Medical: Chakra Enhancement", "Normal")

							if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 5
							combat("Hit [M] for [critdam] damage with a chakra infused critical hit!!")
							spawn() M.Graphiked('icons/critical.dmi', -6)

							spawn() explosion3(50, M.x, M.y, M.z, src, 1)
							pixel_x = 0
							pixel_y = 0
							M.pixel_y = 0
							M.pixel_x = 0
							M.Knockback(rand(3,6), dir)

							spawn(5) if(M) M.Replacement_End()

						spawn()
							overlays+='icons/sakurapunch.dmi'
							sleep(5)
							overlays-='icons/sakurapunch.dmi'
						return
					else //not enough chakra, returning to regular taijutsu
						tsupunch = 0


			if("Size")
				if(Size || Partial)
					if(Size == 1)
						critdam = round((con + conbuff + str + strbuff) * rand(1, 1.5)) + 800

					if(Partial == 1)
						critdam = round((con + conbuff + str + strbuff) * rand(2, 2.15)) + 800

					if(Size == 2)
						critdam = round((con + conbuff + str + strbuff) * rand(2.15, 3)) + 800

					flick("PunchA-1", src)

					if(hit)
						var/mob/M=hit
						M.Earthquake(3)

						M.Damage(critdam, 0, src, "Medical: Chakra Enhancement", "Normal")

						if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 5
						combat("Hit [M] for [critdam] with your massive fist!!")
						spawn() M.Graphiked('icons/critical.dmi', -6)

						pixel_x = 0
						pixel_y = 0
						M.pixel_y = 0
						M.pixel_x = 0
						M.Knockback(rand(3,6), dir)

						spawn(5) if(M) M.Replacement_End()
						return

			if("chidori")
				if(chidori)
					if(hit)
						var/mob/M=hit
						M = M.Replacement_Start(src)
						var/result=Roll_Against(src.rfx+src.rfxbuff-src.rfxneg,M.rfx+M.rfxbuff-M.rfxneg,70)

						switch(result)
							if(5)
								src.combat("[src] Critically hit [M] with the Chidori")
								M.combat("[src] Critically hit [M] with the Chidori")
								M.Damage(rand(1200,2000),rand(20,50),src,"Lightning: Chidori","Normal")

							if(4)
								src.combat("[src] Managed to partially hit [M] with the Chidori")
								M.combat("[src] Managed to partially hit [M] with the Chidori")
								M.Damage(rand(400,800),rand(10,20),src,"Lightning: Chidori","Normal")

							if(3)
								src.combat("[src] Managed to partially hit [M] with the Chidori")
								M.combat("[src] Managed to partially hit [M] with the Chidori")
								M.Damage(rand(300,500),rand(5,10),src,"Lightning: Chidori","Normal")

							else
								src.combat("You Missed!!!")
								if(!src.icon_state)
									flick("hurt",src)

						if(result>=3)
							spawn()ChidoriFX(src)
							M.Timed_Move_Stun(50)
							spawn()Blood2(M,src)
							spawn()M.Hostile(src)
							spawn()src.Taijutsu(M)


						spawn(5)
							if(M) M.Replacement_End()

					src.overlays-='icons/chidori.dmi'
					src.usemove=0
					src.chidori=0