skill
	sand_control
		copyable = 0

		gaara_clan
			id = GAARA_CLAN
			icon_state = "doton"
			name = "Gaara"
			description = "Gaara Clan Jutsu."
			stack = "false"//don't stack
			clan=1

		sand_summon
			id = SAND_SUMMON
			name = "Sand Summoning"
			description = "Creates a blob of sand that you control."
			icon_state = "sand_control"
			default_chakra_cost = 300
			default_cooldown = 10

			IsUsable(mob/human/user)
				. = ..()
				if(.)
					if(user.pet.len >= 3)
						Error(user, "You may only control 3 summon sands at once")
						return 0


			Use(mob/human/user)
				var/lim=0
				for(var/mob/human/x in user.pet)
					if(x)
						if(++lim > 3)
							x.loc = null// is this sand limit
				if(!istype(user.pet, /list))user.pet=new/list
				viewers(user) << output("[user]: Sand Summoning!", "combat_output")

				var/mob/human/p=new/mob/human/sandmonster(user.loc)
				user.pet+=p
				p.initialized=1
				p.faction = user.faction
				p.con=user.con
				p.loc=user.loc
				spawn()
					var/ei=1
					while(ei)
						ei=0
						for(var/mob/human/x in ohearers(10,p))
							if(x==user)
								ei=1
						sleep(20)
					if(p)
						user.pet-=p
						del(p)




		sand_unsummon
			id = SAND_UNSUMMON
			name = "Sand Unsummoning"
			description = "Releases your controlled sand."
			icon_state = "sand_unsummon"
			default_chakra_cost = 20
			default_cooldown = 3



			Use(mob/human/user)
				viewers(user) << output("[user]: Sand Unsummoning!", "combat_output")
				for(var/mob/human/sandmonster/X in user.pet)
					X.loc = null
					user.pet -= X




		sand_shield
			id = SAND_SHIELD
			name = "Sand Shield"
			description = "Turns your controlled sand into a shield, blocking most sources of damage."
			icon_state = "sand_shield"
			default_chakra_cost = 100
			default_cooldown = 20



			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.Get_Sand_Pet())
						Error(user, "Cannot be used without summoned sand")
						return 0



			Use(mob/human/user)
				viewers(user) << output("[user]: Sand Shield!", "combat_output")
				var/mob/p=user.Get_Sand_Pet()

				if(p)
					p.density=0
					user.Begin_Stun()

					while(user && get_dist(user, p) > 1)
						user.sandshield=1
						step_to(p,user,1)
						sleep(1)


					if(!p)
						if(user)
							user.End_Stun()
							user.sandshield=0


					if(!user) return

					if(p)
						user.pet-=p
						p.loc=null

						var/obj/x=new/obj/sandshield(user.loc)
						var/count = 100//should we make it drain chakra and end when they activate it again?
						user.Protect(102)
						user.sandshield=2
						while(user && user.IsProtected() && count > 0)
							sleep(1)
							count--
						if(user)
							user.End_Stun()
							user.sandshield=0
						x.loc = null

					else
						if(user)
							user.End_Stun()
							user.sandshield=0




		desert_funeral
			id = DESERT_FUNERAL
			name = "Desert Funeral"
			description = "Crushes your enemy with a blob of sand."
			icon_state = "desert_funeral"
			default_chakra_cost = 400
			default_cooldown = 120
			stamina_damage_fixed = list(2200, 3000)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(5, 15)
			wound_damage_con = list(0, 0)



			IsUsable(mob/user)
				. = ..()
				var/mob/human/target = user.MainTarget()
				if(.)
					if(!target || target.IsProtected() || target.sandcoffined)
						Error(user, "No Valid Target")
						return 0
					if(!user.Get_Sand_Pet())
						Error(user, "Cannot be used without summoned sand")
						return 0



			Use(mob/human/user)
				var/mob/p=user.Get_Sand_Pet()
				var/mob/human/etarget = user.MainTarget()
				var/conmult = user.ControlDamageMultiplier()
				viewers(user) << output("[user]: Desert Funeral!", "combat_output")

				if(p)
					p.icon='icons/Gaara.dmi'
					p.density=0//so it can be directly on top of the target
					var/effort=5
					while(p && etarget && get_dist(etarget, p) > 1 && effort > 0)
						step_to(p,etarget,0)
						sleep(2)
						effort--
					walk(p,0)
					if(!etarget || !p)
						return
					if(get_dist(etarget, p) <= 1)
						var/target_loc = etarget.loc
						sleep(1) //Dipic: This gives the target a chance to escape (or most likely cause it to be a partial hit)
						//p.loc = target_loc//test fix
						p.overlays=0
						/*
						for(var/obj/u in user.pet)
							user.pet-=u
						*/
						p.layer=MOB_LAYER+1

						if(target_loc == etarget.loc || etarget.Get_Move_Stun()) //Dipic: Full hit
							world<<"[etarget.loc];[p.loc]"
							etarget = etarget.Replacement_Start(user)
							etarget.sandcoffined=1
							p.loc = etarget.loc
							p.icon_state="D-funeral"
							flick("D-Funeral-flick",p)


							etarget.Timed_Stun(50)
							sleep(20)
							spawn(30)
								if(etarget)
									etarget.Replacement_End()
									etarget.sandcoffined=0
							if(user.shukaku==1)
								etarget.Damage(3000*1.4,rand(5,15),user,"Desert Funeral","Normal")
							else
								etarget.Damage(rand(600,1350)+1500*conmult,rand(5,15),user,"Desert Funeral","Normal")
								//etarget.Damage(3000,rand(5,15),user,"Desert Funeral","Normal")
							etarget.Hostile(user)
						else if(get_dist(etarget, p) <= 2)//Dipic: Partial hit
							etarget = etarget.Replacement_Start(user)
							etarget.sandcoffined=1
							p.loc = etarget.loc
							p.icon_state="partial" //Dipic: This will be changed to a half hitting state
							flick("partial",p) //Dipic: and half hitting flick
							Blood2(p)//some fx

							etarget.Timed_Stun(10)
							etarget.Timed_Move_Stun(50)
							sleep(10)
							spawn(10)
								if(etarget)
									etarget.Replacement_End()
									etarget.sandcoffined=0
							if(user.shukaku==1)
								etarget.Damage(2200*1.4,rand(5,10),user,"Desert Funeral","Normal")
							else
								etarget.Damage(rand(300,750)+750*conmult,rand(4,9),user,"Desert Funeral","Normal")
							etarget.Hostile(user)
						else //Dipic: damn, they teleported; miss
							p.icon_state="partial" //Dipic: This will be changed to a half hitting state
							flick("partial",p) //Dipic: and half hitting flick
							Blood2(p)//some fx
						sleep(10)
						if(p)
							user.pet-=p
							del(p)





		sand_armor
			id = SAND_ARMOR
			name = "Sand Armor"
			description = "Creates an invisible layer of sand that blocks any damage for a short period of time."
			icon_state = "sand_armor"
			default_chakra_cost = 200
			default_cooldown = 150

			IsUsable(mob/user)
				. = ..()
				if(.) if(user.sandarmor)
					Error(user, "Sand Armor is already activated")
					return 0

			DoCooldown(mob/user, resume = 0, passthrough = 0)
				if(user.sandarmor)
					for(var/skillcard/card in skillcards)
						card.overlays += 'icons/dull.dmi'
					cooldown = Cooldown()
				else ..()

			Use(mob/human/user)
				viewers(user) << output("[user]: Sand Armor!", "combat_output")
				user.sandarmor=5
				spawn()
					while(user && user.sandarmor)
						sleep(1)
					if(!user) return
					user.Timed_Stun(10)
					user.Protect(10)
					user.dir=SOUTH
					var/obj/o = new/obj/sandarmor(user.loc)
					flick("break",o)
					o.density=0

					user.icon_state=""
					sleep(10)
					o.loc = null

		kazesand
			id = KAZE_SAND
			name = "Sunagakure Secret Jutsu: Sand Grab"
			description = "The user starts controling the sand to grab the enemie."
			icon_state = "desert_funeral"
			default_chakra_cost = 10
			default_cooldown = 5

			Use(mob/human/user)
				var/has_sand=0
				var/mob/human/enemie //= mob/M in All_Clients()//user.MainTarget()
				if(!has_sand)
					for(var/turf/Terrain/Sand/X in oview(0,enemie))
						has_sand=1
						break
				if(has_sand && enemie.faction.village!=user.faction.village)
					var/mob/R = new/obj/kazesand(locate(enemie.x, enemie.y, enemie.z))
					enemie.Timed_Stun(10)
					sleep(10)
					del(R)

		sand_attack
			id = SAND_ATTACK
			name = "Sand Attack"
		//	description = "Allows your normal hits to drain your enemy's chakra and do internal damage."
			icon_state = "sand_attack"
			default_chakra_cost = 100
			default_cooldown = 30

			IsUsable(mob/user)
				. = ..()
				if(.) if(user.sandfist)
					Error(user, "Sand Attack is already activated")
					return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Gentle Fist!", "combat_output")
				user.sandfist=1
				user.overlays+='icons/sand_walk.dmi'
				user.special=/obj/sandfists


		sand_shuriken
			id = SAND_SHURIKEN
			name = "Sand Shuriken"
			description = "Creates shuriken out of sand."
			icon_state = "sand_shuriken"
			default_chakra_cost = 300
			default_cooldown = 40
			stamina_damage_fixed = list(200, 200)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(0, 1)
			wound_damage_con = list(0, 0)



			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.qued || user.qued2)
						Error(user, "A conflicting skill is already activated")
						return 0
					var/has_sand = 0
					for(var/mob/human/sandmonster/X in ohearers(10,user))
						has_sand = 1
						break
					if(!has_sand)
						for(var/turf/Terrain/Sand/X in oview(10,user))
							has_sand = 1
							break
					if(!has_sand)
						Error(user, "No sand available")
						return 0



			Use(mob/human/user)
				viewers(user) << output("[user]: Sand Shuriken!", "combat_output")

				//user.Timed_Stun(10)

				var/turf/From=null
				for(var/mob/human/sandmonster/X in ohearers(10,user))
					if(!From)
						From=X.loc
						X.loc = null
				if(!From)
					for(var/turf/Terrain/Sand/X in oview(10,user))
						if(!From)
							From=X
							break
				if(From)
					var/obj/O = new/obj(From)
					O.icon='icons/sandshuriken.dmi'
					O.icon_state="sand"
					O.density=0
					O.layer=MOB_LAYER+1
					sleep(2)
					var/t=0
					while(O && user && O.loc != user.loc)
						step_to(O,user,0)
						t++
						sleep(1)
						if(t>100)
							if(O)
								O.loc = null
							if(user) user.icon_state=""
							return
					if(O)
						O.loc = null

						if(user)
							user.overlays+=image('icons/sandshuriken.dmi',icon_state="sand")

							user.qued2=1
							user.on_hit.add(src, "Cancel")

					if(user) user.icon_state=""




			proc
				Cancel(mob/human/player/user, mob/human/player/attacker, event/event)
					event.remove(src, "Cancel")
					if(user && user.qued2)
						spawn() user.Deque2(0)




obj
	sandarmor
		icon='icons/sandarmor.dmi'
		icon_state="break"
		layer=MOB_LAYER+1




mob/proc
	Get_Sand_Pet()
		for(var/mob/human/sandmonster/X in src.pet)
			if(X && get_dist(X, src) <= 10 && !X.tired)
				return X


	Return_Sand_Pet(mob/owner)
		var/mob/human/sandmonster/x=src
		if(!x.tired)
			spawn()
				x.density=0
				walk_to(x,owner,0,1)
				sleep(6)
				x.density=1
				walk(x,0)
				x.tired=0
