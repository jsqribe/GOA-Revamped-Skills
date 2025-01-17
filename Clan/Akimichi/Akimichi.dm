mob/var/Partial=0
skill
	akimichi
		copyable = 0

		akimichi_clan
			id = AKIMICHI_CLAN
			icon_state = "doton"
			name = "Akimichi"
			description = "Akimichi Clan Jutsu."
			stack = "false"//don't stack
			clan=1
			canbuy=0

		spinach_pill
			id = SPINACH_PILL
			name = "Spinach Pill"
			description = "A green pill. Eating it increases your strength and stamina regen, but you start taking internal damage."
			icon_state = "spinach"
			default_chakra_cost = 0
			default_cooldown = 5
			cost = 800
			skill_reqs = list(AKIMICHI_CLAN)

			Use(mob/human/user)
				if(user.gate)
					user.combat("[usr] closes the gates.")
					user.CloseGates()
				if(user.pill<1)
					user.pill=1
					user.RecalculateStats()
					oviewers(user) << output("[user] ate a green pill!", "combat_output")
					user.combat("You ate the Spinach Pill! Your strength is greatly enhanced, but the strain on your body will cause damage.")
					spawn()
						var/timer = 0
						var/time_limit = 3000
						while(user && user.pill && timer < time_limit)
							user.PillsCheck()
							sleep(10)
							timer += 10
						if(user && user.pill==1)
							user.pill=0
							user.combat("The Spinach Pill wore off")
							user.strbuff=0
							user.RecalculateStats()




		curry_pill
			id = CURRY_PILL
			name = "Curry Pill"
			description = "A yellow pill. Eating it increases your strength and stamina regen even higher, but you start taking significant internal damage."
			icon_state = "curry"
			default_chakra_cost = 0
			default_cooldown = 5
			cost = 1200
			skill_reqs = list(SPINACH_PILL)


			Use(mob/human/user)
				if(user.gate)
					user.combat("[usr] closes the gates.")
					user.CloseGates()
				if(user.pill<=1)
					user.pill=2
					user.RecalculateStats()
					oviewers(user) << output("[user] ate a yellow pill!", "combat_output")
					user.combat("You ate the Curry Pill! You have gained super human strength and a great resistance to damage. However, the strain on your body is immense!")
					user.overlays+='icons/Chakra_Shroud.dmi'
					spawn()
						var/timer = 0
						var/time_limit = 1500
						while(user && user.pill==2 && timer < time_limit)
							user.PillsCheck()
							sleep(10)
							timer += 10
						if(user && user.pill==2)
							user.pill=1
							user.combat("The Curry Pill wore off")
							user.overlays-='icons/Chakra_Shroud.dmi'
							user.strbuff=0
							timer = 0
							time_limit = 1500
							user.RecalculateStats()
							while(user && user.pill==1 && timer < time_limit)
								user.PillsCheck()
								sleep(10)
								timer += 10
								if(user && user.pill==1)
									user.pill=0
									user.combat("The Spinach Pill wore off")
									user.strbuff=0
									user.RecalculateStats()

		peper_pill
			id = PEPPER_PILL
			name = "Pepper Pill"
			description = "A red pill. Eating it increases your body strenght, making all attacks do 50% less damage but you start taking significant internal damage and if you get koed you will get 200 wounds automatically."
			icon_state = "peper"//check lolol
			default_chakra_cost = 0
			default_cooldown = 5
			cost = 2000
			skill_reqs = list(CURRY_PILL)


			Use(mob/human/user)
				if(user.gate)
					user.combat("[usr] closes the gates.")
					user.CloseGates()
				if(!user.HasSkill(BUTTERFLY_BOMBING))
					user.AddSkill(BUTTERFLY_BOMBING)
				if(user.pill<=2)
					user.pill=3
					user.RecalculateStats()
					oviewers(user) << output("[user] ate a red pill!", "combat_output")
					user.combat("You ate the Peper Pill! You have gained super human strength and a great resistance to damage. However, the strain on your body is immense!")
					user.overlays+='icons/Chakra_Shroud.dmi'
					user.overlays+=image('icons/Butterfly Aura.dmi',icon_state="0,0",pixel_x=-16,pixel_y=-16,layer=FLOAT_LAYER)
					spawn()
						var/timer = 0
						var/time_limit = 1000
						while(user && user.pill==3 && timer < time_limit)
							user.PillsCheck()
							sleep(10)
							timer += 10
						if(user && user.pill==3)
							user.pill=1
							user.combat("The Peper Pill wore off")
							user.overlays-='icons/Chakra_Shroud.dmi'
							user.overlays+=image('icons/Butterfly Aura.dmi',icon_state="0,0",pixel_x=-16,pixel_y=-16,layer=FLOAT_LAYER)
							user.strbuff=0
							user.Damage(0, rand(150, 200), null, "KO", "Internal")
							timer = 0
							time_limit = 1000
							user.RecalculateStats()
							while(user && user.pill==1 && timer < time_limit)
								user.PillsCheck()
								sleep(10)
								timer += 10
								if(user && user.pill==1)
									user.pill=0
									user.combat("The Spinach Pill wore off")
									user.strbuff=0
									user.RecalculateStats()
								if(user && user.pill==2)
									user.pill=0
									user.combat("The Curry Pill wore off")
									user.strbuff=0
									user.conbuff=0
									user.RecalculateStats()

		size_partial
			id = PARTIAL
			name = "Partial Size Up"
			description = "Increases your size. Although you become slower, your punches reach farther and do more damage."
			icon_state = "sizeup1"
			default_chakra_cost = 400
			default_cooldown = 200
			cost = 800
			skill_reqs = list(AKIMICHI_CLAN)


			EstimateStaminaDamage(mob/user)
				return list(round((user.str+user.strbuff)*2) + 800, round((user.str+user.strbuff)*4) + 800)


			ChakraCost(mob/user)
				if(!user.Size)
					return ..(user)
				else
					return 0


			Cooldown(mob/user)
				if(!user.Size)
					return ..(user)
				else
					return 0


			Use(mob/human/user)
				if(user.scalpol)
					var/skill/MP = user.GetSkill(MYSTICAL_PALM)
					if(MP) MP.Use(user)
				if(user.Size == 1)
					user.Size=0
					user.Akimichi_Revert()
					ChangeIconState("sizeup1")
				user.overlays+='icons/BunBun.dmi'
				user.Partial = 1
				spawn(1200)
					if(user)
						user.overlays-='icons/BunBun.dmi'
						user.Partial = 0

		size_multiplication
			id = SIZEUP1
			name = "Size Multiplication"
			description = "Increases your size. Although you become slower, your punches reach farther and do more damage."
			icon_state = "sizeup1"
			default_chakra_cost = 400
			default_cooldown = 200
			cost = 1500
			skill_reqs = list(AKIMICHI_CLAN)


			EstimateStaminaDamage(mob/user)
				return list(round((user.str+user.strbuff)*2) + 800, round((user.str+user.strbuff)*4) + 800)


			ChakraCost(mob/user)
				if(!user.Size)
					return ..(user)
				else
					return 0


			Cooldown(mob/user)
				if(!user.Size)
					return ..(user)
				else
					return 0


			Use(mob/human/user)
				if(user.scalpol)
					var/skill/MP = user.GetSkill(MYSTICAL_PALM)
					if(MP) MP.Use(user)
				if(user.Size == 1)
					user.Size=0
					user.Akimichi_Revert()
					ChangeIconState("sizeup1")
				else
					if(user.gate)
						user.combat("[user] closes the gates.")
						user.CloseGates()
					if(length(usr.iSizeup1)>2)
						user.icon_state="Seal"
						sleep(50)
						user.layer=MOB_LAYER+2.1
						user.icon_state=""
						for(var/OX in usr.iSizeup1)
							user.overlays+=OX
						user.Size=1
						user.icon=0
					else
						user.layer=MOB_LAYER+2.1
						user.Akimichi_Grow(64)
						user.Size=1
					ChangeIconState("sizedown")

					spawn(1200)
						if(user)
							user.Size=0
							user.Akimichi_Revert()
							ChangeIconState("sizeup1")




		super_size_multiplication
			id = SIZEUP2
			name = "Super Size Multiplication"
			description = "Greatly increases your size. Although you become much slower, your punches reach farther and do extreme damage."
			icon_state = "sizeup2"
			default_chakra_cost = 500
			default_cooldown = 200
			cost = 2000
			skill_reqs = list(SIZEUP1)



			EstimateStaminaDamage(mob/user)
				return list(round((user.str+user.strbuff)*3) + 800, round((user.str+user.strbuff)*5.5) + 800)


			ChakraCost(mob/user)
				if(!user.Size)
					return ..(user)
				else
					return 0


			Cooldown(mob/user)
				if(!user.Size)
					return ..(user)
				else
					return 0


			Use(mob/human/user)
				if(user.scalpol)
					var/skill/MP = user.GetSkill(MYSTICAL_PALM)
					if(MP) MP.Use(user)
				if(user.Size == 2)
					user.Size=0
					user.Akimichi_Revert()
					ChangeIconState("sizeup2")
				else
					if(user.gate)
						user.combat("[user] closes the gates.")
						user.CloseGates()
					if(length(usr.iSizeup2)>2)
						user.icon_state="Seal"
						sleep(50)
						user.layer=MOB_LAYER+2.1
						user.icon_state=""
						for(var/OX in usr.iSizeup2)
							user.overlays+=OX
						user.Size=2
						user.icon=0
					else
						user.layer=MOB_LAYER+2.1
						user.Akimichi_Grow(96)
						user.Size=2
					ChangeIconState("sizedown")

					spawn(1200)
						if(user)
							user.Size=0
							user.Akimichi_Revert()
							ChangeIconState("sizeup2")




		human_bullet_tank
			id = MEAT_TANK
			name = "Human Bullet Tank"
			description = "Although you cannot stop moving in this state, you can roll over your enemies!"
			icon_state = "meattank"
			default_chakra_cost = 300
			default_cooldown = 30
			cost = 600
			skill_reqs = list(AKIMICHI_CLAN)


			EstimateStaminaDamage(mob/user)
				return list((user.str+user.strbuff-user.strneg)+400, (user.str+user.strbuff-user.strneg)*3 + 400)


			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.Size)
						Error(user, "An incompatible skill is active")
						return 0


			Use(mob/human/user)
				if(user.gate)
					user.combat("[src] closes the gates.")
					user.CloseGates()
				user.overlays=0
				user.icon=0
				user.Tank=1
				user.overlays+=image('icons/meattank.dmi',pixel_x=-16)

				var/tanklength = 150
				while(user && !user.ko && !user.asleep && user.Tank && tanklength>0)
					step(user,user.dir)
					sleep(10)
					tanklength -= 10
					user.CombatFlag("offense")

				if(user)
					user.Tank=0
					user.Affirm_Icon()
					user.Load_Overlays()

		bullet_butterfly_bombing
			id = BUTTERFLY_BOMBING
			name = "Bullet Butterfly Bombing"
			icon_state = "butterfly_bombing"
			default_chakra_cost = 1000
			default_cooldown = 400
			cost = 2500
			skill_reqs = list(SIZEUP2)
			displayskill=0

			var
				tmp
					stam_cost
					chakra_cost

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.pill != 3)
						Error(user, "You must eat the Pepper Pill to use this Jutsu")
						return 0
					/*
					if(user.RankGrade2()!=5)
						Error(user, "You must be S rank to use this Jutsu")
						return 0
					*/


			Use(mob/human/user)
				user<<"You have charged up Bullet Butterfly Bombing, hit A to release a devastating blow!"

				stam_cost=round(user.curstamina*0.25,1)
				chakra_cost=round(user.curchakra,1)
				user.Damage(stam_cost,3)
				user.curchakra-=chakra_cost

				user.overlays+='icons/aki_fist.dmi'

				user.butterfly_bombing=1

