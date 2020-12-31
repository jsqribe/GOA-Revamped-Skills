mob
	Resurrection
		icon = 'icons/reanimation2.dmi'
		icon_state = ""
		density=1
		New()
			spawn(150)
				if(src)
					del(src)

		interact="Talk"
		verb
			Talk()
				set src in oview(1)
				set hidden=1
				alert(usr,"Your Reanimation Jutsu is incomplete!.")
				return 0

mob/proc
	UnMole(mob/human/user)
		var/obj/s = new/obj(locate(user.x,user.y,user.z))
		s.icon = 'icons/mole_hiding_technique.dmi'
		s.icon_state = "Deactivate"
		s.layer = MOB_LAYER + 0.1
		s.pixel_x -= 16
		s.pixel_y -= 16
		spawn(10) s.loc = null
		user.Timed_Stun(3)
		sleep(3)
		var/obj/h = new/obj(locate(user.x,user.y,user.z))
		h.icon = 'icons/mole_hiding_technique.dmi'
		h.icon_state = "Hole"
		h.layer = TURF_LAYER + 0.1
		h.pixel_x -= 16
		h.pixel_y -= 16
		spawn(100) h.loc = null
		user.mole=0
		user.density=1
		user.Affirm_Icon()
		user.Load_Overlays()
		var/skill/mole = user.GetSkill(DOTON_MOLE_HIDING)
		mole.ChangeIconState("Mole_Hiding")
mob/human/proc
	Crush(mob/u)
		if(src.shukaku==1 || src.yonbi==1)
			src.Damage(4200,rand(15,30),u,"Doton: Earth Split", "Normal")
		else
			src.Damage(4000,rand(15,30),u,"Doton: Earth Split", "Normal")
		spawn()Blood2(src,u)
		spawn()src.Hostile(u)


/*mob/var/Combat/combat= null

earth
	wall
		parent_type = /mob
		New(loc)
			..(loc)
			combat = new(src)

		Move(loc,dir)

	earth_wall
		icon = 'earth2.dmi'
	//	health = 200
	//	temp = 1
		parent_type = /mob

		New(loc)
			..(loc)
			combat = new(src)
		Move(loc,dir)

	giant_earth_wall
		icon = 'earth3.dmi'
	//	health = 2000
	//	temp = 1
		parent_type = /mob
		pixel_x = -32

		var
			earth
				giant_earth_wall
					part_one
					part_two
		New(loc)
			..(loc)
			combat = new(src)

		Move(loc,dir)

		Del()

			del(part_one)
			del(part_two)

			..()

		proc
			sides()
				part_one = new(get_step(src,turn(dir, 90)))
				part_two = new(get_step(src,turn(dir, -90)))

				part_one.icon = null
				part_two.icon = null

				part_one.combat = combat
				part_two.combat = combat


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
*/