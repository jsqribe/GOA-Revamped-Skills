
skill
	soul
		copyable = 0

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
				if(user.con >= 200) size = 5
				if(user.con >= 250) size = 6
				if(user.con >= 300) size = 7
				if(user.con >= 350) size = 8
				if(user.con >= 400) size = 9
				if(user.con >= 450) size = 10

				if(etarget)
					SwampField(user, etarget.loc, size=size, delay=3)
				else
					user.icon_state = "Swamp"
					SwampField(user, user.loc, size=size, delay=3)


		water_clone
			id = WATER_CLONE
			name = "Clone"
			description = "Creates a water clone to do god knows what."
			icon_state = "bunshin"
			default_chakra_cost = 10
			default_cooldown = 30



			Use(mob/user)
				if(!user.icon_state)
					flick(user,"Seal")

				var/ico
				var/list/over
				if(user.hiddenmist) //Dipic: Terrible work around is terrible
					user.hiddenmist=0
					user.Affirm_Icon()
					user.Load_Overlays()
					ico = user.icon
					over = user.overlays.Copy()
					user.HideInMist()
				else
					ico = user.icon
					over = user.overlays.Copy()

				var/mob/human/player/npc/waterclone/o = new/mob/human/player/npc/waterclone(locate(user.x,user.y,user.z))
				spawn(2)
					o.icon = ico
					o.overlays = over
					o.name = "[user.name]"
					o.bunshinowner = user.key
					o.faction = user.faction
					o.dir = user.dir
					o.mouse_over_pointer = user.mouse_over_pointer
					o.life = 30
					o.CreateName(255, 255, 255)

				Poof(o.x,o.y,o.z)

				user.BunshinTrick(list(o))

		vacuum_sphere
			id = VACUUM_SPHERE
			name = "Wind Release: Vacuum Sphere"
			icon_state = "vacuum sphere"
			default_chakra_cost = 500
			default_cooldown = 100
			default_seal_time = 5
			description = "Shoots Wind Vacuum Spheres in all directions"


			Use(mob/human/user)

				var/eicon='icons/projectiles.dmi'
				var/estate="wind-m"

				if(!user.icon_state)
					user.icon_state="Seal"
					spawn(20)
						user.icon_state=""

				var/angle
				var/speed = 20
				var/spread = 18
				if(user.MainTarget()) angle = get_real_angle(user, user.MainTarget())
				else angle = dir2angle(user.dir)

				var/damage = 65*user.ControlDamageMultiplier()


				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*4, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*3, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*2, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*2, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*3, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*4, distance=10, damage=damage, wounds=2)

				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*7, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*6, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*5, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*5, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*6, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*7, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*10, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*8, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread*9, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle+spread, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*9, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*8, distance=10, damage=damage, wounds=2)
				spawn() advancedprojectile_angle(eicon, estate, usr, speed, angle-spread*10, distance=10, damage=damage, wounds=2)


		tearing_turrent
			id = TEARING_TURRENT
			name = "Suiton: Tearing Turrent"
			description = "Creates a small ball of highly concentrated chakra that rapidly expands when punched into an enemy."
			icon_state = "rasengan"
			default_chakra_cost = 300
			default_cooldown = 90
			stamina_damage_fixed = list(750, 750)
			stamina_damage_con = list(750, 750)



			Use(mob/human/player/user)
				viewers(user) << output("[user]: Rasengan!", "combat_output")
				user.Timed_Stun(10)
				var/obj/x = new(locate(user.x,user.y,user.z))
				x.layer=MOB_LAYER+1
				x.icon='icons/rasengan.dmi'
				x.dir=user.dir
				flick("create",x)
				user.overlays+=/obj/rasengan
				spawn(30)
					x.loc = null
				sleep(10)
				if(user && !user.ko)
					user.turrent=1
					user.combat("Press <b>A</b> to use Rasengan on someone. If you take damage it will dissipate!")
					user.on_hit.add(src, "Cancel")

		needle_umbrela
			id = NEEDLE_UMBRELA
			name = "Hidden Rain Skill: Needle Rain"
			description = "Throws an umbrela into the air and when activated with chakra it shoots needles"
			icon_state = ""
			default_chakra_cost = 90
			default_cooldown = 5

			var
				puppet_weap_num


			Use(mob/human/player/user)

				var/obj/umbrela/x=new/obj/umbrela(user.loc)
				var/ewoundmod=100
				var/eicon='icons/projectiles.dmi'
				var/estate="needle-m"
				var/angle
				var/spread = 8
				var/c=40
				x.layer=MOB_LAYER+13
				x.pixel_y += 10
				sleep(2)
				x.pixel_y += 10
				sleep(2)
				x.pixel_y += 10
				sleep(2)
				x.pixel_y += 10
				sleep(2)
				x.pixel_y += 10
				sleep(2)
				x.pixel_y += 10
				spawn(5)
					while(c>0)
						var/mob/etarget = user.MainTarget()
						if(etarget) angle = get_real_angle(src, etarget)
						else angle = dir2angle(x.dir)
						spawn() advancedprojectile_angle(eicon, estate, user, rand(14,32), pick(angle+spread*2,angle+spread,angle,angle-spread,angle-spread*2), distance=10, damage=ewoundmod, wounds=0, daze=0, radius=8, from=x)
						spawn() advancedprojectile_angle(eicon, estate, user, rand(14,32), pick(angle+spread*2,angle+spread,angle,angle-spread,angle-spread*2), distance=10, damage=ewoundmod, wounds=0, daze=0, radius=8, from=x)
						c--
						sleep(2)
						if(c==0)
							spawn(10)
								del(x)




obj/umbrela
	density=0
	icon='icons/Umbrela.dmi'

obj/tree_binding
	density=0
	icon='icons/tree5.dmi'
	pixel_x = -70
	pixel_y = -20

mob/human/player/npc
	waterclone
		auto_ai = 0
		initialized=1
		protected=0
		ko=0



		var
			bunshinowner=1
			bunshintype=0
			life=60



		New()
			..()
			spawn()
				while(src.life>0)
					sleep(10)
					src.life--

				if(src.invisibility<=2)
					Poof(src.x,src.y,src.z)
				src.invisibility=4
				src.targetable=0
				src.density=0
				spawn(50)
					loc = null


		Dec_Stam()
			return


		Wound()
			return


		Hostile(mob/human/player/attacker)
			. = ..()
			if(bunshintype == 0)
				var/distance = get_dist(src, attacker)
				if(distance < 3)
					var/mob/human/cought
				//	var/turf/getloc //02.02.16 J
					var/obj/wp = new/obj
					wp.dir = attacker.dir
					wp.icon = 'icons/water_prison.dmi'
					wp.icon_state = "start"
					spawn(4)
						wp.icon_state = "capturing"
						spawn(5)
							wp.icon_state = "captured"
					wp.pixel_x -= 32
					wp.pixel_y -= 32
					wp.layer = MOB_LAYER

					cought=attacker.Replacement_Start(attacker)
					wp.loc = cought.loc
					if(cought != attacker)
						wp.loc = null
						attacker.icon_state=""
						spawn(5) if(cought) cought.Replacement_End()
						return
					//var/turf/getloc = locate(attacker.x,attacker.y,attacker.z)

					attacker.FaceTowards(cought)
					attacker.Timed_Stun(5)
					attacker.water_prison = 1
					attacker.usemove = 1
					attacker.FaceTowards(cought)
					cought.water_prison = 2
					cought.Begin_Stun()
					cought.icon_state = "Hurt"
					cought.Hostile(attacker)
					//spawn() Poof(x, y, z)
					invisibility = 100
					loc = null
					targetable = 0
					density = 0
					// Didn't this just happen two lines above? Not even a sleep to give other stuff a chance to mess it up.
					targetable = 0
					loc = null
					sleep(100)
					wp.loc = null
					cought.End_Stun()
				else
					spawn() Poof(x, y, z)
					invisibility = 100
					loc = null
					targetable = 0
					density = 0
					// Didn't this just happen two lines above? Not even a sleep to give other stuff a chance to mess it up.
					targetable = 0
					loc = null

					//	del(src)

var/doingit=0

mob/human/proc
	SwampDmg(mob/u)
		src.Damage(35000*4/src.str)
		src.Timed_Move_Stun(1)
		src.UsrOnSwamp=1
		spawn()src.Hostile(u)
		sleep(15)
		src.UsrOnSwamp=0

mob/human/proc
	GenDmg1(mob/u)
		src.Damage(500)
		src.Timed_Move_Stun(10)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()src.Hostile(u)

	GenDmg2(mob/u)
		src.Damage(1000)
		src.Timed_Move_Stun(10)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()src.Hostile(u)

	GenDmg3(mob/u)
		src.Damage(1500)
		src.Timed_Move_Stun(10)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()src.Hostile(u)

	GenDmg4(mob/u)
		src.Damage(2000)
		src.Timed_Move_Stun(10)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()src.Hostile(u)

	GenDmg5(mob/u)
		src.Damage(2500)
		src.Timed_Move_Stun(10)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()Blood2(src,u)
		spawn()src.Hostile(u)


	Turrent_Fail()
		src.turrent=0
		src.overlays-=/obj/rasengan
		src.overlays-=/obj/rasengan2
		var/obj/o=new/obj(locate(src.x,src.y,src.z))
		o.layer=MOB_LAYER+1
		o.icon='icons/rasengan.dmi'
		flick("failed",o)
		spawn(50)
			o.loc = null
	Turrent_Hit(mob/x,mob/human/u,xdir)
		x = x.Replacement_Start(u)
		u.overlays-=/obj/rasengan
		u.overlays-=/obj/rasengan2
		u.turrent=0
		var/conmult= u.ControlDamageMultiplier()
		x.cantreact=1
		spawn(30)	// Can we please not forget to make sure things are still valid after any sleep or spawn call.
			if(x)	x.cantreact=0
		var/obj/o=new/obj(locate(x.x,x.y,x.z))
		o.icon='icons/rasengan.dmi'
		o.layer=MOB_LAYER+1
		if(!x.icon_state)
			x.icon_state="hurt"

		flick("hit",o)

		x.Earthquake(10)
		x.Damage(750+750*conmult, 0, u, "Rasengan", "Normal")
		spawn(50)
			o.loc = null
		sleep(10)
		if(x)
			x.Knockback(10,xdir)
			if(x)
				explosion(50,x.x,x.y,x.z,u,1)
				x.Timed_Stun(30)
				if(!x.ko)
					x.icon_state=""
				x.Hostile(u)
			spawn(5) if(x) x.Replacement_End()


mob/var/turrent=0

