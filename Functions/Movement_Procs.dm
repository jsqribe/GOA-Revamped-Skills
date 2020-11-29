mob/var/tmp
	sly_mind_count=0
	sly_mind_x=0
	sly_mind_y=0
	sly_mind_z=0


mob/proc
	//Everytime  mob moves, this get's called.
	Movement_Procs(turf/new_loc,dirr,dir)
		//newloc = where they will be
		//dirr = the new direction
		//dir = the current direction

		if(src.inslymind) //slymind
			src.sly_mind_count++
			//src << "You're in sly mind => [src.sly_mind_count]."
			if(src.sly_mind_count>=10)
				src.x=src.sly_mind_x
				src.y=src.sly_mind_y
				src.z=src.sly_mind_z
				src.sly_mind_count=0


		if(Tank) //Aki Meat Tank
			for(var/mob/human/Xe in get_step(src,dir))
				if(Xe!=src && !Xe.ko && !Xe.IsProtected() && (Xe.client||istype(Xe,/mob/human/player/npc/kage_bunshin)||istype(Xe,/mob/human/player/npc/bunshin)/*||istype(Xe,/mob/human/player/npc/waterclone)*/))
					Xe = Xe.Replacement_Start(src)
					var/obj/t = new/obj(Xe.loc)
					t.icon='icons/gatesmack.dmi'
					flick("smack",t)
					spawn(10)
						t.loc = null

					Xe.Damage((src.str+src.strbuff-strneg)*rand(1,3)+400, 0, src, "Human Bullet Tank", "Normal")
					Xe.Hostile(src)

					if(!Xe.Tank)
						Xe.loc=locate(src.x,src.y,src.z)
						Xe.icon_state="Hurt"

					spawn()
						if(!Xe.Tank)
							Xe.Knockback(5,turn(src.dir, 180))
						else
							Xe.Knockback(5,src.dir)
						Xe.icon_state=""
						spawn(5) if(Xe) Xe.Replacement_End()
				else
					src.loc=locate(Xe.x,Xe.y,Xe.z)


		var/simple_move = 0
		if(istype(src,/mob/human/sandmonster)||istype(src,/mob/human/player/npc))
			if(icon_state=="D-funeral")
				return 0
			else
				simple_move = 1

		if(istype(src,/mob/spectator))
			density = 0
			icon = null
			simple_move = 1


		if(!simple_move)
			if(mole)
				if(curchakra > 40) //should be effected by efficiency, will come back to that
					curchakra -= 40
				else
					return 0


				if(dirr==dir)
					new_loc = get_step(src, dir)
					if(new_loc && loc.Exit(src) && new_loc.Enter(src))
						loc.Exited(src)
						loc = new_loc
						new_loc.Entered(src)
					spawn(3)
						return 1

				else
					. = ..()
					return

			if(!movedrecently)
				movedrecently = min(10, movedrecently + 1)


			if(isguard)
				icon_state=""
				isguard=0

			if(madarasusano==1)
				src.overlays-=image('icons/MadaraDef.dmi',pixel_x=-8,pixel_y=-8)

			if(sasukesusano == 1)
				src.overlays-=image('icons/SasukeDef.dmi',pixel_x=-8,pixel_y=-8)

			if(itachisusano == 1)
				src.overlays-=image('icons/ItachiDef.dmi',pixel_x=-8,pixel_y=-8)
				//src.overlays-=image('icons/SasAttck.dmi',pixel_x=-96,pixel_y=-96)
			if(ironmass == 1)
				src.overlays-=image('icons/magnetdef.dmi',pixel_x=-32,pixel_y=-32)

			if((!new_loc.icon && !istype(new_loc,/turf/warp) && !istype(new_loc,/turf/towerdoor)) || new_loc.type==/turf)
				return 0

			if(locate(/obj/Bonespire) in new_loc) for(var/obj/Bonespire/S in new_loc)
				if(S.causer==src)
					S.density=0
					spawn(2)
						if(S)
							S.density=1

			if(sleeping)
				sleeping = 0
				icon_state = ""

			if(length(carrying))
				for(var/mob/X in carrying)
					X.loc=src.loc



		if(HasSkill(BLOOD_BIND))
			for(var/obj/undereffect/B in loc)
				if(B.uowner) Blood_Add(B.uowner)


		for(var/area/XE in oview(src,0))
			if(!XE.pkzone)
				src.Hostile()

		if(istype(src,/mob/human/sandmonster)||istype(src,/mob/human/player/npc))
			canmove=0
			spawn(1)
				canmove=1
			return

		for(var/obj/caltrops/x in loc)
			if(istype(x))
				x:E(src)

		for(var/obj/trip/x in oview(1))
			if(istype(x))
				if(x.owner != src)
					x:E(src)

		for(var/obj/trip2/x in oview(1))
			if(istype(x))
				x:E(src)