mob
	var
		Puppets[2]
		puppetsave[][]
		tmp/puppetsout


mob/human/Puppet
	Move(turf/new_loc,dirr)
		. = ..()
		var/area/A = loc.loc
		if(!A.pkzone)
			src.curwound=900
			src.curstamina=0
			src.Hostile()
		return


mob/human/Puppet/proc
	Melee(mob/u)
		var/nopk
		for(var/area/O in oview(0,src))
			if(!O.pkzone)
				nopk=1
			else
				nopk=0
		if(nopk)
			return
		if(!src.stunned && !u.ko && !u.stunned)
			if(!src.coold)
				flick("Melee",src)
				src.coold+=src.meleecost
				var/mob/human/ptarget = u.MainTarget()
				if(ptarget && !ptarget.ko && !ptarget.IsProtected())
					if(ptarget in ohearers(1,src))
						src.FaceTowards(ptarget)
						ptarget = ptarget.Replacement_Start(u)
						if(!ptarget.icon_state) flick("hurt",ptarget)
						ptarget.Damage(((rand(50,100)*src.meleedamage)/100),rand(0,src.wounddamage), u, "Puppet Melee", "Normal")
						ptarget.Hostile(u)
						var/b=pick(1,2,3)
						if(b==3)
							Blood2(ptarget)
						spawn(5) if(ptarget) ptarget.Replacement_End()
						return
				for(var/mob/human/X in get_step(src,src.dir))
					if(!X.ko && !X.IsProtected())
						X = X.Replacement_Start(u)
						if(!X.icon_state)
							flick("hurt",X)
						X.Damage(((rand(50,100)*src.meleedamage)/100),rand(0,src.wounddamage), u, "Puppet Melee", "Normal")
						X.Poison+=src.Pmod
						X.Hostile(u)
						var/b=pick(1,2,3)
						if(b==3)
							Blood2(X)
						spawn(5) if(X) X.Replacement_End()
						return
	Def(mob/u)
		if(!src.stunned)
			u.controlmob=u//reset to control your mob
			src.AppearAt(u.x,u.y,u.z)


	pwalk_towards(mob/human/Puppet/a,atom/b,lag=0,dur=60)

		if(a.walking) return
		else a.walking = 1

		while(a && a.walking && !a.stunned && b && dur > 0)

			//a.base_StepTowards(b)
			step_to(a,b)
			if(get_dist(a,b)<=1)
				walk(a,0)//stop any more movement
				a.walking = 0


			dur -= world.tick_lag+lag
			sleep(world.tick_lag+lag)

		//reset
		//world << "Distance [get_dist(a,b)] walking=[a.walking] stunned=[a.stunned] duration=[dur] [a]([x],[y]) -> [b]([b.x],[b.y])"
		a.walking = 0







mob
	human
		Puppet
			pk=1
			var
				saveindex=0
				coold=0
				coold2[20]
				meleedamage=0
				wounddamage=0
				meleecost=1
				Pmod=0
				mob/human/owner
				walking
				stopwalking
			Karasu
				icon='icons/puppet1.dmi'
				initialized=1
				protected=0
				ko=0
				str=65
				con=65
				rfx=65
				int=65
				stamina=5000
				curstamina=5000
				chakra=300
				meleedamage=200
				wounddamage=2
				meleecost=2

				Advanced
					str = 80
					con = 80
					rfx = 80
					int = 80
					stamina = 6000
					curstamina = 6000
					chakra = 400
					meleedamage = 400

				Master
					str = 95
					con = 95
					rfx = 95
					int = 95
					stamina = 7000
					curstamina = 7000
					chakra = 500
					meleedamage = 600


			Cursed_Doll
				var/connected_mob = null
				icon='MPSKF.dmi'
				str = 120
				con = 120
				rfx = 120
				int = 120
				stamina = 10000
				curstamina = 10000
				chakra = 10000
				meleedamage = 10000

				New(loc, mob/attacker)
					..()
					if(attacker)
						spawn(attacker.int/3)
							src.KO()




mob/human/Puppet
	KO()
		Poof(src.x,src.y,src.z)
		if(istype(src,/mob/human/Puppet/Cursed_Doll))
			src.loc=null
		if(owner.Puppet1==src)
			var/skill/puppet_skill = owner.GetSkill(PUPPET_SUMMON1)
			owner.Puppet1 = null
			owner.puppetsout--
			spawn() puppet_skill.DoCooldown(owner)
		else if(owner.Puppet2==src)
			var/skill/puppet_skill = owner.GetSkill(PUPPET_SUMMON2)
			owner.Puppet2 = null
			owner.puppetsout--
			spawn() puppet_skill.DoCooldown(owner)
		spawn(3)
			src.loc=null
	proc
		PuppetRegen(mob/u)
			while(u)
				if(src.icon_state=="hurt")
					src.icon_state=0
				if(src.coold)
					src.coold--
				var/i=1
				while(i<20)
					if(src.coold2[i])
						src.coold2[i]--
					i++
				if(src.curwound > 50)
					KO()
				sleep(5)
			spawn(3)
				src.loc=null

