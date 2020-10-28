mob/human/clay
	var/power = 0
	var/mob/owner
	icon = 'icons/clay-animals.dmi'
	bird
		icon_state = "bird"

	paper_bomb

		icon = 'paper_bomb.dmi'
		icon_state = "1"

		layer = MOB_LAYER + 0.1
	owl
		New()
			src.overlays+=image('icons/clay_owl.dmi',icon_state = "1",pixel_x=0,pixel_y=0)
			src.overlays+=image('icons/clay_owl.dmi',icon_state = "2",pixel_x=32,pixel_y=0)
			src.overlays+=image('icons/clay_owl.dmi',icon_state = "3",pixel_x=0,pixel_y=32)
			src.overlays+=image('icons/clay_owl.dmi',icon_state = "4",pixel_x=32,pixel_y=32)
			..()
	bubble
		icon='projectiles.dmi'
		icon_state="bubble-m"
	spider
		icon_state = "spider"
		mouse_drag_pointer = MOUSE_HAND_POINTER

		Move()
			if(src.icon||src.loc)
				..()
			else
				src.icon=null
				src.loc=null


		MouseDrop(D, turf/Start, turf/getta)
			if(usr == src.owner)
				if(D)
					walk_to(src, D, 0, 2)
				else
					walk_to(src, getta, 0, 2)

		DblClick()
			if(usr == src.owner)
				src.Explode()
				..()

	New(loc, p, mob/u)
		..()
		src.power = p
		src.owner = u

	Hostile()
		spawn() Explode()
		return

	proc
		Explode()
			if(src.icon)
				src.icon = null
				src.density = 0
				explosion(src.power, src.x, src.y, src.z, src.owner, 0, 4)
				if(owner && istype(owner, /mob/human/player))

					for(var/obj/trigger/exploding_spider/T in owner.triggers)
						if(T.spider == src) owner.RemoveTrigger(T)

					for(var/obj/trigger/paper_bomb/P in owner.triggers)
						spawn(world.tick_lag) owner.RemoveTrigger(P)
				walk(src,0)
				loc = null