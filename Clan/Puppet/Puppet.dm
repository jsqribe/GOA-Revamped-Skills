skill
	puppet
		copyable = 0


		puppet_clan
			id = PUPPET_CLAN
			icon_state = "doton"
			name = "Puppet"
			description = "Puppet Clan Jutsu."
			stack = "false"//don't stack
			clan=1
			canbuy=0

		puppet_summoning
			default_cooldown = 60
			description = "Summons a puppet with hidden weapons."



			var
				puppet_num



			Cooldown(mob/user)
				var/puppet_var = "Puppet[puppet_num]"
				var/mob/human/Puppet/puppet = user.vars[puppet_var]
				if(!puppet)
					return ..(user)
				else
					return 0


			Use(mob/human/user)
				viewers(user) << output("[user]: [src]!", "combat_output")
				var/puppet_var = "Puppet[puppet_num]"
				var/mob/human/Puppet/puppet = user.vars[puppet_var]
				if(!puppet && user.Puppets.len >= puppet_num && user.Puppets[puppet_num])
					var/obj/items/Puppet/P1=user.Puppets[puppet_num]
					switch(puppet_num)
						if(1) P1.icon = 'icons/puppet1.dmi'
						if(2) P1.icon = 'icons/puppet2.dmi'
					var/typ = P1.summon
					Poof(user.x,user.y,user.z)
					puppet = new typ(user.loc)
					puppet.rfx = user.rfx
					puppet.realname = P1.name
					puppet.name = P1.name
					puppet.owner = user
					puppet.faction = user.faction
					puppet.CreateName(255, 255, 255)
					P1.incarnation = puppet
					user.vars[puppet_var] = puppet
					spawn() puppet.PuppetRegen(user)
					user.puppetsout++
				else if(puppet)
					Poof(puppet.x,puppet.y,puppet.z)
					del(puppet)
					user.puppetsout--




			first
				id = PUPPET_SUMMON1
				name = "Summoning: First Puppet"
				icon_state = "puppet1"
				puppet_num = 1




			second
				id = PUPPET_SUMMON2
				name = "Summoning: Second Puppet"
				icon_state = "puppet2"
				puppet_num = 2




		puppet_transform
			id = PUPPET_HENGE
			name = "Puppet Transform"
			description = "Transforms your puppet so it looks like you."
			icon_state = "puppethenge"
			default_chakra_cost = 50
			default_cooldown = 25



			IsUsable(mob/user)
				. = ..()
				if(.)
					if(!user.Primary)
						Error(user, "Must be directly controlling a puppet")
						return 0



			Use(mob/human/user)
				viewers(user) << output("[user]: Puppet Transform!", "combat_output")
				if(user.Primary)
					var/mob/human/puppet = user.Primary
					if(!puppet.icon_state)
						flick(puppet,"Seal")
					Poof(puppet.x,puppet.y,puppet.z)

					puppet.icon=user.icon
					puppet.realname=puppet.name
					puppet.name=user.name
					puppet.overlays=user.overlays
					puppet.mouse_over_pointer=user.mouse_over_pointer
					if(!istype(user, /mob/human/npc))
						puppet.transform_chat_icon = user.faction.chat_icon
					else
						puppet.transform_chat_icon = null
					puppet.phenged=1
					spawn(1200)//recover
						if(puppet && puppet.phenged)
							puppet.mouse_over_pointer=faction_mouse[puppet.faction.mouse_icon]
							puppet.name=puppet.realname
							puppet.phenged=0
							Poof(puppet.x,puppet.y,puppet.z)
							puppet.overlays=0
							puppet.icon=initial(puppet.icon)




		puppet_swap
			id = PUPPET_SWAP
			name = "Puppet Swap"
			description = "Switches your position with that of your puppet."
			icon_state = "puppetswap"
			default_chakra_cost = 100
			default_cooldown = 45



			IsUsable(mob/user)
				. = ..()
				if(.)
					var/list/valid=new
					if(user.Puppet1 && user.Puppet1.z==user.z && get_dist(user, user.Puppet1) <= 100)
						valid+=user.Puppet1
					if(user.Puppet2 && user.Puppet2.z==user.z && get_dist(user, user.Puppet2) <= 100)
						valid+=user.Puppet2
					if(!valid.len)
						Error(user, "No valid puppet")
						return 0



			Use(mob/human/user)
				viewers(user) << output("[user]: Puppet Swap!", "combat_output")
				var/list/valid=new
				if(user.Puppet1 && user.Puppet1.z==user.z)
					valid+=user.Puppet1
				if(user.Puppet2 && user.Puppet2.z==user.z)
					valid+=user.Puppet2
				if(length(valid))
					var/mob/sw=pick(valid)
					Poof(user.x,user.y,user.z)
					var/turf/Tq=user.loc
					user.loc=sw.loc
					sw.loc=Tq
					walk(sw,0)
					user.client.eye=sw
					user.Primary=sw
					user.controlmob=sw


		human_puppet
			id = HUMAN_PUPPET
			name = "Human Puppet"
			icon_state = "human_puppet"
			default_chakra_cost = 800
			default_cooldown = 600


			IsUsable(mob/user)
				. = ..()
				if(.)
					/*
					if(user.RankGrade2()!=5)
						Error(user, "You must be S rank to use this Jutsu")
						return 0
					*/
					if(user.human_puppet)
						Error(user, "You are already using this Jutsu")
						return 0


			Use(mob/user)
				user.human_puppet=1
				user.Affirm_Icon()
				if(!user.HasSkill(PUPPET_WEAPON_1))
					user.AddSkill(PUPPET_WEAPON_1)
				if(!user.HasSkill(PUPPET_WEAPON_2))
					user.AddSkill(PUPPET_WEAPON_2)
				if(!user.HasSkill(PUPPET_WEAPON_3))
					user.AddSkill(PUPPET_WEAPON_3)
				if(!user.HasSkill(PUPPET_WEAPON_4))
					user.AddSkill(PUPPET_WEAPON_4)
				if(!user.HasSkill(PUPPET_WEAPON_5))
					user.AddSkill(PUPPET_WEAPON_5)
				if(!user.HasSkill(PUPPET_WEAPON_6))
					user.AddSkill(PUPPET_WEAPON_6)
				user.RefreshSkillList()






		puppet_weapons
			default_cooldown = 20



			var
				puppet_weap_num

			IsUsable(mob/user)
				. = ..()
				if(.)
					/*
					if(user.RankGrade2()!=5)
						Error(user, "You must be S rank to use this Jutsu")
						return 0
					*/
					if(!user.human_puppet)
						Error(user, "You must be using the Human Puppet Technique to use this Jutsu")
						return 0

			Use(mob/human/user)
				user.PuppetSkill(puppet_weap_num,user)


			first
				id = PUPPET_WEAPON_1
				name = "Hidden Knife Shot (H)"
				icon_state = "mouthknife"
				puppet_weap_num = 1

			second
				id = PUPPET_WEAPON_2
				name = "Poison Bomb (H)"
				icon_state = "poisonbomb"
				puppet_weap_num = 2

			third
				id = PUPPET_WEAPON_3
				name = "Flamethrower (H)"
				icon_state = "puppetflame"
				puppet_weap_num = 8

			fourth
				id = PUPPET_WEAPON_4
				name = "Poison Tipped Blade (H)"
				icon_state = "mild-poison"
				puppet_weap_num = 4

			fifth
				id = PUPPET_WEAPON_5
				name = "Needle Gun (H)"
				icon_state = "needlegun"
				puppet_weap_num = 5

			sixth
				id = PUPPET_WEAPON_6
				name = "Chakra Shield (H)"
				icon_state = "chakrashield"
				puppet_weap_num = 6

