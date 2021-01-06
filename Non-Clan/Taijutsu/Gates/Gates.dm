skill
	taijutsu
		gates //note that level, icon_time, overlay_icons and underlay_icons are now handled by Use() and not the skills
			// also, prev_gate is no longer used
			// gate1 and gate cancel are the only gates skills that get skill cards
			default_chakra_cost = 300
			default_cooldown = 400
			copyable = 0
			
			var
				level
				time_multiplier
				icon_time = 50
				prev_gate
				overlay_icons[]
				underlay_icons[]

			ChakraCost(mob/human/user)
				if(icon_state == "cancelgates")
					return 0
				if(user.gate && user.HasSkill(1290+user.gate*10))
					return ..(user)
				else
					return 0

			Cooldown(mob/human/user)
				if(user.gate && user.GetSkill(1290+user.gate*10))
					return 1
				else
					return ..(user)

			Use(mob/human/user)
				if(icon_state == "cancelgates")
					viewers(user) << output("[user] exhausts gate [user.gate].", "combat_output")
					user.CloseGates(cooldown=1)
					ChangeIconState("gate1")
					return 1
				else
					user.gate++
				var/curgate = user.gate
				var/overlay_icons
				var/underlay_icons
				var/icon_time = 50
				switch(user.gate)
					if(1)
						viewers(user) << output("[user]: Opening Gate!", "combat_output")
						user.overlays += 'icons/gatepower.dmi'
					if(2)
						viewers(user) << output("[user]: Energy Gate!", "combat_output")
						overlay_icons = list('icons/rockslifting.dmi')
						spawn(10) user.curstamina = user.stamina
					if(3)
						viewers(user) << output("[user]: Life Gate!", "combat_output")
						overlay_icons = list('icons/gate3chakra.dmi')
						user.icon = 'icons/base_m_gates.dmi'
					if(4)
						viewers(user) << output("[user]: Pain Gate!", "combat_output")
						overlay_icons = list('icons/gate3chakra.dmi')
						underlay_icons = list(/obj/gatesaura/bl, /obj/gatesaura/br, /obj/gatesaura/tl, /obj/gatesaura/tr)
						icon_time = 30
					if(5)
						viewers(user) << output("[user]: Limit Gate!", "combat_output")
						overlay_icons = list('icons/gate5.dmi')
						icon_time = 5
					if(6)
						viewers(user) << output("[user]: View Gate!", "combat_output")
						overlay_icons = list('icons/gate5.dmi')
						icon_time = 5
					if(7)
						viewers(user) << output("[user]: Wonder Gate!", "combat_output")
						overlay_icons = list('icons/gate5.dmi')
						icon_time = 5
					if(8)
						viewers(user) << output("[user]: Death Gate!", "combat_output")
						overlay_icons = list('icons/gate5.dmi')
						icon_time = 5
				user.RecalculateStats()
				if(overlay_icons)
					for(var/I in overlay_icons)
						user.overlays += I
						spawn(icon_time)
							user.overlays -= I
				if(underlay_icons)
					for(var/I in underlay_icons)
						user.underlays += I
						spawn(icon_time)
							user.underlays -= I
				if(user.clan == "Youth")
					user.curchakra=user.chakra
				if(user.HasSkill(1290+user.gate*10+10))
					ChangeIconState("gate[user.gate+1]")
				else
					ChangeIconState("cancelgates")
				spawn( ((user.str+user.rfx)*time_multiplier)/2 )
					if(user && user.gate==curgate)
						viewers(user) << output("[user] exhausts gate [user.gate].", "combat_output")
						user.CloseGates(cooldown=1)
						ChangeIconState("gate1")





			one
				id = GATE1
				name = "Opening Gate"
				description = "Opens the first limiter gate, increasing your power at the cost of internal damage over time."
				icon_state = "gate1"
				level = 1
				time_multiplier = 4
				cost = 1500

			two
				id = GATE2
				prev_gate = GATE1
				name = "Energy Gate"
				description = "Opens the second limiter gate, refreshing your stamina and allowing you to avoid being knocked down at the cost of internal damage over time."
				icon_state = "gate2"
				level = 2
				time_multiplier = 3
				overlay_icons = list('icons/rockslifting.dmi')
				noskillbar = 1
				cost = 1000
				skill_reqs = list(GATE1)

			three
				id = GATE3
				prev_gate = GATE2
				name = "Life Gate"
				description = "Opens the third limiter gate, further increasing your power, increasing your maximum stamina at the cost of internal damage over time."
				icon_state = "gate3"
				level = 3
				time_multiplier = 2.5
				overlay_icons = list('icons/gate3chakra.dmi')
				noskillbar = 1
				cost = 1250
				skill_reqs = list(GATE2)

			four
				id = GATE4
				prev_gate = GATE3
				name = "Pain Gate"
				description = "Opens the fourth limiter gate, further increasing your power and allowing you to move faster than the eye can see. (35% chance to teleport in front of your target)"
				icon_state = "gate4"
				level = 4
				time_multiplier = 2
				overlay_icons = list('icons/gate3chakra.dmi')
				underlay_icons = list(/obj/gatesaura/bl, /obj/gatesaura/br, /obj/gatesaura/tl, /obj/gatesaura/tr)
				icon_time = 30
				noskillbar = 1
				cost = 2000
				skill_reqs = list(GATE3)

			five
				id = GATE5
				prev_gate = GATE4
				name = "Limit Gate"
				description = "Opens the fifth limiter gate, further increasing your power and speed. (50% chance to teleport in front of your target)"
				icon_state = "gate5"
				level = 5
				time_multiplier = 1.5
				overlay_icons = list('icons/gate5.dmi')
				icon_time = 5
				noskillbar = 1
				cost = 1500
				skill_reqs = list(GATE4)

			six
				id = GATE6
				prev_gate = GATE5
				name = "View Gate"
				description = "Opens the sixth limiter gate, further increasing your power and speed. (65% chance to teleport in front of your target)"
				icon_state = "gate6"
				level = 6
				time_multiplier = 1.5
				overlay_icons = list('icons/gate5.dmi')
				icon_time = 5
				noskillbar = 1
				cost = 1500
				skill_reqs = list(GATE5)

			seven
				id = GATE7
				prev_gate = GATE6
				name = "Wonder Gate"
				description = "Opens the seventh limiter gate, further increasing power and speed. (75% chance to teleport in front of your target)"
				icon_state = "gate7"
				level = 7
				time_multiplier = 1
				overlay_icons = list('icons/gate5.dmi')
				icon_time = 5
				noskillbar = 1
				cost = 1250
				skill_reqs = list(GATE6)

			eight
				id = GATE8
				prev_gate = GATE7
				name = "Death Gate"
				description = "Opens the eighth limiter gate, further increasing your power and speed. (90% chance to teleport in front of your target)"
				icon_state = "gate8"
				level = 8
				time_multiplier = 1
				overlay_icons = list('icons/gate5.dmi')
				icon_time = 5
				noskillbar = 1
				cost = 3000
				skill_reqs = list(GATE7)

		gate_cancel
			id = GATE_CANCEL
			name = "Gate Cancel"
			description = "Releases gates."
			icon_state = "cancelgates"
			displayskill=0

			IsUsable(mob/human/user)
				if(!user.gate)
					Error(user, "Not actively using gates")
					return 0
				else
					return 1

			Use(mob/human/user)
				viewers(user) << output("[user] exhausts gate [user.gate].", "combat_output")
				user.CloseGates(cooldown=1)


		morning_peacock
			id = MORNING_PEACOCK
			name = "Morning Peacock"
			description = "Morning Peacock description required"
			default_stamina_cost = 500
			default_cooldown = 300
			stamina_damage_fixed = list(0, 0)
			stamina_damage_con = list(0, 0)
			icon_state = "morning_peacock"
			cost = 1800
			skill_reqs = list(GATE6)

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.gate < 6)
						Error(user, "View Gate required")
						return 0

			Use(mob/human/user)
				viewers(user) << output("[user]: Morning Peacock!", "combat_output")
				var/mob/human/etarget = user.NearestTarget()
				user.FaceTowards(etarget)
				var/xdir = user.dir
				var/turf/t = get_step(user,xdir)
				var/obj/projectile/p = new/obj/projectile(get_step(t,xdir))
				p.icon = 'icons/hosenka.dmi'
				p.pixel_x -= 16
				p.pixel_y -= 16


				user.icon_state = "Chakra"
				sleep(5)
				user.Timed_Stun(40)
				user.icon_state = ""
				p.icon_state = "ExplosionF"
				for(var/i=5,i>0,i--)
					flick("PunchA-1",user)
					sleep(2)
					flick("Explosion",p)
					flick("PunchA-2",user)
					sleep(2)
					for(var/mob/m in ohearers(1,p))
						m.Damage(400+user.str,rand(3,6),user,"Morning Peacock","Normal")
						m.Timed_Move_Stun(8)
				p.loc = null


mob/proc
	CloseGates(cooldown=1)
		if(!src || !src.gate) return
		var/gateclosed = src.gate
		src.gate=0
		if(cooldown && src.client)
			var/mob/human/M = src
			var/skill/taijutsu/gates/s = M.GetSkill(GATE1)
			s.ChangeIconState("gate1")
			spawn() s.DoCooldown(M)
		src.Load_Overlays()
		spawn(10)
			if(src.curstamina>src.stamina)
				src.curstamina=src.stamina
			if(gateclosed >= 6)
				src.strbuff = 0
				src.rfxbuff = 0
				src.strneg = src.str*0.5
				src.rfxneg = src.rfx*0.5
				spawn(600)
					src.strneg = 0
					src.rfxneg = 0
			else
				src.strbuff=0
				src.rfxbuff=0
			if(gateclosed == 7)
				src.Damage(5000,"",src,"Gate Stress","Internal")
			else if(gateclosed == 8)
				src.Damage(24000,300,src,"Gate Stress","Internal")
			src.underlays=0
			src.Affirm_Icon()
			src.Hostile(src)
			src.RecalculateStats()