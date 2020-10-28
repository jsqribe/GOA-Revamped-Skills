mob/var/tmp/protectendall = 0
mob/proc
	Protect(protect_time as num)
		protected++
		spawn()
			while(protect_time > 0)
				if(protectendall)
					protectendall = max(0, --protectendall)
					//--protectendall
				//	if(protectendall < 0) protectendall = 0
					break

				protect_time--
				sleep(1)
			protected = max(0, --protected)
			if(bdome==1)
				bdome=0
				overlays-='bubble_dome.dmi'
			//if(protected < 0) protected = 0

	End_Protect()
		if(protected > 0)
			protectendall = protected
			protected = 0

	IsProtected() //Proc to consolidate some protect stuff so that the code doesn't need to be littered with similar vars. (Mainly for puppet shield though)
		if(protected || mole)
			return 1
		for(var/obj/Shield/s in oview(1,src))
			if(istype(src, /mob/human/Puppet))
				if(src == s.owner)
					return 1
			if(istype(src, /mob/human/player))
				if(Puppet1)
					if(Puppet1 == s.owner)
						return 1
				else if(Puppet2)
					if(Puppet2 == s.owner)
						return 1
		return 0