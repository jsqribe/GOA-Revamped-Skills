skill
	body_replacement
		id = KAWARIMI
		name = "Body Replacement"
		description = "Prepares you for a quick escape."
		icon_state = "kawarimi"
		default_chakra_cost = 50
		default_cooldown = 25

/*		IsUsable(mob/user)
			. = ..()
			if(.)
				if(user.keys["shift"]) //shift modifies this jutsu to have it target yourself, so having no target is OK
					modified = 1
					return 1*/

		Use(mob/user)
			/*if(user.z == 40)
				return*/
			user.combat("Body Replacement is now active. If you are hit during the next <b>10 seconds</b>, you will be teleported back to the location the skill was activated on.")
			user.replacement_active = 1
			user.replacement_loc = user.loc
			//default_cooldown = 45
			if(user.HasSkill(EXPLODING_KAWARIMI))
				var/skill/EK = user.GetSkill(EXPLODING_KAWARIMI)
				for(var/skillcard/card in EK.skillcards)
					card.overlays -= 'icons/dull.dmi'
				spawn() EK.DoCooldown(user)
/*			spawn()
				for(var/skill/sk in user.skills)
					if(sk.id == EXPLODING_KAWARIMI)
						sk.DoCooldown(user,resume=1,passthrough=1)
						break*/
			spawn(100)
				user.replacement_active = 0

	exploding_body_replacement
		id = EXPLODING_KAWARIMI
		name = "Exploding Body Replacement"
		description = "Prepares you for a quick escape, leaving an explosive tag behind."
		icon_state = "exploding_kawarimi"
		default_chakra_cost = 50
		default_supply_cost = 15
		default_cooldown = 25
		stamina_damage_fixed = list(2000, 2000)
		stamina_damage_con = list(0, 0)


		Use(mob/user)
			user.combat("Exploding Body Replacement is now active. If you are hit during the next <b>10 seconds</b>, you will be teleported back to the location the skill was activated on.")
			user.replacement_active = 1
			user.exploding_log = 1
			user.replacement_loc = user.loc
			//default_cooldown = 45
			if(user.HasSkill(KAWARIMI))
				var/skill/EK = user.GetSkill(KAWARIMI)
				for(var/skillcard/card in EK.skillcards)
					card.overlays -= 'icons/dull.dmi'
				spawn() EK.DoCooldown(user)
			spawn(100)
				user.replacement_active = 0
				user.exploding_log = 0