skill
	kenjutsu
		face_nearest = 1
		copyable = 1

		dancing_blade
			id = DANCING_BLADE
			name = "Kenjutsu: Dancing Blade Risk"
			description = "User performs a quick dash towards his opponent, slashing them."
			icon_state = "blade_dance"
			default_chakra_cost = 500
			default_cooldown = 50
			stamina_damage_fixed = list(150, 3000)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(0, 0)
			wound_damage_con = list(0, 0)

			IsUsable(mob/human/user)
				. = ..()
				if(.)
					if(user.swordeq==0)
						Error(user, "You need to have a sword equiped")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Dancing Blade Risk!", "combat_output")

				var/rfx_mod = ((user.rfx+user.rfxbuff)-user.rfxneg)
				for(var/steps = 1 to 6)

					flick("w-attack", user)
					var
						old_loc = user.loc
						mob/enemy = locate() in get_step(user,user.dir)

					step(user,user.dir)

					if(old_loc == user.loc && enemy)
						enemy.overlays += 'icons/slash.dmi'
						if(enemy)
							enemy = enemy.Replacement_Start(user)
						user.loc = enemy.loc
						enemy.Damage(round((rand((12*user.skillspassive[18]),((12*user.skillspassive[18])+250))*rfx_mod)/158),round(rand(3,10)),user,"Dancing Blade Risk","Normal")
						enemy.overlays -= 'icons/slash.dmi'

					if(old_loc != user.loc)
						var/lightning/shadow_step/shadow_step = new(old_loc)
						shadow_step.dir = user.dir

					spawn()
						if(enemy)
							enemy.Hostile(user)
					spawn(5)if(enemy) enemy.Replacement_End()


				user.frozen++
				sleep(2)
				if(user)
					user.frozen--


		Iai_Beheading
			id = IAI_BEHEADING
			name = "Kenjutsu: Iai Beheading"
			description = "User performs a quick and powerful slash with their sword in order to cut the intended target."
			icon_state = "blade_cut"
			default_chakra_cost = 400
			default_cooldown = 45
			stamina_damage_fixed = list(125, 1575)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(0, 0)
			wound_damage_con = list(0, 0)

			IsUsable(mob/human/user)
				. = ..()
				if(.)
					if(user.swordeq==0)
						Error(user, "You need to have a sword equiped")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Iai Beheading!", "combat_output")
				var/mob/human/X = user.MainTarget()
				var/rfx_mod = ((user.rfx+user.rfxbuff)-user.rfxneg)
				user.Begin_Stun()
				spawn(30) user.End_Stun()
				spawn()
					if(!X)
						user.combat("There was no target")
						return
					else if(X)
						user.usemove=1
						sleep(15)//1.5 seconds before he attacks
						var/inrange=(X in oview(user, 2))

						if(X && user.usemove==1 && inrange)
							X.overlays += 'icons/slash.dmi'
							X = X.Replacement_Start(user)
							flick("w-attack",user)
							user.combat("[user] beheaded [X]!")
							X.combat("[user] beheaded [X]!")
						//	X.Wound(rand(15, 75), 1, user)
							X.Damage(((round(12.5*user.skillspassive[18])*rfx_mod)/100),round(rand(2,5)),user,"Iai Beheading","Normal")

							spawn()Blood2(X,user)
							spawn()X.Hostile(user)
							spawn(5)if(X) X.Replacement_End()

							user.usemove = 0
							X.overlays -= 'icons/slash.dmi'


		Instant
			id = INSTANT_SLASH
			name = "Kenjutsu: Instant Tripple Slash"
			description = "User takes out his sword slashing many times and reappears behind his opponent."
			icon_state = "blade_slash"
			default_chakra_cost = 400
			default_cooldown = 60
			stamina_damage_fixed = list(125, 4725)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(0, 0)
			wound_damage_con = list(0, 0)

			IsUsable(mob/human/user)
				. = ..()
				if(.)
					if(user.swordeq==0)
						Error(user, "You need to have a sword equiped")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Instant Tripple Slash!", "combat_output")
				var/mob/human/etarget = user.NearestTarget()
				var/rfx_mod = ((user.rfx+user.rfxbuff)-user.rfxneg)
			//	spawn(1)
				user.dir = angle2dir(get_real_angle(user, etarget))
				for(var/steps = 1 to 6)
					flick("w-attack", user)
					var
						old_loc = user.loc
						mob/enemy = locate() in get_step(user,user.dir)

					step(user,user.dir)

					if(old_loc == user.loc && enemy)
						enemy.overlays += 'icons/slash.dmi'
						if(enemy)
							enemy = enemy.Replacement_Start(user)
						user.loc = enemy.loc
						enemy.Damage(round((rand((5*user.skillspassive[18]),((5*user.skillspassive[18])+150))*rfx_mod)/158),round(rand(1,2)),user,"Dancing Blade Risk","Normal")
						enemy.overlays -= 'icons/slash.dmi'

					if(old_loc != user.loc)
						var/lightning/shadow_step/shadow_step = new(old_loc)
						shadow_step.dir = user.dir

					spawn()
						if(enemy)
							enemy.Hostile(user)
					spawn(5)if(enemy) enemy.Replacement_End()

				sleep(5)

			//	spawn(1)
				user.dir = angle2dir(get_real_angle(user, etarget))
				for(var/steps = 1 to 6)
					flick("w-attack", user)
					var
						old_loc = user.loc
						mob/enemy = locate() in get_step(user,user.dir)

					step(user,user.dir)

					if(old_loc == user.loc && enemy)
						enemy.overlays += 'icons/slash.dmi'
						if(enemy)
							enemy = enemy.Replacement_Start(user)
						user.loc = enemy.loc
						enemy.Damage(round((rand((5*user.skillspassive[18]),((5*user.skillspassive[18])+150))*rfx_mod)/158),round(rand(1,2)),user,"Dancing Blade Risk","Normal")
						enemy.overlays -= 'icons/slash.dmi'

					if(old_loc != user.loc)
						var/lightning/shadow_step/shadow_step = new(old_loc)
						shadow_step.dir = user.dir

					spawn()
						if(enemy)
							enemy.Hostile(user)
					spawn(5)if(enemy) enemy.Replacement_End()

				sleep(5)

			//	spawn(1)
				user.dir = angle2dir(get_real_angle(user, etarget))
				for(var/steps = 1 to 6)
					flick("w-attack", user)
					var
						old_loc = user.loc
						mob/enemy = locate() in get_step(user,user.dir)

					step(user,user.dir)

					if(old_loc == user.loc && enemy)
						enemy.overlays += 'icons/slash.dmi'
						if(enemy)
							enemy = enemy.Replacement_Start(user)
						user.loc = enemy.loc
						enemy.Damage(round((rand((5*user.skillspassive[18]),((5*user.skillspassive[18])+150))*rfx_mod)/158),round(rand(1,2)),user,"Dancing Blade Risk","Normal")
						enemy.overlays -= 'icons/slash.dmi'

					if(old_loc != user.loc)
						var/lightning/shadow_step/shadow_step = new(old_loc)
						shadow_step.dir = user.dir

					spawn()
						if(enemy)
							enemy.Hostile(user)
					spawn(5)if(enemy) enemy.Replacement_End()


				user.frozen++
				sleep(2)
				if(user)
					user.frozen--

/*
				var/mob/human/X = user.MainTarget()
				var/rfx_mod = ((user.rfx+user.rfxbuff)-user.rfxneg)
				user.Begin_Stun()
				spawn(30) user.End_Stun()
				spawn()
					if(!X)
						user.combat("There was no target")
						return
					else if(X)
						user.usemove=1
						var/inrange=(X in oview(user, 2))
						var/u = 0
						for(var/i=0; i<3; i++)
							sleep(5)
							if(X && user.usemove==1 && inrange)
								u++
								X.overlays += 'icons/slash.dmi'
								X = X.Replacement_Start(user)
								flick("w-attack",user)
								user.combat("[user] slashed [X] [u] Time(s)!")
								X.combat("[user] slashed [X] [u] Time(s)!")
							//	X.Wound(rand(15, 75), 1, user)
								X.Damage(((round(12.5*user.skillspassive[18])*rfx_mod)/100),round(rand(2,5)),0,user,"Instant Slash","Normal")

								spawn()Blood2(X,user)
								spawn()X.Hostile(user)
								spawn(5)if(X) X.Replacement_End()
								X.overlays -= 'icons/slash.dmi'

							else
								user.combat("[user] missed!")
								X.combat("[user] missed!")

						user.AppearMyDir(X)
			*			user.usemove = 0*/