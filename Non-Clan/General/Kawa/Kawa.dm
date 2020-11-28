skill

	body_replacement
		id = KAWARIMI
		name = "Body Replacement"
		description = "Prepares you for a quick escape."
		icon_state = "kawarimi"
		default_chakra_cost = 50
		default_cooldown = 60



		Use(mob/user)
			user.combat("Body Replacement is now active. If you are hit during the next <b>10 seconds</b>, you will be teleported back to the location the skill was activated on.")
			user.replacement_active = 1
			user.replacement_loc = user.loc
			var/obj/trigger/kawa_icon/T = new/obj/trigger/kawa_icon
			T.user=user
			user.AddTrigger(T)
			spawn()
				for(var/skill/sk in user.skills)
					if(sk.id == EXPLODING_KAWARIMI)
						sk.DoCooldown(user,resume=1,passthrough=1)
						break
			spawn(100)
				if(user)
					user.replacement_active = 0
					if(T) user.RemoveTrigger(T)


	exploding_body_replacement
		id = EXPLODING_KAWARIMI
		name = "Exploding Body Replacement"
		description = "Prepares you for a quick escape, leaving an explosive tag behind."
		icon_state = "exploding_kawarimi"
		default_chakra_cost = 50
		default_supply_cost = 15
		default_cooldown = 120
		stamina_damage_fixed = list(2000, 2000)
		stamina_damage_con = list(0, 0)


		DoCooldown(mob/user, resume = 0, passthrough = 0)
			var/alreadycoolingdown //used to reset the cooldown while the skill is cooling down
			if(cooldown) alreadycoolingdown = 1

			if(passthrough)
				cooldown = default_cooldown/2
			if(alreadycoolingdown) return
			..()

		Use(mob/user)
			user.combat("Exploding Body Replacement is now active. If you are hit during the next <b>10 seconds</b>, you will be teleported back to the location the skill was activated on.")
			user.replacement_active = 1
			user.exploding_log = 1
			user.replacement_loc = user.loc
			var/obj/trigger/kawa_icon/T = new/obj/trigger/kawa_icon
			T.user=user
			user.AddTrigger(T)
			spawn()
				for(var/skill/sk in user.skills)
					if(sk.id == KAWARIMI)
						sk.DoCooldown(user,resume=1,passthrough=1)
						break
			spawn(100)
				if(user)
					user.replacement_active = 0
					user.exploding_log = 0
					if(T) user.RemoveTrigger(T)
