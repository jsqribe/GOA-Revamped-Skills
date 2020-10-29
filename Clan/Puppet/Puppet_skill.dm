mob
	proc
		PuppetSkill(oindex,mob/u)
			var/mob/etarget= u.MainTarget()
			usr=src
			var/nopk
			for(var/area/O in oview(0,src))
				if(!O.pkzone)
					nopk=1
				else
					nopk=0
			if(nopk)
				return
			switch(oindex)
				if(1)//knife launcher
					var/eicon='icons/projectiles.dmi'
					var/estate="knife-m"

					var/r=rand(3,10)

					var/speed = 56

					src.icon_state = "Throw2"
					spawn(5) src.icon_state = ""
					if(etarget) src.FaceTowards(etarget)

					if(etarget)
						var/angle = get_real_angle(src, etarget)
						var/momx=speed*cos(angle)
						var/momy=speed*sin(angle)

						spawn()advancedprojectile(eicon,estate,src,momx,momy,10,900,r,100,1,u)
					else
						if(src.dir==NORTH)
							spawn()advancedprojectile(eicon,estate,src,0,speed,10,900,r,100,1,u)

						else if(src.dir==SOUTH)
							spawn()advancedprojectile(eicon,estate,src,0,-speed,10,900,r,100,1,u)

						else if(src.dir==EAST || src.dir==NORTHEAST || src.dir==SOUTHEAST)
							spawn()advancedprojectile(eicon,estate,src,speed,0,10,900,r,100,1,u)

						else if(src.dir==WEST || src.dir==NORTHWEST || src.dir==SOUTHWEST)
							spawn()advancedprojectile(eicon,estate,src,-speed,0,10,900,r,100,1,u)

						return

				if(2)//poison bomb
					flick("hand",src)
					var/eicon='icons/poison.dmi'
					var/estate="ball"
					if(!etarget)
						etarget=straight_proj(eicon,estate,8,src)
						if(etarget)
							var/ex=etarget.x
							var/ey=etarget.y
							var/ez=etarget.z
							spawn()AOEPoison(ex,ey,ez,1,100,50,u,6,1)
							spawn()PoisonCloud(ex,ey,ez,1,50)
					else
						var/ex=etarget.x
						var/ey=etarget.y
						var/ez=etarget.z
						var/mob/x=new/mob(locate(ex,ey,ez))

						projectile_to(eicon,estate,src,x)
						x.loc = null
						spawn()AOEPoison(ex,ey,ez,1,100,50,u,6,1)
						spawn()PoisonCloud(ex,ey,ez,1,50)
					usr.icon_state=""

				if(3)//Body crush
					if(!etarget)
						for(var/mob/human/X in get_step(src,src.dir))
							etarget=X
					else
						var/mob/human/Puppet/p = src
						p.pwalk_towards(src,etarget,2,10)
					if(get_dist(src, etarget) <= 1)
						src.icon_state = "hid_setup"
						src.Timed_Stun(5)
						sleep(5)
						if(etarget && get_dist(src,etarget) <= 1)
							etarget.Timed_Stun(50)
							src.Timed_Stun(90)
							src.layer++
							src.icon_state="hid"
							src.loc=etarget.loc
							var/image/e=image(icon='icons/puppet1.dmi',icon_state="bindunder")
							etarget.underlays+=e
							etarget.icon_state="hurt"
							flick("bindover",src)
							sleep(30)
							src.icon_state=""
							if(etarget)
								etarget.icon_state=""
								etarget.underlays-=e
								etarget.Damage(rand(2000,3500), rand(4,9), u, "Body Crush", "Normal")
								//etarget.Dec_Stam(rand(2000,3500), 0, u)
								//etarget.Wound(rand(4,9), 0, u)
								etarget.Hostile(u)
							src.layer=MOB_LAYER
							e.loc = null

				if(4)//Poison tipped blade
					u<<"[src] releases poison onto its blades."
					src:Pmod=1

				if(5)//Needle Gun
					src.icon_state="gun"
					//src:coold+=3000
					var/c=20
					var/ewoundmod=100
					var/eicon='icons/projectiles.dmi'
					var/estate="needle-m"
					//var/evel=150

					var/angle
					var/spread = 8
					while(c>0)
						etarget = u.MainTarget()
						if(etarget)
							angle = get_real_angle(src, etarget)
						else
							angle = dir2angle(src.dir)

						spawn() advancedprojectile_angle(eicon, estate, u, rand(14,32), pick(angle+spread*2,angle+spread,angle,angle-spread,angle-spread*2), distance=10, damage=ewoundmod, wounds=0, daze=0, radius=8, from=src)
						spawn() advancedprojectile_angle(eicon, estate, u, rand(14,32), pick(angle+spread*2,angle+spread,angle,angle-spread,angle-spread*2), distance=10, damage=ewoundmod, wounds=0, daze=0, radius=8, from=src)

						c--
						sleep(2)

					if(src)
						src.icon_state = ""


				if(6)//shield
					src.Begin_Stun()
					src.icon_state="shield"
					sleep(5)
					var/obj/Shield/S = new/obj/Shield(locate(src.x,src.y,src.z))
					sleep(5)
					src.End_Stun()
					src.icon_state=""
					S.loc = null

				if(7)//Needle Gun
					var/c=30
					var/ewoundmod=100
					var/eicon='icons/projectiles.dmi'
					var/estate="needle-m"
					var/evel=150

					while(c>0)
						spawn()
							if(src.dir==NORTH)
								spawn()advancedprojectile(eicon,estate,src,rand(-10,10),32,10,ewoundmod,0,evel,0,src)

							if(src.dir==SOUTH)
								spawn()advancedprojectile(eicon,estate,src,rand(-10,10),-32,10,ewoundmod,0,evel,0,src)

							if(src.dir==EAST)
								spawn()advancedprojectile(eicon,estate,src,32,rand(-10,10),10,ewoundmod,0,evel,0,src)

							if(src.dir==WEST)
								spawn()advancedprojectile(eicon,estate,src,-32,rand(-10,10),10,ewoundmod,0,evel,0,src)


						spawn()
							if(src.dir==NORTH)
								spawn()advancedprojectile(eicon,estate,src,rand(-10,10),32,10,ewoundmod,0,evel,0,src)

							if(src.dir==SOUTH)
								spawn()advancedprojectile(eicon,estate,src,rand(-10,10),-32,10,ewoundmod,0,evel,0,src)

							if(src.dir==EAST)
								spawn()advancedprojectile(eicon,estate,src,32,rand(-10,10),10,ewoundmod,0,evel,0,src)

							if(src.dir==WEST)
								spawn()advancedprojectile(eicon,estate,src,-32,rand(-10,10),10,ewoundmod,0,evel,0,src)
						c--
						sleep(2)
					if(src)
						src.icon_state = ""

				if(8)
					src.Timed_Stun(5)
					src.icon_state = "Throw2"
					spawn(5) src.icon_state = ""
					if(etarget) src.FaceTowards(etarget)
					var/dir = src.dir
					var/xmod = 0
					var/ymod = 0
					switch(dir)
						if(NORTH)
							ymod = 3
						if(SOUTH)
							ymod = -3
						if(EAST)
							xmod = 3
						if(WEST)
							xmod = -3
						if(NORTHEAST)
							ymod = 3
							xmod = 3
						if(NORTHWEST)
							ymod = 3
							xmod = -3
						if(SOUTHWEST)
							ymod = -3
							xmod = -3
						if(SOUTHEAST)
							ymod = -3
							xmod = 3

					var/obj/x = new/obj
					x.loc = locate(src.x + xmod, src.y + ymod, src.z)
					x.dir = src.dir
					x.icon = 'icons/3.dmi'
					x.layer = MOB_LAYER+2
					x.pixel_x = -64
					x.pixel_y = -64
					flick("fireball",x)
					//snd(x,'sounds/fireball.wav',vol=30)
					spawn(10) x.loc = null
					//var/turf/x= locate(user.x + xmod, user.y + ymod, user.z)
					for(var/mob/human/M in hearers(2,x))
						spawn(2)
							M = M.Replacement_Start(src)
							M.Damage(round(rand(200,300)+rand(100,150)*20),rand(1,3),src,"Puppet Flamethrower","Normal")
							M.BurnDOT(src,20*5)
							M.Hostile(src)
							spawn(5) if(M) M.Replacement_End()
					for(var/obj/smoke/s in view(2,x))
						spawn()
							if(!s.ignited) s.Ignite(s,s.loc)


				if(9)//Poison Needle Gun
					var/c=10
					var/ewoundmod=100
					var/eicon='icons/projectiles.dmi'
					var/estate="needle-m"
				//	var/evel=150
					var/angle = dir2angle(src.dir)
					var/spread = 8

					src.icon_state="hand"
					while(c>0)
						//advancedprojectile_angle(icon, icon_state, mob/user, speed, angle, distance, damage, wounds=0, daze=0, radius=8, atom/from=user)
						spawn() advancedprojectile_angle(eicon, estate, u, rand(14,32), pick(angle+spread*2,angle+spread,angle,angle-spread,angle-spread*2), distance=10, damage=ewoundmod, wounds=0, daze=0, radius=8, from=src)
						spawn() advancedprojectile_angle(eicon, estate, u, rand(14,32), pick(angle+spread*2,angle+spread,angle,angle-spread,angle-spread*2), distance=10, damage=ewoundmod, wounds=0, daze=0, radius=8, from=src)
						c--
						sleep(2)
					if(src)
						src.icon_state=""