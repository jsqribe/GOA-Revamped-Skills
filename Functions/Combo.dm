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
		if(skillspassive[COMBO] && combo < (1 + skillspassive[COMBO]))
			combo++
			var/C = combo
			spawn(50)
				if(combo == C)
					combo = 0
		if(M && src)

			if(M.using_crow)
				//M.using_crow = 0
				M.Protect(25)

				flick("Form", M)

				sleep(10)

				if(!M || !src) return

				M.AppearBehind(src)

				flick("Reform", M)

			var/boom=0
			if(sakpunch2 || Size || Partial || gobi || madarasusano==1)
				sakpunch2 = 0
				boom = 1
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
			/*
				var/chakracost = skill.ChakraCost(src)
				if(curchakra >= chakracost)
					curchakra -= chakracost
			*/
				if(prob(critchan2))
					// TODO: Having to explicitly deal with __buff and __neg vars everywhere is kinda annoying.
					// We need a better stat-alter system anyway that doesn't blow up when multiple things try to change it.

						//M.Earthquake(3)
						//critdam = ((con+conbuff+str+strbuff) * 2 + 200) * pick(0.6,0.8,1,1.2,1.4)
					critdamx = pick(skill.EstimateStaminaCritDamage(src))
					wounddam = pick(skill.EstimateWoundDamage(src))
					M.Damage(critdamx, wounddam, usr, "Medical: Chakra Scalpel", "Normal")
					if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 20
					// TODO: CSS-ify this message.
					combat("Critical hit [M] for [critdamx] Stamina damage and [wounddam] Wounds!")
					spawn() if(M) M.Graphiked('icons/critical.dmi', -6)
				else
					critdamx = pick(skill.EstimateStaminaDamage(src))
					wounddam = pick(skill.EstimateWoundDamage(src))
					M.Damage(critdamx, wounddam, usr, "Medical: Chakra Scalpel", "Normal")
					if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 2//1
					// TODO: CSS-ify this message.
					combat("Hit [M] for [critdamx] Stamina damage and [wounddam] Wounds!")

				scalpoltime = 0
				spawn(5) if(M) M.Replacement_End()
				return

			blk = (src in get_step(M, M.dir))

/*			if(M.isguard && (!src.taiclash || !M.taiclash) && (M == src.MainTarget() && src == M.MainTarget()))
			/*	etarget.Protect(10)
				M.Protect(10)*/
				M.startclash=1
				src.startclash=1
				flick("PunchA-1", M)
				sleep(1)
				flick("PunchA-1", src)
				sleep(1)
				flick("PunchA-2", M)
				sleep(1)
				flick("PunchA-2", src)
				sleep(1)
				flick("KickA-1", M)
				sleep(1)
				flick("KickA-1", src)
				sleep(1)
				flick("KickA-2", M)
				sleep(1)
				flick("KickA-2", src)
				sleep(1)
				flick("PunchA-1", M)
				sleep(1)
				flick("PunchA-1", src)
				sleep(1)
				flick("PunchA-2", M)
				sleep(1)
				flick("PunchA-2", src)
				sleep(1)
				flick("KickA-1", M)
				sleep(1)
				flick("KickA-1", src)
				sleep(1)
				flick("KickA-2", M)
				sleep(1)
				flick("KickA-2", src)
				sleep(1)
				M.Knockback(3, src.dir)
				src.Knockback(3, M.dir)
				sleep(1)
				for(var/stepz = 1 to 3)
					var
						old_loc = src.loc
						old_loc2 = M.loc
					step(src,src.dir)
					step(M,M.dir)
					if(old_loc != src.loc)
						var/lightning/shadow_step/shadow_step = new(old_loc)
						shadow_step.dir = src.dir
					if(old_loc2 != M.loc)
						var/lightning/shadow_step/shadow_step = new(old_loc2)
						shadow_step.dir = M.dir
				var/obj/t = new/obj(src.loc)
				sleep(1)
				t.icon='icons/gatesmack.dmi'
				flick("smack",t)
				sleep(1)
				flick("PunchA-1", M)
				sleep(1)
				flick("PunchA-1", src)
				sleep(1)
				flick("PunchA-2", M)
				sleep(1)
				flick("PunchA-2", src)
				sleep(1)
				flick("KickA-1", M)
				sleep(1)
				flick("KickA-1", src)
				sleep(1)
				flick("KickA-2", M)
				sleep(1)
				flick("KickA-2", src)
				sleep(1)
				flick("PunchA-1", M)
				sleep(1)
				flick("PunchA-1", src)
				sleep(1)
				flick("PunchA-2", M)
				sleep(1)
				flick("PunchA-2", src)
				sleep(1)
				flick("KickA-1", M)
				sleep(1)
				flick("KickA-1", src)
				sleep(1)
				flick("KickA-2", M)
				sleep(1)
				flick("KickA-2", src)
				sleep(1)
				sleep(10)
				src.taiclash = 1
				M.taiclash = 1
				src << "You have 3 seconds to press A to choose Rock, D to choose Paper or F to choose Scizor"
				M << "You have 3 seconds to press A to choose Rock, D to choose Paper or F to choose Scizor"
				sleep(30)
				if(src.PressAButton=="A" && M.PressAButton=="A" || src.PressAButton=="D" && M.PressAButton=="D" || src.PressAButton=="F" && M.PressAButton=="F" || !src.PressAButton && !M.PressAButton)
					src << "Draw"
					M << "Draw"
					flick("KickA-2",src)
					flick("KickA-2",M)
					M.Knockback(5, src.dir)
					src.Knockback(5, M.dir)
					src.Damage(rand(500),0,M,"Taijutsu Clash","Normal")
					M.Damage(rand(500),0,src,"Taijutsu Clash","Normal")
					sleep(1)
					src.Clash_Timer(60)
					M.Clash_Timer(60)
					src.taiclash = 0
					M.taiclash = 0
					M.startclash=0
					src.startclash=0
				if(src.PressAButton=="A" && M.PressAButton=="F" || src.PressAButton=="F" && M.PressAButton=="D" || src.PressAButton=="D" && M.PressAButton=="A" || !M.PressAButton)
					flick("KickA-2",src)
					M.Knockback(5, src.dir)
					src << "Win"
					M << "Lose"
					M.Damage(rand(1000,1500),0,src,"Taijutsu Clash","Normal")
					sleep(1)
					src.Clash_Timer(50)
					M.Clash_Timer(70)
					src.taiclash = 0
					M.taiclash = 0
					M.startclash=0
					src.startclash=0
				if(M.PressAButton=="A" && src.PressAButton=="F" || M.PressAButton=="F" && src.PressAButton=="D" || M.PressAButton=="D" && src.PressAButton=="A" || !src.PressAButton)
					flick("KickA-2",M)
					src.Knockback(5, M.dir)
					M << "Win"
					src << "Lose"
					src.Damage(rand(1000,1500),0,M,"Taijutsu Clash","Normal")
					sleep(1)
					src.Clash_Timer(70)
					M.Clash_Timer(50)
					src.taiclash = 0
					M.taiclash = 0
					M.startclash=0
					src.startclash=0
/*				else
					src << "Lose"
					M << "Win"*/
	//			M = get_steps(M, M.dir,3)
		//		src = get_steps(src, src.dir,3)
			//	get_steps(src,src.dir,3)
			//	src.icon_state="KickA-2"
			//	get_steps(M,M.dir,3)
			/*	if(src.dir==SOUTH)
					M.Knockback(3, EAST)
					src.Knockback(3, WEST)*/
*/



			if(M.isguard && blk && !boom)
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

			// Ungh.
			usr = src

			if(!M.icon_state)
				flick("hurt", M)

			// Didn't I come up with something interesting relating to this in the movement stuff up farther? Need to go check that out again.
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

			if(tsupunch)
				var/skill/skill = GetSkill(CHAKRA_ENHANCEMENT)
				var/chakracost = skill.ChakraCost(src)
				if(curchakra >= chakracost)
					curchakra -= chakracost
					M.Earthquake(3)
					//critdam = ((con+conbuff+str+strbuff) * 2 + 200) * pick(0.6,0.8,1,1.2,1.4)
					critdam = pick(skill.EstimateStaminaDamage(src))
					M.Damage(critdam, tai_wounds, src, "Medical: Chakra Enhancement", "Normal")

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

			if(boom)
				M.Earthquake(5)
				var/tmp/setdmg=0
				critdam = round((con + conbuff + str + strbuff) * rand(1, 2)) + 800
				if(sakpunch==1)
					setdmg=1
					var/skill/skill = GetSkill(CHAKRA_TAI_RELEASE)
					critdam = pick(skill.EstimateStaminaDamage(src))
					//actually use the medic passive to calculate dam
				if(!setdmg && gobi==1)
					critdam = round((str + strbuff)*1.7 * rand(1.5, 2)) + 100
				if(!setdmg && Size == 1)
					critdam = round((str + strbuff) * rand(1, 1.5)) + 400
				if(!setdmg && Partial == 1)
					critdam = round((str + strbuff) * rand(2, 2.5)) + 400
				if(!setdmg && Size == 2)
					critdam = round((str + strbuff) * rand(2, 2.5)) + 400

				if(!setdmg && madarasusano==1)
					critdam = round((str + strbuff) * rand(1.5, 2)) + 300
					M.Damage(critdam, tai_wounds, src, Size?"[Size==2?"Super ":""]Size Multiplication":"Medical: Cherry Blossom Impact", "Normal")
			//	if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered)
				if(!Size || !Partial)
					// TODO: CSS-ify this message.
					combat("Hit [M] for [critdam] damage with a chakra infused critical hit!!")
				else
					// TODO: CSS-ify this message.
					combat("Hit [M] for [critdam] with your massive fist!!")
				spawn() if(M) M.Graphiked('icons/critical.dmi', -6)

				// More procs that should be taking loc instead of x/y/z...
				if(!Size) spawn() explosion3(50, M.x, M.y, M.z, src, 1)
				pixel_x = 0
				pixel_y = 0
				if(M)
					M.pixel_y = 0
					M.pixel_x = 0
				M.Knockback(rand(5, 10), dir)
				spawn(5) if(M) M.Replacement_End()
				return

			if(prob(critchan))
				//Critical..
				if(gate)
					critdam=round((str + strbuff) * rand(15, 20) / 15) * (1 + 0.10 * skillspassive[2])
				if(!gentlefist)
					critdam=round((str + strbuff) * rand(20, 25) / 15) * (1 + 0.10 * skillspassive[2])
				else
					critdam=round((con + conbuff) * rand(20, 25) / 15) * (1 + 0.10 * skillspassive[2])
				if(twinlion==1)
					critdam=round((((con + conbuff) + (str + strbuff) + (rfx + rfxbuff)) * rand(25, 30) / 10) * (1 + 0.10 * skillspassive[2])*10)

			//	if(!(istype(src, /mob/human/player/npc/kage_bunshin)) && !M.mole && !M.chambered) M.movepenalty += 10
				// TODO: CSS-ify this message.
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
					damage_stat = con + conbuff - conneg + ( (rfx + rfxbuff - rfxneg)/2 )

			// m is such a bad variable name.
			var/m = damage_stat / 200

			//if(gate >= 5) //Dipic: Why do we do this if they're also getting a str/rfx boost? Seems ridiculous. I'm going to disable this and see how it goes. Also reenabling combo for gates so that could get super crazy if this were to stay.
			//	m *= 1.5

			var/dam = 0

			/*
				Try to mathify this: This is pretty close other than deltamove at 3.
				The ?: in the damage is annoying but without it it wouldn't quite add up well without changing the range.
				deltamove += max(0, outcome - 3)
				M.c += max(2, 1 + 0.5 * outcome)
				dam = round(((outcome + 1) * 20 + (outcome>=3)?(10):(0)) * m)
			*/
			//new tai formulas from Max. Not sure about the deltamove and c though.
			switch(outcome)
				if(6,5)
					deltamove += 5//3
					M.c += 4
					dam = round(150 * m)
				if(5)
					deltamove += 4//3
					M.c += 4
					dam = round(150 * m)
				if(4)
					deltamove += 3//1
					M.c += 3
					dam = round(125 * m)
				if(3,2)
					deltamove += 2//1
					M.c += 2.5
					dam = round(100 * m)
				if(1,0)
					deltamove += 1//0
					M.c += 2
					dam = round(75 * m)
			/*old tai formulas
			switch(outcome)
				if(6)
					deltamove += 3
					M.c += 4
					dam = round(150 * m)
				if(5)
					deltamove += 2
					M.c += 3.5
					dam = round(130 * m)
				if(4)
					deltamove += 1
					M.c += 3
					dam = round(110*m)
				if(3)
					deltamove += 1
					M.c += 2.5
					dam = round(90 * m)
				if(2)
					M.c += 2
					dam = round(60 * m)
				if(1)
					M.c += 2
					dam = round(40 * m)
				if(0)
					M.c += 2
					dam = round(20 * m)
			*/

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
			var/DD = dam + critdam

			M.Damage(DD, tai_wounds, usr, "Taijutsu", "Normal")

			/*for(var/mob/human/v in view(1))
				if(v.client)
					// TODO: CSS-ify this message.
					v.combat("[M] was hit for [DD] damage by [src]!")*/

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
					var/dazed = 30
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