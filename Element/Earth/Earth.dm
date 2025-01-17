skill
	earth
		copyable = 1
		element_reqs = list("Earth")

		doton_element
			id = DOTON_ELEMENT
			icon_state = "doton"
			name = "Earth: Element Control"
			description = "Allows you to control the earth element and use defensive jutsu."
			stack = "false"//don't stack
			element=1

		iron_skin
			id = DOTON_IRON_SKIN
			name = "Earth: Iron Skin"
			description = "Hardens your skin, reducing the damage you take from most jutsu."
			icon_state = "doton_iron_skin"
			default_chakra_cost = 150
			default_cooldown = 240
			//SkillTree
			cost = 1800
			skill_reqs = list(DOTON_ELEMENT)

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.ironskin)
						Error(user, "Earth: Iron Skin or Larch Dance is already active.")
						return 0
					if(user.human_puppet==2 || user.itachisusano || user.sasukesusano || user.madarasusano)
						Error(user, "Cannot Activate")
						return 0


			Use(mob/human/user)
				if(user.boneharden)
					var/skill/BH = user.GetSkill(BONE_HARDEN)
					BH.Use(user)
					BH.DoCooldown(user)
				viewers(user) << output("[user]: Earth: Iron Skin!", "combat_output")
				if(user.playergender=="male")
					user.icon='icons/base_m_stoneskin.dmi'
				else
					user.icon='icons/base_m_stoneskin.dmi'
				user.ironskin=1
				user.Affirm_Icon()
				spawn(300 + round(50*user.ControlDamageMultiplier()))
					if(user)
						user.reIcon()
						user.ironskin=0
						user << output("Iron Skin has worn off", "combat_output")
						user.Affirm_Icon()

		earth_wall
			id = EARTH_WALL
			name = "Doton: Earth Wall"
			icon_state = "EWLL"
			default_chakra_cost = 50
			default_seal_time = 7
			description = "A earth wall comes out of the ground and protects everyone behind it(Idea By Aggripec)"
			default_cooldown = 120
			cost = 1000
			skill_reqs = list(DOTON_IRON_SKIN)

			Use(mob/user)
				if(user.Earth_Wall==1)
					viewers(user) << output("[user] claps his hands!", "combat_output")
					for(var/obj/EarthWall/V in world)
						if(V.OwnedBy2==user)
							user.EWalls-=1
							del(V)
					user.EWalls=0
					user.Earth_Wall=0
				else
					viewers(user) << output("[user] puts his hands to the ground!", "combat_output")
					user<<"Click any turf, and earth wall will begin to form!"
					user.Earth_Wall=1
					default_cooldown = 1


/*
		dungeon_chakra_dome
			id = DOTON_CHAKRA_DOME
			name = "Earth: Chakra absorb"
			icon_state = "chakradome"
			default_chakra_cost = 650
			default_cooldown = 100
			default_seal_time = 3

			Use(mob/human/user)
				user.stunned=5
				user.icon_state="Throw2"
				viewers(user) << output("[user]: Earth: Chakra Absorb!", "combat_output")
				for(var/obj/earthcage/o in oview(8))
					o.icon='icons/chakradome.dmi'
				var/mob/gotcha=0
				var/turf/getloc=0
				for(var/mob/human/eX in get_step(user,user.dir))
					if(!eX.ko && !eX.protected)
						eX.overlays+='icons/chakradome.dmi'
						eX.move_stun=35
						gotcha=eX
						getloc=locate(eX.x,eX.y,eX.z)
				while(gotcha && gotcha.loc==getloc && (abs(user.x-gotcha.x)*abs(user.y-gotcha.y))<=5)
					CHECK_TICK
					user.stunned=5
					sleep(5)
					if(!gotcha) break
					var/conmult = user.ControlDamageMultiplier()
					gotcha.curchakra-= round(50*conmult)
					gotcha.Hostile(user)
					if(gotcha.curchakra<0)
						gotcha.overlays-='icons/chakradome.dmi'
						gotcha.curstamina=0
						gotcha=0

*/

		dungeon_chamber
			id = DOTON_CHAMBER
			name = "Earth: Dungeon Chamber of Nothingness"
			description = "Traps your enemy in a dome made of rock."
			icon_state = "Dungeon Chamber of Nothingness"
			default_chakra_cost = 100
			default_cooldown = 40
			default_seal_time = 10
			cost = 800
			skill_reqs = list(DOTON_ELEMENT)

			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.keys["shift"]) //shift modifies this jutsu to have it target yourself, so having no target is OK
						modified = 1
						return 1
					var/mob/human/player/etarget = usr.MainTarget()
					if(!etarget || (etarget && (etarget.chambered || etarget.IsProtected())))
						Error(user, "No Valid Target")
						return 0

			Use(mob/human/user)
				user.Timed_Stun(10)
				viewers(user) << output("[user]: Earth: Dungeon Chamber of Nothingness!", "combat_output")

				var/mob/human/player/etarget = user.MainTarget()
				if(modified) etarget = user
				if(etarget)
					etarget = etarget.Replacement_Start(user)
					var/ex=etarget.x
					var/ey=etarget.y
					var/ez=etarget.z
					spawn()Doton_Cage(ex,ey,ez,100)
					sleep(4)
					if(etarget && !etarget.kaiten)
						if(ex==etarget.x&&ey==etarget.y&&ez==etarget.z)
							etarget.Begin_Stun()
							etarget.chambered = 3000
							etarget.layer=MOB_LAYER-1
							var/alreadyended=0
							spawn()
								var/obj/earthcage/O
								for(var/obj/earthcage/o in view(0,etarget))
									O = o
									break
								while(etarget&&ex==etarget.x&&ey==etarget.y&&ez==etarget.z&&etarget.chambered&&!O.crumbled)
									sleep(1)
								if(etarget && O && !alreadyended && O.crumbled && !O.crushed)
									sleep(10)
									etarget.chambered = 0
									etarget.End_Stun()
									spawn(5) etarget.Replacement_End()
									alreadyended = 1
							spawn(100)
								if(etarget && !alreadyended)
									etarget.chambered = 0
									etarget.End_Stun()
									spawn(5) if(etarget) etarget.Replacement_End()
									alreadyended = 1
					else
						if(etarget && etarget.kaiten)
							for(var/obj/earthcage/o in view(0,etarget))
								o.icon='icons/dotoncagecrushed.dmi'
								o.crumbled = 1
				else
					Error(user, "No Valid Target")




		dungeon_chamber_crush
			id = DOTON_CHAMBER_CRUSH
			name = "Earth: Split Earth Revolution Palm"
			description = "Crushes the rock prison, dealing heavy damage to anyone inside it."
			icon_state = "doton_split_earth_turn_around_palm"
			default_chakra_cost = 250
			default_cooldown = 100
			default_seal_time = 5
			stamina_damage_fixed = list(4000, 4000)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(25, 30)
			wound_damage_con = list(0, 0)
			cost = 1500
			skill_reqs = list(DOTON_CHAMBER)

			IsUsable(mob/user)
				. = ..()
				if(.)
					var/found
					for(var/obj/earthcage/o in oview(8))
						if(o.owner == user && !(o.crushed || o.crumbled))
							found = 1
					if(!found)
						Error(user, "No Valid Target")
						return 0

			Use(mob/human/user)
				spawn() user.Timed_Stun(30)
				viewers(user) << output("[user]: Earth: Split Earth Revolution Palm!", "combat_output")

				for(var/obj/earthcage/o in oview(8))
					if(o.owner == user)

						if((o.crushed || o.crumbled))
							return

						o.icon_state = "Crush"
						for(var/mob/human/m in ohearers(0,o))
							m.chambered = 0
							m.Crush(user)
							m.End_Stun()
							m.Reset_Stun()
							o.crushed = 1


		sandhandtest
			id = sandhandtest
			name = "Earth: Earth Flow River"
			description = "Creates a river of mud, sweeping away anyone in its path."
			icon_state = "earthflow"
			default_chakra_cost = 400
			default_cooldown = 60
			default_seal_time = 5
			stamina_damage_fixed = list(250, 750)
			stamina_damage_con = list(250, 250)

			Use(mob/human/user)
				user.Timed_Stun(10)
				viewers(user) << output("[user]: Earth: Earth Flow River!", "combat_output")

				sleep(1)
				var/obj/trailmaker/Sand_Hand/o=new/obj/trailmaker/Sand_Hand(locate(user.x,user.y,user.z))
				o.density=0
				var/distance=15
				var/user_dir = user.dir
				while(o && distance>0 && user)
					//this should allow people to trigger kawarimi and escape
					for(var/mob/M in o.gotmob)
						if ((M.x!=o.x)||(M.y!=o.y))
							o.gotmob-=M

					if(!step(o, user_dir))
						break
					var/conmult = user.ControlDamageMultiplier()
					for(var/mob/human/player/M in o.loc)
						if(M!=user && !(M in o.gotmob) && !M.kaiten && !M.sandshield && !M.chambered && !M.IsProtected())
							M = M.Replacement_Start(user)
							o.gotmob+=M
							if(M.shukaku==1)
								M.Damage(rand(350,1050)+350*conmult,0,user, "Doton: Earth Flow", "Normal")
							else
								M.Damage(rand(250,750)+250*conmult,0,user, "Doton: Earth Flow", "Normal")
							spawn()M.Hostile(user)
							M.Begin_Stun()

					for(var/turf/T in get_step(o,user_dir))
						if(T.density)
							distance=1
					sleep(1)

					distance--
					for(var/mob/human/player/M in o.gotmob)
						if(M.shukaku==1)
							M.Damage((rand(70,140)+14*conmult), 0, user, "Doton: Earth Flow", "Normal")
						else
							M.Damage(rand(50,100)+10*conmult, 0, user, "Doton: Earth Flow", "Normal")
						spawn()M.Hostile(user)
				for(var/mob/human/player/M in o.gotmob)
					M.End_Stun()
					spawn(5) M.Replacement_End()
				o.loc = null



		earth_flow_river
			id = DOTON_EARTH_FLOW
			name = "Earth: Earth Flow River"
			description = "Creates a river of mud, sweeping away anyone in its path."
			icon_state = "earthflow"
			default_chakra_cost = 400
			default_cooldown = 60
			default_seal_time = 5
			stamina_damage_fixed = list(250, 750)
			stamina_damage_con = list(250, 250)
			cost = 1900
			skill_reqs = list(DOTON_ELEMENT)

			Use(mob/human/user)
				user.Timed_Stun(10)
				viewers(user) << output("[user]: Earth: Earth Flow River!", "combat_output")

				var/obj/O=new(locate(user.loc))
				O.icon='icons/earthflow.dmi'
				O.icon_state="overlay"
				O.dir=user.dir

				sleep(1)
				var/obj/trailmaker/Mud_Slide/o=new/obj/trailmaker/Mud_Slide(locate(user.x,user.y,user.z))
				o.density=0
				var/distance=15
				var/user_dir = user.dir
				while(o && distance>0 && user)
					//this should allow people to trigger kawarimi and escape
					for(var/mob/M in o.gotmob)
						if ((M.x!=o.x)||(M.y!=o.y))
							o.gotmob-=M

					if(!step(o, user_dir))
						break
					var/conmult = user.ControlDamageMultiplier()
					for(var/mob/human/player/M in o.loc)
						if(M!=user && !(M in o.gotmob) && !M.kaiten && !M.sandshield && !M.chambered && !M.IsProtected())
							M = M.Replacement_Start(user)
							o.gotmob+=M
							if(M.shukaku==1 || M.yonbi==1)
								M.Damage(rand(350,1050)+350*conmult,0,user, "Doton: Earth Flow", "Normal")
							else
								M.Damage(rand(250,750)+250*conmult,0,user, "Doton: Earth Flow", "Normal")
							spawn()M.Hostile(user)
							M.Begin_Stun()

					for(var/turf/T in get_step(o,user_dir))
						if(T.density)
							distance=1
					sleep(1)

					distance--
					for(var/mob/human/player/M in o.gotmob)
						if(M.shukaku==1 || M.yonbi==1)
							M.Damage((rand(70,140)+14*conmult), 0, user, "Doton: Earth Flow", "Normal")
						else
							M.Damage(rand(50,100)+10*conmult, 0, user, "Doton: Earth Flow", "Normal")
						spawn()M.Hostile(user)
				for(var/mob/human/player/M in o.gotmob)
					M.End_Stun()
					spawn(5) M.Replacement_End()
				O.loc = null
				o.loc = null

		fly
			id = FLY
			name = "Earth: Levitate"
			description = "Uses chakra to levitate above the ground and fly around."
			copyable = 0
			icon_state = "Mole_Hiding"
			default_chakra_cost = 300
			default_cooldown = 120
			default_seal_time = 10

			DoSeals(mob/human/user)
				user.usemove = 1
				..(user)

			ChakraCost(mob/user)
				if(user.Fly)
					return 0
				else
					return ..(user)

			Cooldown(mob/user)
				if(user.Fly)
					return 1
				else
					return ..(user)


			Use(mob/human/user)
				if(user.Fly)
					user.pixel_y-=32
					user.Fly = 0
					user.density = TRUE
					user.layer = 0
				else
					user.Timed_Stun(13)
					user.icon_state = "Seal"
					sleep(3)
					user.icon_state = null
					if(!user.ko && user.usemove)
						spawn(10) user.Reset_Stun() //necessary for using mole hiding from within your own chamber
						var/obj/h = new/obj(locate(user.x,user.y,user.z))
						h.icon = 'icons/mole_hiding_technique.dmi'
						h.icon_state = "Activate"
						h.layer = TURF_LAYER + 0.1
						h.pixel_x -= 16
						h.pixel_y -= 16
						spawn(100) h.loc = null
						user.Fly = 1
						user.camo = 0
						user.density = FALSE
						user.pixel_y+=32
						user.layer = 10
		mole_hiding
			id = DOTON_MOLE_HIDING
			name = "Earth: Mole Hiding"
			description = "Change earth into fine sand by channelling chakra into it, allowing you to dig through it like a mole."
			copyable = 0
			icon_state = "Mole_Hiding"
			default_chakra_cost = 300
			default_cooldown = 120
			default_seal_time = 10
			cost = 700
			skill_reqs = list(DOTON_ELEMENT)

			DoSeals(mob/human/user)
				user.usemove = 1
				..(user)

			ChakraCost(mob/user)
				if(user.mole)
					return 0
				else
					return ..(user)

			Cooldown(mob/user)
				if(user.mole)
					return 1
				else
					return ..(user)

			IsUsable(mob/human/user)
				if(..())
					if(Iswater(user.loc) && !user.mole)
						Error(user, "You are over water")
						return 0
					return 1

			Use(mob/human/user)
				viewers(user) << output("[user]: Earth: Mole Hiding!", "combat_output")
				if(user.mole)
					user.UnMole(user)
					return

				user.Timed_Stun(13)
				user.icon_state = "Seal"
				if(!user.chambered)
					var/obj/s = new/obj(locate(user.x,user.y,user.z))
					s.icon = 'icons/mole_hiding_technique.dmi'
					s.icon_state = "Activate"
					s.layer = MOB_LAYER + 0.1
					s.pixel_x -= 16
					s.pixel_y -= 16
					spawn(10) s.loc = null
				sleep(3)
				user.icon_state = null
				if(!user.ko && user.usemove)
					spawn(10) user.Reset_Stun() //necessary for using mole hiding from within your own chamber
					var/obj/h = new/obj(locate(user.x,user.y,user.z))
					h.icon = 'icons/mole_hiding_technique.dmi'
					h.icon_state = "Hole"
					h.layer = TURF_LAYER + 0.1
					h.pixel_x -= 16
					h.pixel_y -= 16
					spawn(100) h.loc = null
					user.mole = 1
					user.camo = 0
					user.density = 0
					user.icon = null
					user.overlays = null

					for(var/mob/human/H in user.targeted_by)
						switch(H.skillspassive[8])
							if(0)
								H.RemoveTarget(user)
							if(1)
								H.RemoveTarget(user)
							if(2)
								user.targeted_by -= H
								if(H.client)
									H.client.images -= user.active_target_img
									H.client.images -= user.target_img
									H.client.images -= user.name_img
								H.AddTarget(user, active=0, silent=1)

					ChangeIconState("Cancel_Mole_Hiding")
					user.combat("<font color=red>Because you were combat recently, your ability with this jutsu is limited. You have 20 seconds.</font>")
					user.mole = 2//used to stop regen rather than half it
					spawn(100)
						if(user && user.mole)
							user.UnMole(user)
							var/skill/mole = user.GetSkill(DOTON_MOLE_HIDING)
							spawn() mole.DoCooldown(user)

		head_hunter
			id = DOTON_HEAD_HUNTER
			name = "Earth: Head Hunter"
			description = "Drag your victim down into the earth, robbing them of their freedom."
			copyable = 0
			icon_state = "Head_Hunter"
			default_chakra_cost = 200
			default_cooldown = 180
		//	default_seal_time = 15
			cost = 1100
			skill_reqs = list(DOTON_MOLE_HIDING)

			IsUsable(mob/user)
				if(..())
					if(!user.mole)
						Error(user, "Must be used from underground")
						return 0
					var/mob/human/player/etarget = usr.MainTarget()
					if(!etarget)
						for(var/mob/m in get_step(user,user.dir))
							return 1
					else if(etarget.chambered || etarget.sandshield || etarget.mole || etarget.icon_state == "head")
						Error(user, "No Valid Target")
						return 0
					var/distance = get_dist(user, etarget)
					if(etarget && distance > 1)
						Error(user, "Target too far ([distance]/1 tiles)")
						return 0
					return 1

			Use(mob/human/user)
				viewers(user) << output("[user]: Earth: Head Hunter!", "combat_output")
				var/mob/human/player/etarget = usr.MainTarget()
			/*	if(!etarget)
					for(var/mob/m in get_step(user,user.dir))
						etarget = m
						break*/
				if(!etarget)
					//user.End_Stun()
					user.usemove=1
					sleep(10)
					if(!user.usemove)
						return
					user.usemove=0
					var/ei=7
					while(!etarget && ei>0)
						for(var/mob/human/o in get_step(user,user.dir))
							if(!o.ko&&!o.IsProtected())
								etarget=o
						ei--
						walk(user,user.dir)
						sleep(1)
						walk(user,0)


				if(etarget && etarget in hearers(1,user))
					if(etarget.icon_state == "head" || etarget.mole) return
					etarget = etarget.Replacement_Start(user)
					spawn(2) etarget.Replacement_End(state="head")
					etarget.Begin_Stun()
					var/obj/s = new/obj(locate(etarget.x,etarget.y,etarget.z))
					s.icon = 'icons/mole_hiding_technique.dmi'
					s.icon_state = "Activate"
					s.layer = MOB_LAYER + 0.1
					s.pixel_x -= 16
					s.pixel_y -= 16
					spawn(10) s.loc = null
					sleep(3)
					var/obj/h = new/obj(locate(etarget.x,etarget.y,etarget.z))
					h.icon = 'icons/mole_hiding_technique.dmi'
					h.icon_state = "Hole"
					h.layer = TURF_LAYER + 0.1
					h.pixel_x -= 16
					h.pixel_y -= 16
					spawn(200) if(h) h.loc = null
					etarget.dir = SOUTH
					etarget.icon_state = "head"
					etarget.Load_Overlays()
					etarget.pixel_y -= 18
					etarget.layer = OBJ_LAYER + 0.1
					etarget.Hostile(user)
					etarget.asleep = 1
					var/sleep_time = min(180,max(70,100 + (user.con - etarget.str)))
					spawn()
						while(etarget && (sleep_time > 0) && etarget.asleep && !etarget.ko)
							sleep_time--
							sleep(1)
						if(etarget)
							if(h) h.loc = null
							etarget.asleep=0
							etarget.End_Stun()
							etarget.icon_state=""
							etarget.Load_Overlays()
							etarget.pixel_y += 18
							etarget.layer = MOB_LAYER

		earth_dragon
			id = DOTON_EARTH_DRAGON
			name = "Earth Style: Earth Stone Dragon"
			icon_state = "earth_dragon"
			default_chakra_cost = 400
			default_cooldown = 90
			cost = 1100
			skill_reqs = list(DOTON_EARTH_FLOW)

			Use(mob/user)
				viewers(user) << output("[user]:<font color=#8A4117> Earth Release: Earth Dragon!", "combat_output")
				//user.stunned = 1
				user.icon_state = "Seal"
				spawn(10)
					user.icon_state = ""
				var/earth_dragon/earth = new(get_step(user,user.dir))
				earth.owner = user
				earth.dir = user.dir
				var/tiles = 50
				spawn()
					walk(earth, earth.dir, 1)
					while(user && tiles > 0)

						for(var/mob/human/O in view(1,earth))
							if(O != user && O)
								if(user.shukaku==1 || user.yonbi==1)
									O.Damage(230 * user:ControlDamageMultiplier(),0,user)
								else
									O.Damage(150 * user:ControlDamageMultiplier(),0,user)
								if(prob(20))
									O.Wound(rand(0,1),0,user)
								O.movepenalty += 10
								O.Hostile(user)
								if(O)
									O.Knockback(1,3)
						tiles--
						sleep(3)
					if(earth)
						earth.loc = null


		swamp_field
			id = DOTON_SWAMP_FIELD
			name = "Doton: Swamp Field"
			description = "Create a Swamp."
			icon_state = "doton_swamp_of_the_underworld"
			default_chakra_cost = 450
			//base_charge = 100
			stamina_damage_fixed = list(233.3, 2800)
			description = "Creates a swamp that slows and damages everyone in it"
			default_cooldown = 175
			default_seal_time = 30
			cost = 900
			skill_reqs = list (DOTON_EARTH_FLOW)



			Use(mob/human/user)
				viewers(user) << output("[user]:Doton Swamp Field!", "combat_output")
				user.icon_state="Seal"
				user.Timed_Stun(20)
				spawn(20)
					user.icon_state=""

				var/mob/human/player/etarget = user.MainTarget()
				var/size
				if(user.con >= 50) size = 3
				if(user.con >= 150) size = 4
				if(user.con >= 250) size = 5
				if(user.con >= 350) size = 6
				if(user.con >= 450) size = 7

				if(etarget)
					SwampField(user, etarget.loc, size=size, delay=3)
				else
					user.icon_state = "Swamp"
					SwampField(user, user.loc, size=size, delay=3)


		earth_shaking_palm
			id = DOTON_EARTH_SHAKING_PALM
			name = "Earth Release: Earth Shaking Palm"
			icon_state = "earth_palm"
			default_chakra_cost = 1000
			default_cooldown = 180
			default_seal_time = 4
			cost = 2000
			skill_reqs = list(DOTON_CHAMBER_CRUSH)

			Use(mob/human/user)
				viewers(user) << output("[user]:<font color=#8A4117> Earth Release: Earth Shaking Palm!", "combat_output")
				var/earth_damage = user.ControlDamageMultiplier()*5
				user.icon_state="Seal"
				spawn(15)
					user.icon_state=""
			//	user.stunned=2
			//	user.protected=4
				var/obj/x=new/obj/ground_destruction(user.loc)
				spawn()AOExk(user.x,user.y,user.z,3,earth_damage*user.blevel,6,user,0,1,1)
				for(var/mob/human/X in oview(3,user))
					if(X.mole)
						X.UnMole(X)
						sleep(1)
						X.Damage(X.stamina, 0, user, "Earth Shaking Palm", "Normal")

				spawn(5) del(x)


		doton_prison_dome
			id = DOTON_PRISON_DOME
			name = "Earth Release: Earth Prison Dome of Magnificent Nothingess"
			icon_state = "doton_chamber"
			default_chakra_cost = 1500
			default_cooldown = 300
			default_seal_time = 4
			cost = 1400
			skill_reqs = list(DOTON_CHAMBER)

			Use(mob/human/user)
				viewers(user) << output("[user]:<font color=#8A4117> Earth Release: Earth Prison Dome of Magnificent Nothingess!", "combat_output")

				var/time=0
				var/R=0
				var/conmult = user.ControlDamageMultiplier()
				var/mob/human/target = user.MainTarget()
				var/distance = get_dist(user, target)

				if(!target || distance > 1)
					user.combat("Target too far ([distance]/1 tiles) please get close to the target")
					user.stunned=5

					user.icon_state="Seal"
					spawn(5)	user.icon_state=""

					sleep(5)

					var/obj/X = new/obj/doton_shield(user.loc)

				//	user.protected=10
					user.larch=1
					time=5

					while(time > 0)
						sleep(10)
						//user.protected=10
						user.stunned+=1
						time--
					if(time<=0)
						user.larch=0
						user.stunned=0
					//	user.protected=0
						del(X)

				else
					user.stunned = 3
					user.icon_state = "Seal"
					spawn(5) user.icon_state=""

					var/obj/Z = new/obj/shield(target.loc)
					sleep(5)

					del(Z)

					var/obj/Y = new/obj/doton_shield(target.loc)
					time=pick(4,8)
					user.icon_state="Throw2"
					user.overlays+='icons/leech.dmi'
					user.dir=target.loc

					while(time > 0)
						sleep(10)
						target.stunned += 2
						user.stunned +=2
						R=rand(35,60)
						if(!target)
							del(Y)
							user.stunned=0
							target.stunned=0
							user.overlays-='icons/leech.dmi'
							user.icon_state=""
							break
						target.curchakra-= round(R*conmult)
						user.curchakra+=round(R*conmult)
						target.Hostile(user)
						time--
					if(target.curchakra<0)
						target.curstamina=0
						user.overlays-='icons/leech.dmi'
						user.icon_state=""
						del(Y)

					if(time<=0)
						del(Y)
						user.stunned=0
						target.stunned=0
						user.overlays-='icons/leech.dmi'
						user.icon_state=""

/*			earth_dumpling
				id = DOTON_STONE
				name = "Earth Dumpling"
				icon = 'mouse_earth_dumpling.dmi'
				default_chakra_cost = 10
				default_seal_time = 1
				default_cooldown = 40

				Use(mob/user)
				//	user.dir = dir2cardinal(user.dir)

					var/earth/earth_dumpling/earth_dumpling = new(get_step(user,user.dir))

					earth_dumpling.dir = user.dir

					flick("rise_flick",earth_dumpling)

					sleep(12)

					earth_dumpling.icon_state = "hold"

					sleep(4)

					if(earth_dumpling)
						earth_dumpling.icon_state = "roll"

					spawn()
						var/tiles = 20
						while(user && earth_dumpling && tiles)
							for(var/mob/enemy in earth_dumpling.dynamic_get_step(1))
								var/damage = round((rand(95, 105)/100)*(user.con - (0.70 * enemy.con)))
							//	enemy.combat.dealDamage(damage,user)

							step(earth_dumpling,earth_dumpling.dir)

							tiles--

							CHECK_TICK

						del earth_dumpling


			giant_earth_wall
				id = G_EARTH_WALL
				name = "Giant Earth Wall"
				icon = 'mouse_giant_earth_wall.dmi'
				default_chakra_cost = 10
				default_cooldown = 45


				Use(mob/user)
					var/earth/giant_earth_wall/giant_earth_wall = new

					giant_earth_wall.dir = user.dir

					giant_earth_wall.loc = get_step(user,user.dir)

					flick("wall_flick",giant_earth_wall)

					sleep(4)

					if(!user)
						del giant_earth_wall
						return

					var/time = 20 * 10 // 20 seconds

					giant_earth_wall.icon_state = "wall"

					for(var/mob/enemy in giant_earth_wall.loc)
						step_away(enemy,giant_earth_wall,1)

					if(giant_earth_wall.dir in list(SOUTH,NORTH))
						giant_earth_wall.sides()

					spawn(time)
						del giant_earth_wall

			earth_wall
				id = EARTH_WALL
				name = "Earth Wall"
				icon = 'mouse_earth_wall.dmi'
				default_chakra_cost = 10
				default_cooldown = 30


				Use(mob/user)
					var/earth/earth_wall/earth_wall = new

					earth_wall.dir = user.dir

					earth_wall.loc = get_step(user,user.dir)

					flick("wall_flick",earth_wall)

					sleep(6)

					if(!user)
						del earth_wall
						return

					earth_wall.icon_state = "wall"

					for(var/mob/enemy in earth_wall.loc)
						step_away(enemy,earth_wall,1)*/




