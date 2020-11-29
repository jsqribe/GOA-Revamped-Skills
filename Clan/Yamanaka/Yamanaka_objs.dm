obj/projectile
	wolfbane
		ignoredense=1
		ignoreprojectiles=0
		ignoremobs=0
		bouncy=0

		New(loc,mob/o)
			..()
			src.powner=o
		landed(atom/movable/O,pow,wnd,daze,burn,user)
			var/tempx=src.x
			var/tempy=src.y
			var/tempz=src.z

			if(src.landed || src.clashin)
				return

			src.landed=1

			if(!O)
				sleep(10)
				loc = null //hit a wall!

			if(istype(O,/mob/human))
				var/mob/human/player/Oc=O
				src.Grabbed+=Oc  //this means the wave will no longer cause damage to that specific player, 1 time hit max per projectile of this type
				spawn()Oc.Collide(src)//the mob gets hit by src. Cause knockback check.
				//Oc.Damage(pow, 0, "", "Projectile", "Normal")
				spawn()AOEPoison(tempx,tempy,tempz,1,pow,20,user,6,0)
				spawn()PoisonCloud(tempx,tempy,tempz,1,10)

			if(istype(O,/obj/projectile))
				Clash(O,src)

			..()


	flower
		ignoredense=1
		ignoreprojectiles=0
		ignoremobs=0
		bouncy=0

		New(loc,mob/o)
			..()
			src.powner=o
		landed(atom/movable/O,pow,wnd,daze,burn,user)
			var/tempx=src.x
			var/tempy=src.y
			var/tempz=src.z

			if(src.landed || src.clashin)
				return

			src.landed=1

			if(!O)
				sleep(10)
				loc = null //hit a wall!

			if(istype(O,/mob/human/))
				var/mob/human/player/Oc=O
				src.Grabbed+=Oc  //this means the wave will no longer cause damage to that specific player, 1 time hit max per projectile of this type
				spawn()Oc.Collide(src)//the mob gets hit by src. Cause knockback check.
				//Oc.Damage(pow, 0, "", "Projectile", "Normal")

				spawn()explosion(pow,tempx,tempy,tempz,user,dist = 2)

			if(istype(O,/obj/projectile))
				Clash(O,src)

			..()



obj
	petal
		icon='icons/petal_dance_flick.dmi'
		layer=MOB_LAYER+1
		New()
			..()
			flick("flick",src)

obj/flick
	var
		list/dependants=new
	New()
		spawn()..()
		spawn()
			dependants+=new/obj/petal(locate(src.x,src.y,src.z))
	Del()
		for(var/obj/x in src.dependants)
			x.loc=null //del is expensive so just set to null and let gc take care of it.
		..()