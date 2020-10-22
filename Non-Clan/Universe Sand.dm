var/sand/iron_mass/iron_mass
var/sand/gaara_mass/gaara_mass

skill
	universe
		copyable = 0
		proc
			Sand_Mass(mob/user)
				if(user && user.HasSkill("sand_mass"))
					var/skill/skill = user.GetSkill("sand_mass")
					return skill:sand_mass
		sand_mass
			name = "Sand Mass"
			icon = 'mouse_sand_mass.dmi'
			id = sand_mass2
			var/sand/sand_mass/sand_mass


			Use(mob/user)

				if(!sand_mass)
					sand_mass = new(user.loc)
					sand_mass.owner = user
					walk_towards(sand_mass,user,1.5)
					user << "Defend to activate Sand Shield."

				else if(sand_mass)
					del sand_mass

			proc
				Sand_Shield(mob/user)
					var/sand/sand_mass/sand_mass = Sand_Mass(user)

					if(!sand_mass || sand_mass.loc != user.loc)
						return

					spawn()

						flick("sdomeForm",sand_mass)

						sleep(8)

						if(!user) return

						user.protected++

						while(user && user.isguard && sand_mass)
							sand_mass.icon_state = "sdome"
							CHECK_TICK

						if(user)
							user.protected--

						if(sand_mass)
							sand_mass.icon_state = ""


		iron_mass
			name = "Iron Mass"
			icon = 'mouse_sand_mass.dmi'
			id = iron_mass2


			Use(mob/user)

				if(!iron_mass)
					user.ironmass = 1
					iron_mass = new(user.loc)
					iron_mass.owner = user
					user.AC+=30
					walk_towards(iron_mass,user,1.5)
				//	user << "Defend to activate Sand Shield."

				else if(iron_mass)
					user.ironmass = 0
					user.AC-=30
					del iron_mass


		sand_shuriken
			name = "Sand Shuriken"
			icon = 'mouse_sand_shuriken.dmi'
			id = sand_shuriken2
			default_cooldown = 5


			Use(mob/user)
				var
					pellets = 5
					spread = 20
					dest = get_steps(user, user.dir, 50)

				FireSpread(user, dest, /sand/sand_shuriken, pellets, spread)

		sand_coffin
			name = "Sand Coffin"
			icon = 'mouse_sand_coffin.dmi'
			id = sand_coffin2
			default_cooldown = 40

			IsUsable(mob/user)
				.=..()
				if(.)
					if(!Sand_Mass(user))
						Error(user,"No Sand Mass Found.")
						return 0

					if(!user.MainTarget())
						Error(user, "No Target")
						return 0

			Use(mob/user)
				var
					speed = 2
					steps = 25
					sand/sand_mass/sand_mass = Sand_Mass(user)
					mob/enemy = user.MainTarget()

				spawn()

					walk(sand_mass,0)

					while(user && enemy && sand_mass && steps)

						step_towards(sand_mass,enemy)
						steps--

						if(sand_mass.loc == enemy.loc)
							break

						sleep(speed)

					if(enemy && sand_mass)
						if(sand_mass.loc == enemy.loc)
							enemy.frozen++
							sand_mass.icon_state = "burial"

							sleep(20)

							if(sand_mass)
								sand_mass.icon_state = "crush"

							if(user && enemy)
								var/damage = round((rand(95, 105)/100)*(user.con - (0.75 * enemy.con)))
								enemy.Damage(damage)
								enemy.screenShake(10, 16)

							sleep(10)

							if(enemy)
								enemy.frozen--

							del sand_mass


					if(sand_mass)
						walk_towards(sand_mass,user,1.5)
/*		sand_eye
			name = "Sand Eye"
			icon = 'mouse_sand_eye.dmi'
			id = sand_eye
			default_cooldown = 20

			IsUsable(mob/user)
				.=..()
				if(.)
					if(user.sight_)
						Error(user,"This skill is already active.")
						return 0
					if(user.shadow_use)
						return 0

			Use(mob/user)
				var/to_destination
				if(user.combat.target)
					to_destination = user.Search(user.combat.target)

				var/duration = 50

				new/sand/sand_eye(user.loc, user, duration, to_destination)*/

		sand_shower
			name = "Sand Shower"
			icon = 'mouse_sand_shower.dmi'
			id = sand_shower
			default_cooldown = 20

/*			IsUsable(mob/user)
				.=..()
				if(.)
					if(!Sand_Mass(user))
						Error(user,"No Sand Mass Found.")
						return 0*/


			Use(mob/user)

				user.frozen++
				user.icon_state = "katon"

				var/sand/sand_mass/sand_mass = Sand_Mass(user)

				sand_mass.dir = user.dir

				for(var/num = 1 to 10)

					var
						pellets = 5
						spread = 15
						dest = get_steps(user, user.dir, 50)

					FireSpread(user, dest, /sand/sand_shower, pellets, spread)

					sleep(3)

				if(user)
					user.frozen--
					user.icon_state = ""

				del sand_mass



/*mob
	Logout()
		if(HasSkill("sand_mass"))
			var/skill/skill = GetSkill("sand_mass")
			del skill:sand_mass

		..()*/


		earth_dumpling
			name = "Earth Dumpling"
			icon = 'mouse_earth_dumpling.dmi'
			id = earth_dumpling2
			default_chakra_cost = 10
			default_seal_time = 1
			default_cooldown = 40


			Use(mob/user)
				user.dir = dir2cardinal(user.dir)

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
							enemy.Damage(damage,user)

						step(earth_dumpling,earth_dumpling.dir)

						tiles--

						CHECK_TICK

					del earth_dumpling

		lightning_step
			name = "Lightning Step"
			icon = 'mouse_raik.dmi'
			id = lightning_step2
			default_chakra_cost = 0
			default_cooldown = 10

			Use(mob/user)


				for(var/steps = 1 to 4)

					var
						old_loc = user.loc
						mob/enemy = locate() in get_step(user,user.dir)

					step(user,user.dir)

					if(old_loc == user.loc && enemy)
						user.loc = enemy.loc
						var/damage = round((rand(152, 201)/100)*(user.con - (0.40 * enemy.con)))
						enemy.Damage(damage,user)


					if(old_loc != user.loc)
						var/lightning/lightning_step/lightning_step = new(old_loc)
						lightning_step.dir = user.dir

				user.frozen++
				sleep(2)
				if(user)
					user.frozen--

		water_fang
			name = "Water Fang"
			icon = 'mouse_suiga.dmi'
			id = water_fang2
			default_chakra_cost = 200
			default_cooldown = 25

			IsUsable(mob/user)
				.=..()
				if(.)
					if(!user.MainTarget())
						Error(user, "No Target")
						return 0


			Use(mob/user)
				new/water/water_fang(user)


/*		chidori_current
			id = chidori_current
			name = "Chidori Current"
			icon = 'mouse_dome.dmi'
			default_cooldown = 60

			Use(mob/human/user)
				world.log << "Used Current"
				user << "Used Current"
				oviewers(user) << output("[user] create a current of lightning!", "combat_output")
				var/obj/b1=new/obj/chidori_current(locate(user.x,user.y,user.z))
			//	user.AddOverlays(/lightning/chidori_current)

				var
					time = 4

				charge2 = 1

				spawn()
					while(user && charge)
						for(var/mob/enemy in circle(2,user))
							if(enemy != user)
								var/damage = round((rand(95, 105)/100)*(user.con - (0.70 * enemy.con)))
								enemy.Damage(damage,user)


								enemy.frozen++
								spawn(5)
									if(enemy)
										enemy.frozen--

						sleep(5)

			//	user.Begin_Stun()

				while(user && time > 0 && charge)
					user.icon_state = "Throw2"
					time -= 0.1
					CHECK_TICK

				if(user)
			//		user.End_Stun()
					user.icon_state = ""
					del(b1)
				//	user.RemoveOverlays(/lightning/chidori_current)
*/

sand
	parent_type = /projectiles

	sand_mass
		icon = 'sandblob.dmi'
		pixel_x = -32
		pixel_y = -32
		animate_movement = SLIDE_STEPS
		layer = MOB_LAYER + 0.1

		Move(location,direction)

			loc = location
			dir = direction

			if(owner)
				if(owner:z != z)
					loc = owner:loc


			if(!owner)
				del src

	iron_mass
		icon = 'magnetblob.dmi'
		pixel_x = -32
		pixel_y = -32
		animate_movement = SLIDE_STEPS
		layer = MOB_LAYER + 0.1

		Move(location,direction)

			loc = location
			dir = direction

			if(owner)
				if(owner:z != z)
					loc = owner:loc


			if(!owner)
				del src

	gaara_mass
		icon = 'sandblob.dmi'
		pixel_x = -32
		pixel_y = -32
		animate_movement = SLIDE_STEPS
		layer = MOB_LAYER + 0.1

		Move(location,direction)

			loc = location
			dir = direction

			if(owner)
				if(owner:z != z)
					loc = owner:loc


			if(!owner)
				del src

	sand_shuriken
		icon = 'sand1.dmi'
		icon_state = "sshuriken"

		Hit(atom/A)
			var
				mob
					enemy = A
					user = owner

			if(ismob(user) && ismob(enemy))
				//if(user.combat && enemy.combat)
				//	user.combat.target(enemy)
				var/damage = round((rand(95, 105)/100)*(user.con - (0.75 * enemy.con)))
				enemy.Damage(damage)
				enemy.screenShake(5, 10)

			del src

/*	sand_eye
		parent_type = /sight
		icon = 'sand_eye.dmi'

		New(loc, player/owner_, duration = 10)
			spawn()
				..(loc,owner_,duration)

			flick("sandeye",src)
			spawn(8)
				icon_state = "sandeyef"*/

	sand_shower
		icon = 'sand1.dmi'
		icon_state = "shigure"

		Hit(atom/A)
			var
				mob
					enemy = A
					user = owner

			if(ismob(user) && ismob(enemy))
			//	if(user.combat && enemy.combat)
				//	user.combat.target(enemy)
				var/damage = round((rand(95, 105)/100)*(user.con - (0.75 * enemy.con)))
				enemy.Damage(damage)
				enemy.screenShake(5, 10)

				del src

earth
	parent_type = /projectiles
	earth_dumpling
		icon = 'earth3.dmi'
		layer = MOB_LAYER
		density = 1
		pixel_x = -32
		pixel_y = -32

		Move(loc,dir)
			if(icon_state != "roll")
				return
			..()

water
	parent_type = /projectiles
	water_fang
		icon = 'water2.dmi'
		pixel_x = -32
		pixel_y = -32
		New(mob/mob)
			owner = mob

			var
				mob
					user = owner
					enemy = user.MainTarget()
				enemy_loc = enemy.loc

			loc = locate(enemy.x,enemy.y,enemy.z)

			flick("fang",src)

			sleep(4)

			if(user && enemy && enemy.loc == enemy_loc)
				icon_state = "fang2"
				var/damage =round((rand(45, 55)/100)*(user.con))
				enemy.Damage(damage,user)
				sleep(5)

			del src

lightning
	parent_type = /projectiles
	lightning_step
		icon = 'raiton.dmi'
		icon_state = "wtrail"

		New(location)
			loc = location

			flick("lstep",src)

			spawn(6)
				del src

	shadow_step
		icon = 'raiton.dmi'
		icon_state = "shadow"

		New(location)
			loc = location

			flick("shadow",src)

			spawn(6)
				del src

/*lightning
	parent_type = /projectiles*/
obj
	chidori_current
		icon = 'icons/raiton4.dmi'
		pixel_x = -64
		pixel_y = -64
		layer = MOB_LAYER + 0.1