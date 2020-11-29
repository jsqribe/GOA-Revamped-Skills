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