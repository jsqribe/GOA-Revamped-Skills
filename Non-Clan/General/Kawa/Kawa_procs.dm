mob/var/tmp/exploding_log = 0
mob/human/
	Replacement_Start(mob/user)
		if(replacement_active)
			replacement_active = 0

			var/mob/human/player/npc/replace_log = new /mob/human/player/npc/replacement_log(loc)
			spawn() replace_log.CreateName(255, 255, 255)

			if(user)

				var/ico = user.icon
				var/list/over = user.overlays.Copy()

				replace_log.name = user.name
				replace_log.faction = user.faction
				replace_log.icon = ico
				replace_log.icon_state = user.icon_state
				replace_log.overlays = over
				replace_log.exploding_log = user.exploding_log

				usemove = 0

				spawn() user.FilterTargets()
				var/active = 0
				for(var/i in 1 to user.active_targets.len)
					if(user.active_targets[i] == src)
						user.active_targets[i] = replace_log
						active = 1
						user << replace_log.name_img
						user << replace_log.active_target_img
				for(var/i in 1 to user.targets.len)
					if(user.targets[i] == src)
						user.targets[i] = replace_log
						if(!active)
							user << replace_log.name_img
							user << replace_log.target_img


				if(user in targeted_by)
					targeted_by -= user

					if(user.client)
						user.client.images -= active_target_img
						user.client.images -= target_img
						user.client.images -= name_img

					spawn() user.AddTarget(src, active=0, silent=1)

			loc = replacement_loc
			Reset_Stun()
			for(var/obj/trigger/kawa_icon/T in triggers)
				if(T) RemoveTrigger(T)
			return replace_log
		else
			return src
mob/proc
	Replacement_Start(mob/user)
		return

	Replacement_End(state="kawa")
		return