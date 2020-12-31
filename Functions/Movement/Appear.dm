mob
	proc
		AppearBefore(mob/human/x,effect=/obj/overfx2, nofollow=0)
			if(!x || (x && Issmoke(x.loc))) return

			var/turf/t = get_step(x, x.dir)
			if(t.density || !t)
				return
			var/list/dirs = list(NORTH, SOUTH, EAST, WEST)
			while((!t || t.density) && dirs.len)
				var/dir = pick(dirs)
				dirs -= dir
				t = get_step(x, dir)
			if(t && !t.density)
				new effect(t)
				src.FaceTowards(x)
				//src.Move(t)
				src.loc=t
				//src.Move() //t.Entered(src)

				if(!nofollow)
					for(var/mob/human/player/npc/N in ohearers(10))
						N.FilterTargets()
						if(src in N.targets)
							spawn()N.AppearBehind(src, nofollow=1)
			return 1


		AppearBehind(mob/human/x, effect=/obj/overfx, nofollow=0)
			if(!x || (x && Issmoke(x.loc))) return

			var/turf/t = get_step(x, turn(x.dir, 180))
			if(!t || t.density)
				return
			var/list/dirs = list(NORTH, SOUTH, EAST, WEST)
			while((!t || t.density) && dirs.len)
				var/dir = pick(dirs)
				dirs -= dir
				t = get_step(x, dir)
			if(t && !t.density)
				new effect(t)
				src.FaceTowards(x)
				//src.Move(t)
				src.loc=t
				//src.Move() //t.Entered(src)

				if(!nofollow)
					for(var/mob/human/player/npc/N in ohearers(10))
						N.FilterTargets()
						if(src in N.targets)
							spawn()N.AppearBehind(src, nofollow=1)


		AppearMyDir(mob/human/x, effect=/obj/overfx, nofollow=0)
			if(!x || (x && Issmoke(x.loc))) return 0

			var/turf/t = get_step(x, dir)
			var/list/dirs = list(turn(dir, 45), turn(dir, -45))
			while((!t || t.density) && dirs.len)
				var/dir = pick(dirs)
				dirs -= dir
				t = get_step(x, dir)
			if(t && !t.density)
				new effect(t)
				src.FaceTowards(x)
				//src.Move(t)
				src.loc=t
				//src.Move() //t.Entered(src)

				if(!nofollow)
					for(var/mob/human/player/npc/N in ohearers(10))
						N.FilterTargets()
						if(src in N.targets)
							spawn()N.AppearBehind(src, nofollow=1)
				return 1
			return 0


		AppearAt(ax,ay,az, effect=/obj/overfx, nofollow=0)
			if(Issmoke(src.loc)) return 0
			src.loc=locate(ax,ay,az)
			//if(src.client) src.client.cancel_movement_loop=0//allow to move again
			//src.Move() //t.Entered(src)
			//if(!src.Move(locate(ax,ay,az)))
			//	return 0
			if(effect) new effect(locate(ax,ay,az))
			if(!nofollow)
				for(var/mob/human/player/npc/N in ohearers(10))
					N.FilterTargets()
					if(src in N.targets)
						spawn()N.AppearBehind(src, nofollow=1)
			return 1
