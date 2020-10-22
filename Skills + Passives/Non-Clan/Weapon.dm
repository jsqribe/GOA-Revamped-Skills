skill
	weapon
		face_nearest = 1

		copyable = 1
		windmill_shuriken
			id = WINDMILL_SHURIKEN
			name = "Windmill Shuriken"
			description = "Throws a large shuriken."
			icon_state = "windmill"
			default_supply_cost = 8
			default_cooldown = 30
			stamina_damage_fixed = list(900, 900)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(1, 4)
			wound_damage_con = list(0, 0)



			Use(mob/user)
				viewers(user) << output("[user]: Windmill Shuriken!", "combat_output")
				var/eicon = 'icons/projectiles.dmi'
				var/estate = "windmill-m"
				var/mob/human/player/etarget = user.NearestTarget()

				var/r = rand(1,4)
				var/angle
				var/speed = 48
				if(etarget) angle = get_real_angle(user, etarget)
				else angle = dir2angle(user.dir)

				spawn() advancedprojectile_angle(eicon, estate, user, speed, angle, distance=10, damage=900, wounds=r, radius=16)


		shadow_windmill_shuriken
			id = SHADOW_WINDMILL_SHURIKEN
			name = "Shadow Windmill Shuriken"
			description = "Throws a large shuriken, directly followed by a cloned shuriken."
			icon_state = "Shadow_Windmill"
			default_supply_cost = 8
			default_chakra_cost = 120
			default_cooldown = 60
			stamina_damage_fixed = list(1350, 1350)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(1, 6)
			wound_damage_con = list(0, 0)



			Use(mob/user)
				viewers(user) << output("[user]: Windmill Shuriken!", "combat_output")
				var/eicon = 'icons/projectiles.dmi'
				var/estate = "windmill-m"
				var/mob/human/player/etarget = user.NearestTarget()

				var/speed = 48
				var/angle
				if(etarget) angle = get_real_angle(user, etarget)
				else angle = dir2angle(user.dir)

				user.Timed_Stun(1)
				spawn() advancedprojectile_angle(eicon, estate, user, speed, angle, distance=10, damage=900, wounds=rand(0,4), radius=16)
				spawn(1) //Dipic: first reset the angle in case the target moved, then launch the shadow shuriken
					if(etarget) angle = get_real_angle(user, etarget)
					else angle = dir2angle(user.dir)
					advancedprojectile_angle(eicon, estate, user, speed, angle, distance=10, damage=450, wounds=rand(0,2), radius=16)


		exploding_kunai
			id = EXPLODING_KUNAI
			name = "Exploding Kunai"
			description = "Throws a kunai with an explosive attached to it."
			icon_state = "explkunai"
			default_supply_cost = 16
			default_cooldown = 20
			stamina_damage_fixed = list(1200, 1200)
			stamina_damage_con = list(0, 0)



			Use(mob/user)
				var/ux=user.x
				var/uy=user.y
				var/uz=user.z
				var/startdir=user.dir
				user.removeswords()
				flick("Throw1",user)
				var/eicon='icons/projectiles.dmi'
				var/estate="explkunai"

				var/mob/human/player/etarget = user.NearestTarget()

				if(!etarget)
					var/ex=ux
					var/ey=uy
					var/ez=uz
					var/angle = dir2angle(startdir)
					var/exmod = 8 * round(cos(angle), 1)
					var/eymod = 8 * round(sin(angle), 1)

					etarget=straight_proj(eicon,estate,8,user,1)
					if(etarget)
						ex=etarget.x
						ey=etarget.y
						ez=etarget.z
						spawn()explosion(1200,ex,ey,ez,user,dist=2)
					else
						spawn()explosion(1200,ex+exmod,ey+eymod,ez,user,dist=2)
				else
					var/ex=etarget.x
					var/ey=etarget.y
					var/ez=etarget.z

					projectile_to(eicon,estate,user,locate(ex,ey,ez))
					spawn()explosion(1200,ex,ey,ez,user,dist=2)

				user.addswords()



		triple_exploding_kunai
			id = TRIPLE_EXPLODING_KUNAI
			name = "Exploding Kunai"
			description = "Throws three kunai with an explosive attached to each."
			icon_state = "tripleexplnote"
			default_supply_cost = 24
			default_cooldown = 40
			stamina_damage_fixed = list(800, 2400)
			stamina_damage_con = list(0, 0)



			Use(mob/user)
				var/ux=user.x
				var/uy=user.y
				var/uz=user.z
				var/startdir=user.dir
				user.removeswords()
				var/eicon='icons/projectiles.dmi'
				var/estate="explkunai"

				var/mob/human/player/etarget = user.NearestTarget()

				if(!etarget)
					for(var/i in list(3,6,9))
						flick("Throw1",user)
						spawn()
							var/ex=ux
							var/ey=uy
							var/ez=uz
							var/angle = dir2angle(startdir)
							var/exmod = i * round(cos(angle), 1)
							var/eymod = i * round(sin(angle), 1)

							etarget=straight_proj(eicon,estate,i,user,1)
							if(etarget)
								ex=etarget.x
								ey=etarget.y
								ez=etarget.z
								spawn()explosion(800,ex,ey,ez,user,dist=2)
							else
								spawn()explosion(800,ex+exmod,ey+eymod,ez,user,dist=2)//I need to separate knock and damage as dontknock prevents damage
						sleep(1)
				else
					var/turf/tt = etarget.loc

					var/list/turfs = list()
					for(var/turf/t in view(2,tt))
						turfs.Add(t)
					for(var/i=3;i>0;i--)
						flick("Throw1",user)
						spawn()
							var/turf/target = pick(turfs)
							projectile_to(eicon,estate,user,target)
							spawn()explosion(800,target.x,target.y,target.z,user,dist=2)
						sleep(1)


				user.addswords()




		exploding_note
			id = EXPLODING_NOTE
			name = "Exploding Note"
			description = "Places a small piece of paper that can explode."
			icon_state = "explnote"
			default_supply_cost = 15
			default_cooldown = 30
			stamina_damage_fixed = list(1500, 1500)
			stamina_damage_con = list(0, 0)



			Use(mob/user)
				var/obj/explosive_tag/x=new/obj/explosive_tag(locate(user.x,user.y,user.z))
				if(user.skillspassive[20])x.trapskill=user.skillspassive[20]
				user<<"To detonate the tag, press <b>Z</b> or <b>click</b> the tag icon on the left side of your screen."
				x.owner=user
				var/obj/trigger/explosive_tag/T = new(user, x)
				user.AddTrigger(T)
				spawn(14000)
					if(x && user)
						user.RemoveTrigger(T)
						x.loc = null




		manipulate_advancing_blades
			id = MANIPULATE_ADVANCING_BLADES
			name = "Manipulate Advancing Blades"
			description = "Allows you to throw many kunai at once."
			icon_state = "Manipulate Advancing Blades"
			default_supply_cost = 20
			default_chakra_cost = 50
			default_cooldown = 30
			stamina_damage_fixed = list(200, 200)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(0, 2)
			wound_damage_con = list(0, 0)



			IsUsable(mob/user)
				. = ..()
				if(.)
					if(user.qued || user.qued2)
						Error(user, "A conflicting skill is already activated")
						return 0


			Use(mob/user)
				user.icon_state="Seal"
				user.Begin_Stun()
				user.dir=SOUTH
				var/obj/X=new/obj(user.loc)
				X.layer=MOB_LAYER+1
				X.icon='icons/advancing.dmi'
				flick("form",X)

				flick("Throw1",user)
				sleep(2)
				flick("Throw2",user)
				sleep(2)
				flick("Throw1",user)
				sleep(2)
				flick("Throw2",user)
				sleep(2)
				flick("Throw1",user)
				sleep(2)
				flick("Throw2",user)
				sleep(2)
				flick("Throw1",user)
				sleep(2)
				flick("Throw2",user)
				sleep(2)
				flick("Throw1",user)
				sleep(2)
				flick("Throw2",user)
				sleep(2)
				flick("Throw1",user)
				sleep(2)
				flick("Throw2",user)
				user.overlays+=image('icons/advancing.dmi',icon_state="over")
				user.underlays+=image('icons/advancing.dmi',icon_state="under")
				sleep(2)
				user.qued=1
				user.on_hit.add(src, "Cancel")

				user.icon_state=""
				user.End_Stun()
				X.loc = null



			proc
				Cancel(mob/human/player/user, mob/human/player/attacker, event/event)
					event.remove(src, "Cancel")
					if(user && user.qued)
						spawn() user.Deque(0)




		shuriken_shadow_clone
			id = SHUIRKEN_KAGE_BUNSHIN
			name = "Shuriken Shadow Clone"
			description = "Throws a shuriken that splits into many shuriken."
			icon_state = "Shuriken Kage Bunshin no Jutsu"
			default_supply_cost = 1
			default_chakra_cost = 300
			default_cooldown = 60
			stamina_damage_fixed = list(200, 200)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(1, 2)
			wound_damage_con = list(0, 0)



			Use(mob/user)
				flick("Throw1",user)
				var/obj/Du = new/obj(user.loc)
				Du.icon='icons/projectiles.dmi'
				Du.icon_state="shuriken-m"
				Du.density=0


				sleep(1)
				walk(Du,user.dir)
				sleep(2)
				flick("Seal",user)
				for(var/mob/X in ohearers(0,Du))
					var/ex=Du.x
					var/ey=Du.y
					var/ez=user.z
					spawn()Poof(ex,ey,ez)
					Du.loc = null
					return
				var/dx=Du.x
				var/dy=Du.y
				var/dz=user.z
				spawn()Poof(dx,dy,dz)
				Du.loc = null
				user.ShadowShuriken(dx,dy,dz)




		twin_rising_dragons
			id = TWIN_RISING_DRAGONS
			name = "Twin Rising Dragons"
			description = "Summons a large variety of weapons."
			icon_state = "Twin Rising Dragons"
			default_supply_cost = 50
			default_chakra_cost = 100
			default_cooldown = 120
			stamina_damage_fixed = list(900, 900)
			stamina_damage_con = list(0, 0)
			wound_damage_fixed = list(1, 1)
			wound_damage_con = list(0, 0)



			Use(mob/user)
				user.icon_state="Throw1"
				user.overlays+='icons/twindragon.dmi'
				var/ammo=20
				user.Timed_Stun(15)
				sleep(15)
				//var/startloc=user.loc
				while(ammo>0)
					/*if(!(startloc==user.loc))//Dipic: Disabled as you can now move with TRD.. we'll see how that goes.
						user.supplies+=5*ammo
						return*/
					/*var/xoff=rand(-32,32)
					var/yoff=rand(-32,32)
					while(abs(xoff)+abs(yoff)<32)
						xoff=rand(-32,32)
						yoff=rand(-32,32)*/

					sleep(1)

					var/angle = rand(0, 360)
					var/speed = rand(32, 64)
					spawn() advancedprojectile_angle('icons/twin_proj.dmi', "[pick(1,2,3,4)]", user, speed, angle, distance=7, damage=900, wounds=1, radius=16)
					//advancedprojectilen(i,estate,mob/efrom,xvel,yvel,distance,damage,wnd,vel,pwn,mob/trueowner,radius)
					//spawn()advancedprojectilen('icons/twin_proj.dmi',"[pick(1,2,3,4)]",user,xoff,yoff,7,900,1,60,1,user)
					Poof(user.x,user.y,user.z)
					ammo--
				user.icon_state=""
				user.overlays-='icons/twindragon.dmi'
