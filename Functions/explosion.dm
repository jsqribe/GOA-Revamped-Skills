var/explosionid=0
mob
	var
		list
			curexplosions=list()

obj

	Explosion
		var
			exploid
		icon='icons/explosion2.dmi'
		density=1
		layer=MOB_LAYER+1
		New(loc,mob/e,dam,dist,xoff,yoff,dontknock)
			..()
			exploid = explosionid
			explosionid++
			if(xoff)src.pixel_x=xoff
			if(yoff)src.pixel_y=yoff
			src.icon_state="center"
			spawn(2)
				//if(!dontknock) snd(src,'sounds/explosion1.wav',vol=50)
				src.density=0
				var/list/ldirs=list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST)
				for(var/D in ldirs)
					spawn()new/obj/Push_Wave(src.loc,e,D,dam,dist,xoff,yoff,dontknock,exploid)
				sleep(2)
				src.loc = null
	Explosion2
		var
			exploid
		icon='icons/explosion3.dmi'
		density=1
		layer=MOB_LAYER+1
		New(loc,mob/e,dam,dist,xoff,yoff,dontknock)
			..()
			exploid = explosionid
			explosionid++
			src.pixel_y=-32
			src.pixel_x=-32
			if(xoff)src.pixel_x=xoff
			if(yoff)src.pixel_y=yoff
		//	src.icon_state="center"
			spawn(2)
				//if(!dontknock) snd(src,'sounds/explosion1.wav',vol=50)
				src.density=0
				var/list/ldirs=list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST)
				for(var/D in ldirs)
					spawn()new/obj/Push_Wave(src.loc,e,D,dam,dist,xoff,yoff,dontknock,exploid)
				sleep(2)
				src.loc = null
	Explosion3
		var
			exploid
		icon='icons/explosion4.dmi'
		density=1
		layer=MOB_LAYER+1
		New(loc,mob/e,dam,dist,xoff,yoff,dontknock)
			..()
			exploid = explosionid
			explosionid++
			src.pixel_y=-64
			src.pixel_x=-64
			if(xoff)src.pixel_x=xoff
			if(yoff)src.pixel_y=yoff
		//	src.icon_state="center"
			spawn(2)
				//if(!dontknock) snd(src,'sounds/explosion1.wav',vol=50)
				src.density=0
				var/list/ldirs=list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST)
				for(var/D in ldirs)
					spawn()new/obj/Push_Wave(src.loc,e,D,dam,dist,xoff,yoff,dontknock,exploid)
				sleep(2)
				src.loc = null
	Push_Wave
		icon='icons/explosion2.dmi'
		density=0
		layer=MOB_LAYER+1
		var
			exempt
			list/owned=new
			pow=0
			moves=0
			exploid
		New(loc,mob/e,xdir,dam,dist,xoff,yoff,dontknock,passedexploid)
			..()
			exploid=passedexploid
			spawn(40)
				if(src)
					src.loc = null
			if(!dontknock)
				push=1
			src.pow=dam
			if(xoff)src.pixel_x=xoff
			if(yoff)src.pixel_y=yoff
			if(e)src.owner=e
			src.dir=xdir
			if(dist>=3)src.icon_state="1"
			else if(dist>=2)src.icon_state="2"
			else src.icon_state="3"
			src.moves=dist
			spawn()
				var/turf/T = get_step(src, dir)
				while(loc && T && moves)
					Move(T)
					sleep(2)
					T = get_step(src, dir)
				loc = null

		Move(new_loc, dir=0)
			if(src.push)
				for(var/mob/human/eX in hearers(1,src))
					var/mob/human/X = eX.Replacement_Start(owner)
					if(eX != X) eX.curexplosions.Add(exploid) //make them immune if they kawa'd from it
					spawn()
						if(eX!=src.exempt)
							if(X && !X.IsProtected() && !(exploid in X.curexplosions))
								owned+=X

								X.curexplosions.Add(exploid)

								if(!X.ko) X.icon_state="hurt"
								X.Damage(src.pow, 0, src.owner, "Explosion", "Normal")
								X.Hostile(src.owner)
								spawn(5) if(X) X.Replacement_End(owner)

						if(X && !X.ko && !X.IsProtected())X.animate_movement=2
						spawn(5)
							if(X && !X.ko && !X.IsProtected() && X.animate_movement==2)
								X.animate_movement=1
						if(X && !X.ko && !X.IsProtected())
							var/turf/T = get_step(X,src.dir)
							if(!T)
								loc = null
							else
								X.Move(T)

				if(!loc) return
			if(src.moves>=3)src.icon_state="1"
			else if(src.moves>=2)src.icon_state="2"
			else src.icon_state="3"
			src.moves--
			if(src.moves<=0)
				loc = null
				return

			. = ..()

			if(!(. && new_loc))	// Movement failed or hit edge of map
				loc = null
				walk(src, 0)

		Del()
			src.loc=null
			sleep(50)
			for(var/mob/X in src.owned)
				if(X.icon_state=="hurt") X.icon_state=""
				X.curexplosions.Remove(exploid)
				src.owned-=X
			..()

