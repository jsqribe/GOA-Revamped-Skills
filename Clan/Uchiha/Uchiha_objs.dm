obj/black2
	icon = 'BLANK BLACK.dmi'
	screen_loc = "1,1 to 8,17" //to 2,2"
	layer = MOB_LAYER+140

obj
	Amaterasu
		layer=MOB_LAYER+0.1
		Head
			icon='amaterasu.dmi'
			var
				Can_Walk=1

				list
					trails=list()
			New(mob/target,mob/owner)
				..()
				spawn()
					src.loc=owner.loc
					src.icon_state="[rand(1,12)]"
					src.pixel_y=rand(-8,8)
					src.pixel_x=rand(-8,8)
					var/check=0
					while(target&&src.loc!=null&&src)
						sleep(2)
						var/old_loc=src.loc
						if(src.Can_Walk)
							step_to(src,target)


							if(src.loc!=old_loc)
								var/obj/Amaterasu/Trail/T=new/obj/Amaterasu/Trail
								T.loc=old_loc
								src.trails+=T
								T.owner=owner

						check++
						if(check==2)
							for(var/mob/M in view(1,src))
								if(M!=owner&&!M.ko&&!istype(M,/mob/corpse))
									if(M&&owner)
										M = M.Replacement_Start(owner)
										M.Damage(round(rand(80, 50) + 100 *owner:ControlDamageMultiplier()),round(rand(0,4) + (0.1*owner:ControlDamageMultiplier())),owner,"Amaterasu","Normal")
									//	M.Dec_Stam(rand(80, 50) + 100 *owner:ControlDamageMultiplier(),attacker=owner)
									//	M.Wound(rand(0,4) + (0.1*owner:ControlDamageMultiplier()))
										//step_away(M,src,1)
										//if(prob(40))
										//	Blood2(M)
							check=0
						sleep(3)
					Del()
			Del()
				src.loc=null
			Move()
				..()
				spawn()
					src.icon_state="[rand(1,12)]"
					var/list/L=new/list()

					Start
					var/time=0
					if(prob(50))
						for(var/turf/t in oview(2))
							if(!t.density)
								L+=t
						var/obj/Amaterasu/Trail/T=new/obj/Amaterasu/Trail
						trails+=T
						T.owner=src.owner
						if(L.len)
							var/turf/turf=pick(L)
							T.loc=locate(turf.x,turf.y,turf.z)
						if(!time)
							goto Start



		Trail
			icon='amaterasu.dmi'
			New()
				..()
				spawn(300)
					src.loc=null
				spawn(1)
					src.icon_state="[rand(1,12)]"
					src.pixel_y=rand(-16,16)
					src.pixel_x=rand(-16,16)
					while(src.loc!=null&&src)
						for(var/mob/M in view(1,src))
							if(M!=owner&&!M.ko&&!istype(M,/mob/corpse))
								if(owner)
									M = M.Replacement_Start(owner)
									M.Damage(round(rand(50, 50) + 50 *owner:ControlDamageMultiplier()),round(rand(0,2)),owner,"Amaterasu","Normal")
									//M.Dec_Stam(rand(50, 50)+ (50*owner:ControlDamageMultiplier()),xpierce=3,attacker=owner)
								//	M.Wound(rand(0,2),xpierce=3,attacker=owner)
								if(prob(40))
									Blood2(M)
								//	step_away(M,src,1)
								spawn(5) if(M) M.Replacement_End()
						sleep(6)


mob/var
	Intangibilty=0
	eye_collection=0
	izanagi_active
	InSusanoo=0
	DefenceSusanoo=0
	SusanooHP=15000
	INSASUKESUSANOO=0
	usingamat = 0
	InFlames = 0
	controlling=0
	kotoactive=0

obj
	amatburn
		icon='icons/Ama-burn.dmi'
		layer=MOB_LAYER+3
		density=0

obj
	amatblob
		icon='icons/ama-blob.dmi'
		layer=MOB_LAYER+3
		density=0

/////////////////////////////////////////////////////////////////////////////////////////////

//INFERNO STUFF

mob/var
 AmaterasuOn=0
 MangOn=0

var/
 AmaterasusOut=0
 AmaterasusOutMax=1120
obj/var
 IsAma=0
 Acooldown=0
 AOwner
 Arandom=0

var/
	AMATERASUTEXT="Black Fire"
	AMATON=0
mob/var
	AmaterasuClicks=0

mob/proc
	Amaterasu()
		if(usr.AmaterasuOn==0)
			usr.client.mouse_pointer_icon = 'Eye.dmi'
			usr.AmaterasuOn=1
			//AmaterasusOut=0
			AmaterasuClicks=0
			view(usr,8) << "[usr]: Amaterasu!!!"
			AMATON=1
  			 //new/obj/ShadeEffect(client)
			sleep(200)
			usr.Amaterasu()
			return
		if(usr.AmaterasuOn==1)
			usr.client.mouse_pointer_icon = 'MouseIcon.dmi'
			AMATON=0
			usr.AmaterasuOn=0
			//AmaterasusOut=0
			view(usr,8) << "(*[usr] stops using Amaterasu.*)"
			usr.AmaterasuClicks=0
			spawn(20)
				for(var/obj/Amaterasuu/A in world)
					A:Deleted=1
					if(A:AOwner==usr)
						spawn(rand(10,32))
							del(A)
   /*for(var/obj/ShadeEffect/S in usr.client.screen)
    del S*/
			return


obj/Amaterasuu
	icon = 'Ama-burn.dmi'
	var
		Deleted=0
	Entered()
		if(usr.ko==0&&usr.protected<=0&&usr.pk>=1)
			usr.Damage(rand(100,200))
			//usr.curwound+=0.3
			usr.movepenalty+=65
	New()
		if(AMATON==0)
			AmaterasusOut-=1
			if(AmaterasusOut<0)
				AmaterasusOut=0
			del(src)
		if(AmaterasusOut>=AmaterasusOutMax)
			AmaterasusOut-=1
			if(AmaterasusOut<0)
				AmaterasusOut=0
			del(src)
		AmaterasusOut+=1
		src.IsAma=1
		src.pixel_y=rand(-25,25)
		src.pixel_x=rand(-25,25)
		for(var/mob/human/M in src.loc)
			if(M.ko==0&&M.protected<=0&&M.pk>=1)
				M = M.Replacement_Start(src)
				M.Damage(rand(10,80))
				//M.curwound+=0.3
				walk_towards(src,M)
				spawn(5) if(M) M.Replacement_End()
		spawn(rand(10,80))
			AmaterasusOut-=1
			del src
		spawn while(2)
			for(var/mob/human/MM in view(src,1))
				if(MM.ko==0&&MM.protected<1&&MM.pk>=1)
					MM = MM.Replacement_Start(usr)
					MM.Damage(rand(50,100))
					//M.curwound+=0.3
					walk_towards(src,MM)
					spawn(5) if(MM) MM.Replacement_End()
			sleep(3.2)
			var/random = rand(1,5)
			if(random==1)
				//if(AmaterasusOut>=AmaterasusOutMax)
					//return
				if(src.Deleted==1)
					AmaterasusOut-=1
					if(AmaterasusOut<0)
						AmaterasusOut=0
					del(src)
				var/obj/O = new /obj/Amaterasuu(src.loc)
				//O:AOwner=src.AOwner
				src.Arandom=rand(1,4)
				if(src.Arandom==1)
					O.loc = locate(src.x - 1,src.y,src.z)
				if(src.Arandom==2)
					O.loc = locate(src.x + 1,src.y,src.z)
				if(src.Arandom==3)
					O.loc = locate(src.x,src.y - 1,src.z)
				if(src.Arandom==4)
					O.loc = locate(src.x,src.y + 1,src.z)
				step_rand(O)
				for(var/mob/human/M in view(src,1))
					if(M.ko==0&&M.protected<1&&M.pk>=1)
						M.Damage(rand(10,80))
						//M.curwound+=0.3
						walk_towards(src,M)
				sleep(20)

obj/proc/
	AmaActivate()
		while(src.IsAma==1)
			for(var/mob/M in world)
				if(M in view(src,1)&&src.Acooldown==0)
     //view(src,8) << "[M] was hit by Amaterasu"
					src.Acooldown=1
					sleep(10)
					src.Acooldown=0

//////////////////////////////////////////////////////////////////////////////////////////////

