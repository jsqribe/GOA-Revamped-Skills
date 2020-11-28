mob/human/player/npc
	bunshin
		auto_ai = 0
		initialized=1
		protected=0
		ko=0



		var
			bunshinowner=1
			bunshintype=0
			life=60



		New()
			..()
			spawn()
				while(src.life>0)
					sleep(10)
					src.life--

				if(src.invisibility<=2)
					Poof(src.x,src.y,src.z)
				src.invisibility=4
				src.targetable=0
				src.density=0
				spawn(50)
					loc = null


		Dec_Stam()
			return


		Wound()
			return


		Hostile(mob/human/player/attacker)
			. = ..()
			if(bunshintype == 0)
				spawn() Poof(x, y, z)
				invisibility = 100
				loc = null
				targetable = 0
				density = 0
				// Didn't this just happen two lines above? Not even a sleep to give other stuff a chance to mess it up.
				targetable = 0
				loc = null
				//spawn(500)
				//	del(src)




	kage_bunshin
		auto_ai = 0
		initialized=1
		protected=0
		ko=0



		var
			ownerkey=""
			owner=""
			temp=0
			exploading=0
			attack_cd



		New()
			..()
			spawn(10)
				if(temp)
					spawn(temp)
						src.Hostile()


		Dec_Stam()
			return


		Wound()
			return


		Hostile(mob/human/player/attacker)
			spawn()
				var/dx = x
				var/dy = y
				var/dz = z
				if(!exploading)
					spawn() Poof(dx,dy,dz)
				else
					exploading = 0
					var/mob/owner = src
					for(var/mob/human/player/p in gameLists["mobiles"])
						if(p.key == ownerkey)
							owner = p
							break
					spawn() explosion(rand(1000, 2500), dx, dy, dz, owner)
					icon = 0
					targetable = 0
					invisibility = 100
					density = 0
					sleep(30)
				FilterTargets()
				for(var/mob/T in targets)
					RemoveTarget(T)
				dead = 1
				stunned = 100

				loc = locate(0, 0, 0)
				for(var/mob/human/player/p in gameLists["mobiles"])
					if(p.key == ownerkey)
						p.controlmob = 0
						if(p && p.client && p.client.mob)
							p.client.eye = p.client.mob
						break
				invisibility = 100
				targetable = 0
				density = 0
				targetable = 0
				spawn(100)
					loc = null
			return ..()