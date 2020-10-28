mob
	proc
		Hostile(mob/human/player/attacker)
			if(attacker && faction && attacker.faction && (faction.village != attacker.faction.village || faction.village == "Missing"))
				spawn() register_opponent(attacker)
				spawn() attacker.register_opponent(src)

			if(phenged)
				// There's a proc somewhere to unhenge people right? I know at least three places that do it...
				if(faction) mouse_over_pointer = faction_mouse[faction.mouse_icon]
				name = realname
				phenged = 0
				// TODO: Poof should REALLY just take a loc argument.
				spawn() Poof(x,y,z)
				overlays=0
				// Why is there a : here?
				src:CreateName(255, 255, 255)
				// And this. WTF. We DO have this whole 'rebuild icon' proc thing right? It's not even handling overlays for NPCs. (Not that any current NPC ever uses transform.)
				var/mob/example=new src.type()
				icon=example.icon
				example.loc = null

			if(using_crow)
				//using_crow = 0
				Protect(20)

				flick("Form", src)

				sleep(10)

				if(!src) return

				AppearBehind(attacker)

				flick("Reform", src)

			// Actually there's so much stuff in this proc I think we'd be better of with a full event-handler so we can just register a bunch
			// of separate callbacks as needed for things. Like these cancel-skill things.
			var/dont //Dipic: sloppy
			if(chambered)
				for(var/obj/earthcage/cage in loc)
					if(cage.owner == src)
						dont=1
			if(!dont) usemove = 0
			// Or this 'make an NPC stop following you' thing.
			if(leading)
				leading.stop_following()
				//leading.following = 0
				//leading = 0
			// And all these type-specific things.
			if(istype(src,/mob/human/player/npc))
				if(attacker && attacker!=src && attacker.faction && src.faction && attacker.faction.village != src.faction.village && !(attacker.MissionTarget==src && (attacker.MissionType=="Escort"||attacker.MissionType=="Escort PvP")))
					if(!istype(attacker,/mob/human/player/npc/creep) && !(istype(attacker, /mob/human/player/npc) && src:nisguard))
						spawn() src:AI_Target(attacker)
			// And... ANOTHER tranform revert? Huh. (What IS the difference... oh, phenged is puppet isn't it.)
			if(src.henged)
				henged = 0
				mouse_over_pointer = faction_mouse[faction.mouse_icon]
				name = realname
				spawn() Poof(x, y, z)
				src:CreateName(255, 255, 255)
				Affirm_Icon()
				Load_Overlays()

			// Also this sleeping thing.
			if(sleeping)
				// TODO: CSS-ify this message.
				combat("You were startled awake!")
				sleeping = 0

			// Yay checking types.
			if(istype(src,/mob/human/npc))
				return

			if(istype(src,/mob/human/sandmonster))
				var/mob/human/sandmonster/xi = src
				xi.hp--
				src.lasthostile = xi.ownerkey
				if(xi.hp <= 0)
					xi.loc = null
				return

			if(attacker && attacker != src && !ko && curstamina > 0)
				if(istype(attacker, /mob/human/player/npc/kage_bunshin))
					var/mob/human/player/npc/kage_bunshin/a = attacker
					src.lasthostile = a.ownerkey
				else
					src.lasthostile = attacker.key
					if(attacker.client)
						attacker.CombatFlag("offense")
			if(src && src.client)
				src.CombatFlag("defense")
			// Isn't asleep up farther?
			if(asleep)
				asleep = 0
				icon_state = ""

			on_hit.send(src, attacker)

			/* NEED TO REWRITE THIS WHOLE THING AT SOME POINT
			// ...Must...stop...repeating...village...checks...
			if(attacker && attacker.client && faction && attacker.faction && faction.village!=attacker.faction.village && !alertcool)
				alertcool = 180
				var/onit = 0
				var/list/options = new /list()
				for(var/turf/x in oview(8, src))
					if(!x.density)
						options += x


				if(length(options))
					spawn()
						for(var/mob/human/player/npc/OMG in world)
							if(!OMG.client && OMG.z==z && onit < 2)
								// TODO: I think this sleep should be a spawn or something. This loop must be really slow otherwise.
								// ...In fact, that slowness is probably the cause a bunch of the guard issues.
								//spawn(200)
								CHECK_TICK
								if(OMG && attacker && OMG.z == attacker.z)
									var/turf/nextt = pick(options)
									options -= nextt
									if(OMG.nisguard && OMG.faction.village == faction.village && attacker && !(istype(attacker, /mob/human/player/npc) && attacker:nisguard))
										onit++
										OMG.AppearAt(nextt.x, nextt.y, nextt.z)
										spawn() OMG.AI_Target(attacker)
										if(get_dist(attacker, OMG) > 10)
											walk_to(OMG, attacker, 4, 1)

										spawn()
											var/eie = 0
											while(attacker && OMG && get_dist(attacker, OMG) > 20 && eie < 10)
												eie++
												step_to(OMG, src, 4)
												sleep(5)
											if(OMG)
												walk(OMG, 0)
											spawn() if(OMG && attacker) OMG.AI_Target(attacker)
											if(OMG && attacker && get_dist(attacker, OMG) > 10)
												if(OMG.z == attacker.z)
													OMG.AppearAt(attacker.x, attacker.y, attacker.z)
				*/