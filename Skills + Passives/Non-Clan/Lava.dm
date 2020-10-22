skill
	lava
		copyable = 0

		lava_release_quicklime_congealing_technique
			id = LAVA_RELEASE_QUICKLIME
			name = "Lava Release: Quicklime Congealing Technique"
			icon_state = "quicklime"
			default_chakra_cost = 250
			default_cooldown = 30

			Use(mob/human/user)
				var/obj/corrosion_blob/O=new/obj/corrosion_blob(user)
				O.density=0
				O.dir=user.dir

				//Location
				if(user.dir==NORTH)
					O.loc=locate(user.x,user.y+1,user.z)
				if(user.dir==SOUTH)
					O.loc=locate(user.x,user.y-1,user.z)
				if(user.dir==EAST)
					O.loc=locate(user.x+1,user.y,user.z)
				if(user.dir==WEST)
					O.loc=locate(user.x-1,user.y,user.z)
				if(user.dir==NORTHEAST)
					O.loc=locate(user.x+1,user.y+1,user.z)
				if(user.dir==NORTHWEST)
					O.loc=locate(user.x-1,user.y+1,user.z)
				if(user.dir==SOUTHEAST)
					O.loc=locate(user.x+1,user.y-1,user.z)
				if(user.dir==SOUTHWEST)
					O.loc=locate(user.x-1,user.y-1,user.z)

				var/tiles=8
				var/hit=0
				while(user&&O&&tiles>0&&!hit)
					for(var/mob/M in O.loc)
						if(M!=user)
							O.loc=null
							hit=1
							spawn()
								M.stunned+=3
								M.overlays+='icons/corrosion_hit.dmi'
								new/obj/corrosion(user,M.loc,1)
								while(M&&M.stunned>0)
									M.icon_state="hurt"
									CHECK_TICK
								if(M)
									M.icon_state=""
									M.overlays-='icons/corrosion_hit.dmi'
							break
					step(O,O.dir)
					tiles--
					CHECK_TICK
				if(!hit)
					new/obj/corrosion(user,O.loc,1)
					O.loc=null

		lava_blast
			id = LAVA_BLAST
			name = "Lava: Blast"
			icon_state = "lava_blast"
			default_chakra_cost = 50
			default_cooldown = 10



			Use(mob/user)
				if(user.LavaBomb==1)
					oviewers(user) << output("[user] hands turn to lava as he launchs Lava bombs!", "combat_output")
					user.combat("You're hands turn to lava as you active Lavabombs! You gain wounds eveytime you launch a bomb!")
					user.LavaBomb=0
					for(var/obj/Lava/Area/L in world)
						if(L.LavaOwner==user)
							spawn(rand(10,55))
								del(L)
					user.Lavas=0
				if(user.LavaBomb==0)
					oviewers(user) << output("[user] hands turn to lava as he launchs Lava bombs!", "combat_output")
					user.combat("You're hands turn to lava as you active Lavabombs! You gain wounds eveytime you launch a bomb!")
					user.LavaBomb=1




obj
	corrosion_blob
		icon='icons/corrosion.dmi'
		icon_state="blob"
/*
	quicklime
		icon='icons/corrosion.dmi'
		left
			pixel_x=-32
			icon_state="left"
		right
			pixel_x=32
			icon_state="right"
		middle
			icon_state="middle"

	quicklime_full
		var
			list/dependants=new
		New()
			spawn()..()
			spawn()
				dependants+=new/obj/quicklime/left(locate(src.x,src.y,src.z))
				dependants+=new/obj/quicklime/right(locate(src.x,src.y,src.z))
				dependants+=new/obj/quicklime/middle(locate(src.x,src.y,src.z))
*/
	corrosion
		icon='icons/corrosion.dmi'
		icon_state="middle"
		New(mob/user,location,jutsu)
			.=..()
			loc=location
			pixel_x=rand(-16,16)
			pixel_y=rand(-16,16)
			owner = user
			if(jutsu)
				spawn()new/obj/corrosion(user,locate(x+1,y+1,z))
				spawn()new/obj/corrosion(user,locate(x-1,y-1,z))
				spawn()new/obj/corrosion(user,locate(x-1,y,z))
				spawn()new/obj/corrosion(user,locate(x+1,y,z))
				spawn()new/obj/corrosion(user,locate(x,y+1,z))
				spawn()new/obj/corrosion(user,locate(x,y-1,z))
				spawn()new/obj/corrosion(user,locate(x-1,y+1,z))
				spawn()new/obj/corrosion(user,locate(x+1,y-1,z))
			spawn(300)
				src.loc=null
		proc/E(mob/human/o)
			if(o==owner) return
			usr=o
			spawn()
				usr.stunned+=5
				usr.overlays+='corrosion_hit.dmi'
				while(usr&&usr.stunned>0)
					usr.icon_state="hurt"
					CHECK_TICK
				if(usr)
					usr.icon_state=""
					usr.overlays-='corrosion_hit.dmi'
				src.loc=null
			..()



mob/var
	LavaBomb=0
	LavaSwamp=0
	Lavas=0
	LavasMax=15




obj/var
	LavaOwner
	LavaDamage
	Hitted=0


obj/Lava
	Area
		icon='icons/Lava.dmi'




obj/Lava/
	Blast
		icon='icons/Lava Blast.dmi'
		Move()
			if(src.Hitted==1)
				return
			..()
		New()
			src.pixel_y=rand(-15,15)
			src.pixel_x=rand(-15,15)
			spawn(7)
				for(var/turf/T in view(src,2))
					var/obj/L = new/obj/Lava/Area(locate(T.x,T.y,T.z))
					L:LavaOwner=src.LavaOwner
				del(src)

		Bump(A)
			if(ismob(A))
				var/mob/M = A
				if(M.ko==0&&M.protected<=0&&M.pk>=1)
					M.movepenalty+=8
					src.Hitted=1
					for(var/turf/T in view(src,2))
						var/L = new/obj/Lava/Area(locate(T.x,T.y,T.z))
						L:LavaOwner=src.LavaOwner
						L:LavaDamage=src.LavaDamage
					del(src)
				else
					src.loc = locate(M.x,M.y,M.z)
			if(isturf(A))
				src.Hitted=1
				for(var/turf/T in view(src,2))
					var/L = new/obj/Lava/Area(locate(T.x,T.y,T.z))
					L:LavaOwner=src.LavaOwner
					L:LavaDamage=src.LavaDamage
				del(src)
			if(isobj(A))
				src.Hitted=1
				for(var/turf/T in view(src,2))
					var/L = new/obj/Lava/Area(locate(T.x,T.y,T.z))
					L:LavaOwner=src.LavaOwner
					L:LavaDamage=src.LavaDamage
				del(src)

