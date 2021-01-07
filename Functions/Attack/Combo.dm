var
	// What is this var for?
	fourpointo = 1
mob
	var
		// 'c' and 'cc' need better names.
		c = 0
		cc = 0
		isguard = 0
		dzed = 0

mob

	proc/Combo(mob/M,r)
		// I wonder if there's any way to really simplify this. It's a pretty big proc.
		M = M.Replacement_Start(src)
		if(getPassive(COMBO) && combo < (1 + getPassive(COMBO)))
			combo++
			var/C = combo
			spawn(50)
				if(combo == C)
					combo = 0
		if(M && src)

			if(M.using_crow)

				flick("Form", M)

				sleep(10)

				if(!M || !src) return

				flick("Reform", M)
				return

			var/blk = 0

			spawn() if(M) M.Hostile(src)

			if(scalpol)
				if(M.IsProtected())
					return
				else
					if(!M.icon_state)
						flick("hurt",M)

				var/critchan2 = min(scalpoltime / 5 * rand(2, 5), 50)
				scalpoltime = 0

				var/critdamx
				var/wounddam


				var/skill/skill = GetSkill(MYSTICAL_PALM)

				var/chakracost = skill.ChakraCost(src)
				if(curchakra >= chakracost)
					curchakra -= chakracost
					//world << "reducing [chakracost]"

				if(prob(critchan2))
					// TODO: Having to explicitly deal with __buff and __neg vars everywhere is kinda annoying.
					// We need a better stat-alter system anyway that doesn't blow up when multiple things try to change it.

						//M.Earthquake(3)
						//critdam = ((con+conbuff+str+strbuff) * 2 + 200) * pick(0.6,0.8,1,1.2,1.4)
					critdamx = pick(skill.EstimateStaminaCritDamage(src))
					wounddam = pick(skill.EstimateWoundDamage(src))
					M.Damage(critdamx, wounddam, src, "Medical: Chakra Scalpel", "Normal")
					if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 20
					// TODO: CSS-ify this message.
					combat("Critical hit [M] for [critdamx] Stamina damage and [wounddam] Wounds!")
					spawn() if(M) M.Graphiked('icons/critical.dmi', -6)
				else
					critdamx = pick(skill.EstimateStaminaDamage(src))
					wounddam = pick(skill.EstimateWoundDamage(src))
					M.Damage(critdamx, wounddam, src, "Medical: Chakra Scalpel", "Normal")
					if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 2//1
					// TODO: CSS-ify this message.
					combat("Hit [M] for [critdamx] Stamina damage and [wounddam] Wounds!")

				scalpoltime = 0
				spawn(5) if(M) M.Replacement_End()
				return

			blk = (src in get_step(M, M.dir))

			if(M.isguard && blk)
				// TODO: CSS-ify this message.
				combat("[M] Blocked!")
				M.c--
				attackbreak += 10
				spawn(5)
					attackbreak -= 10
					if(attackbreak < 0) attackbreak = 0
				flick("hurt", src)

				M.icon_state=""
				M.isguard=0
				M.cantreact = 1
				spawn(15)
					M.cantreact = 0
				spawn(5) if(M) M.Replacement_End()
				return

			if(M.dodging >= rand(1,100))
				combat("[M] Dodged")
				M.c--
				spawn(5) if(M) M.Replacement_End()
				return


			if(!M.icon_state)
				flick("hurt", M)

			var/xp = 0
			var/yp = 0
			if(M.x > x)
				xp=1
			if(M.x < x)
				xp=-1
			if(M.y > y)
				yp=1
			if(M.y < y)
				yp=-1
			pixel_x=4 * xp
			// Is this supposed to by pixel_y or _z? Not that it matters too much in GOA's topdown mode.
			pixel_y=4 * yp

			var/deltamove = 0
			var/critdam = 0
			var/critchan = 5
			var/tai_wounds = 0

			if(gentlefist)
				spawn()
				if(M)
					M.Chakrahit2()
					M.curchakra-=pick(3,6,9,12,15)
				if(prob(50))
					tai_wounds = pick(1,2)
				++M.gentle_fist_block
				M.RecalculateStats()
				spawn(100)
					if(M)
						--M.gentle_fist_block
						M.RecalculateStats()
			/*else
				spawn() smack(M,rand(-10,10),rand(-5,15)) wtf is this doing here??*/


			if(bonedrill)
				var/time=0
				var/go=0
				var/location=M.loc
				while(go<=6&&src&&M&&!M.ko&&M.loc==location)
					src.icon_state="Throw1"
					M.icon_state="hurt"
					time++
					if(time>5)
						go++
						if(M)
							M.Damage(50+50*src:ControlDamageMultiplier(),3,src)
							M.Wound(rand(0,1),1,src)
							M.movepenalty+=rand(2,5)
							if(prob(30)&&M)
								Blood2(M)
								M.Earthquake(5)
						time=0
					sleep(1)
				if(src)
					src.icon_state=""
				if(M)
					M.icon_state=""
				return



			if(prob(critchan))
				//Critical..
				if(gate)
					critdam=round(((str + strbuff) * rand(15, 20) / 15) * (1 + 0.10 * skillspassive[2]))
				if(!gentlefist)
					critdam=round(((str + strbuff) * rand(20, 25) / 15) * (1 + 0.10 * skillspassive[2]))
				else
					critdam=round(((con + conbuff) * rand(20, 25) / 15) * (1 + 0.10 * skillspassive[2]))
				if(twinlion==1)
					critdam=round(((((con + conbuff) + (str + strbuff) + (rfx + rfxbuff)) * rand(25, 30) / 10) * (1 + 0.10 * skillspassive[2])*10))


				combat("Critical hit!")
				spawn() if(M) M.Graphiked('icons/critical.dmi', -6)


			var/outcome = Roll_Against(rfx + rfxbuff - rfxneg, M.rfx + M.rfxbuff - M.rfxneg, rand(80, 120))
			var/damage_stat=0
			if(!gentlefist || !twinlion==1)
				damage_stat = str + strbuff - strneg + ( (rfx + rfxbuff - rfxneg)/2 )
			else
				if(twinlion)
					damage_stat = ((con + conbuff - conneg)+(str + strbuff - strneg)+(rfx + rfxbuff - rfxneg))*10
				else
					damage_stat = con + conbuff - conneg// + ( (rfx + rfxbuff - rfxneg)/2 )

			// m is such a bad variable name.
			var/m = damage_stat / 200



			var/dam = 0

			if(gentlefist)
				outcome = 5

			switch(outcome)
				if(6)
					deltamove += 5//3
					M.c += 4
					dam = round(130 * m)
				if(5)
					deltamove += 4//3
					M.c += 4
					dam = round(115 * m)
				if(4)
					deltamove += 3//1
					M.c += 3
					dam = round(95 * m)
				if(3,2)
					deltamove += 2//1
					M.c += 2.5
					dam = round(80 * m)
				if(1)
					deltamove += 1//0
					M.c += 2
					dam = round(65 * m)
				if(0)
					deltamove += 1//0
					M.c += 2
					dam = round(50 * m)


			if(M.c > 13)
				if(prob(10))
					spawn() if(M) M.Knockback(1, dir)
					spawn(1)
						step(src, dir)

			var/current_c = M.c
			spawn(30)
				if(M && M.c == current_c)
					M.c = 0

			if(combo)
				dam *= 1 + (2 * combo) / 30 //< Being a bit strange to avoid floating-point accuracy issues
			var/DD
			if(critdam)
				DD = critdam
			else
				DD = dam

			M.Damage(DD, tai_wounds, src, "Taijutsu", "Normal")


			if((istype(src, /mob/human/player/npc/kage_bunshin)) || M.Tank) deltamove = 1
			if(!M.IsProtected()) M.movepenalty += deltamove
			var/dazeresist = 8 * skillspassive[9]

			if(M.c > 20 && !M.cc && !prob(dazeresist))//combo pwned!!
				if(!(istype(M, /mob/human/player/npc/kage_bunshin)) && !M.IsProtected())
					M.dzed = 1
					M.cc = 150
					spawn()
						sleep(10)
						while(M && M.cc)
							M.cc -= 10
							if(M.cc < 0) M.cc = 0
							sleep(10)
					M.icon_state = "hurt"
					var/dazed = 10
					dazed *= 1 + skillspassive[11] / 10 //< More floating-point accuracy
					M.Timed_Move_Stun(round(dazed, 0.1))

					spawn() if(M) M.Graphiked('icons/dazed.dmi')
					spawn() if(M) smack(M,0,0)
					// TODO: CSS-ify this message. + Maybe send one to M too
					combat("[M] is dazed!")
					M.combat("You are dazed!")
					spawn()
						while(M && M.move_stun)
							sleep(1)
						if(M)
							if(M.icon_state == "hurt") M.icon_state = ""
							M.dzed = 0
							M.c = 0

			sleep(3)
			pixel_x = 0
			pixel_y = 0
			if(M)
				M.pixel_y = 0
				M.pixel_x = 0
				M.Replacement_End()