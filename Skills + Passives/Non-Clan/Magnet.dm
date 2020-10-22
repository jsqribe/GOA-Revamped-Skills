skill
	magnet
		copyable = 0

		iron
			id = IRON_CONTROL
			name = "Iron Control"
			icon_state = "magnet"
			default_chakra_cost = 350
			default_cooldown = 1
			default_seal_time = 5
			var/used_chakra

			ChakraCost(mob/user)
		/*		if(user.naturechakra >= 0)
					used_chakra = user.naturechakra * 3 / 4
					if(used_chakra > default_chakra_cost)
						return used_chakra*/
				used_chakra = user.curchakra * 3 / 4
				if(used_chakra > default_chakra_cost)
					return used_chakra
				else
					return default_chakra_cost

			Use(mob/user)
				if(user.ironsand == 1)
					user.ironsand = 0
					var/K=0
					for(var/mob/human/ironsand/M in world)if(M.owner==user)
						K=1
						break
					if(K)
						src<<"You dissolved your icon sand."
						for(var/mob/human/ironsand/M in world)if(M.owner==user)del M
					ChangeIconState("magnet")
				else
					if(user.ironmass==0)
						user.combat("You need to have Iron Mass Activated.")
						return
					user.ironsand = 1
					user.ironmass = 0
					del iron_mass
					user.AC-=30
					var/am=0
					var/list/options=new
					for(var/turf/x in oview(4,user))
						if(!x.density)
							options+=x
					while(used_chakra>default_chakra_cost && am<=20 && options.len)
						used_chakra-=default_chakra_cost
						var/turf/next=pick(options)
						var/Q=new/mob/human/ironsand(locate(next.x,next.y,next.z))
						Q:owner=user
						am++
					ChangeIconState("magnet_cancel")

		dissolve
			id = IRON_DISSOLVE
			name = "Iron Dissolve"
			icon_state = "magnet"
			default_chakra_cost = 1
			default_cooldown = 1

			Use(mob/user)
				var/K=0
				for(var/mob/human/ironsand/M in world)if(M.owner==user)
					K=1
					break
				if(K)
					src<<"You dissolved your icon sand."
					for(var/mob/human/ironsand/M in world)if(M.owner==user)del M
					user.ironsand = 0

/*		iron_world
			id = IRON_WORLD
			name = "Iron World"
			icon_state = "magnet"
			default_chakra_cost = 1500
			default_cooldown = 300
			default_seal_time = 15

			Use(mob/user)
				range(8)<<"<b>[user]: Iron Sand..."
				icon_state="Seal"
				user.Begin_Stun()
				sleep(20)
				range(8)<<"<b>[user]: Iron Sand World!"
				spawn(30)
					user.End_Stun()
					icon_state=""
				var/T=48
				loop
					if(T>0)
						T--
						var/L=new/obj/ironspikes(locate(user.x+rand(-4,4),user.y+rand(-4,4),user.z))
						L:owner=user
						walk(L,pick(NORTH,EAST,WEST,SOUTH,SOUTHWEST,SOUTHEAST,NORTHWEST,NORTHEAST))
						spawn(pick(0,1))goto loop
*/
mob/human
	ironsand
		name="Iron Sand"
		icon='ironrain.dmi'
		density=1
		layer=25
		var/owner=""
	//	isiron=1
		New()
			var/random=rand(1,3)
			if(random==1)icon_state=""
			if(random==2)icon_state="1"
			if(random==3)icon_state="2"
	/*		loop
				spawn(10)
					for(var/mob/M in oview(14))if(M==owner)
						if(owner:curchakra)
							owner:curchakra-=100
							if(owner:curchakra==0)
								owner<<"<b>You ran out of chakra to control iron sand."
								del src
						else del src
						goto loop
					del src*/
		Move()
			..()
		//	var/conmult = owner.str*2
			//if(!owner)del src
			for(var/mob/M in oview(1))
				if(M == owner)	return
				while(M in oview(1))
					if(M.ironskin == 1)	 return
					M = M.Replacement_Start(owner)
					M.Damage(rand(50,100), 0, owner, "Magnet", "Normal")
					spawn(5) if(M) M.Replacement_End()
					sleep(30)
/*				if(M==owner||M.isiron||attacking)continue
				attacking=1
				spawn(20)attacking=0
				if(owner:inchunin!=4)if(owner:village==M.village&&!M.pktoggle&&!owner:pktoggle&&owner:village!="None")continue
				var/damage=round(round(owner:pow/3.5)-(round(M.def/3))+rand(2,5))
				M.clothingboosts(src,1)
				damage=(damage*M.variable)+M.variable2
				if(skillpowplus)damage=round(damage*(1.11+(0.03*(skillstrplus-1))))
				if(village=="Leaf"&&leafpriority=="Aggressiveness"||village=="Sand"&&sandpriority=="Aggressiveness"||village=="Sound"&&soundpriority=="Aggressiveness")damage=round(damage*1.15)
				if(damage<1)damage=1
				if(M.shield||M.pines)damage=0
				if(M.sandshield)
					damage=0
					M.cha-=rand(1,8)
					if(M.cha<=0)
						M.cha=0
						M<<output("You have ran out of chakra!","infobox")
						M.shelloff()
				M.hp-=damage
				new/obj/hit(M.loc)
				M.death(owner)*/
		Bump(A)
			if(ismob(A))
				//if(istype(A,/mob/byakuyapetals))return
				loc=A:loc
			if(isobj(A))loc=A:loc
/*mob/Click()
	if(usr.ironsand==1)
		for(var/mob/human/ironsand/K in world)if(K.owner==usr)
			var/w=rand(0,2)
			walk_towards(K,locate(K.x+rand(-w,w),K.y+rand(-w,w),K.z))
			spawn(w)
				walk_to(K,locate(x+rand(-2,2),y+rand(-2,2),z))
				spawn(rand(4,7))
				walk_towards(K,loc)
	..()
obj/Click()
	if(usr.ironsand==1)
		for(var/mob/human/ironsand/K in world)if(K.owner==usr)
			var/w=rand(0,2)
			walk_towards(K,locate(K.x+rand(-w,w),K.y+rand(-w,w),K.z))
			spawn(w)
				walk_to(K,locate(x+rand(-2,2),y+rand(-2,2),z))
				spawn(rand(4,7))
				walk_towards(K,loc)
	..()
turf/Click()
	if(usr.ironsand==1)
		for(var/mob/human/ironsand/K in world)if(K.owner==usr)
			var/w=rand(0,3)
			walk_towards(K,locate(K.x+rand(-w,w),K.y+rand(-w,w),K.z))
			spawn(w)walk_towards(K,src)
	..()*/

obj
	ironspikes
		name="Iron Sand Spike"
		density=1
		invisibility=4
		layer=15
		animate_movement=0
		var/first=0
		var/moveamount=0
		Bump(A)
			if(ismob(A))
				loc=A:loc
				A:Damage(rand(50,100), 0, owner, "Magnet", "Normal")
				spawn(2)if(A)A:Damage(rand(50,100), 0, owner, "Magnet", "Normal")
			if(isobj(A))del src
			if(isturf(A))del src
		Move()
			moveamount++
			if(moveamount>15)del src
			..()
			new/obj/ironspiketrail(loc)

	ironspiketrail
		name="Iron Sand Spike"
		invisibility=3
		layer=15
		New()
			flick('spike.dmi',src)
			spawn(9)del src
