mob/var
	ridingbird = 0
	c4 = 0
var/list
	infectedby = list()

mob/human/clay
	can_target = 0
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

	spider
		icon_state = "spider"
		mouse_drag_pointer = MOUSE_HAND_POINTER


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


	Move(turf/new_loc,dirr)
		justwalk = 1
		if(src.icon||src.loc)
			..()
		else
			src.icon=null
			src.loc=null

		var/area/A = loc.loc
		if(!A.pkzone)
			var/mob/human/clay/spider/S = src
			if(istype(S) && S.owner && istype(S.owner,/mob/human/player))
				for(var/obj/trigger/exploding_spider/T in S.owner.triggers)
					if(T.spider == src) S.owner.RemoveTrigger(T)
			src.icon=null
			src.loc=null
		return


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
			loc = null