atom/Click(location,control,params_text)
	var/list/params = params2list(params_text)
	if(istype(usr,/mob/human/player))
		var/mob/human/player/USR=usr
		if(usr.pet)
			for(var/mob/human/player/npc/p in usr.pet)
				if(usr && p)
					walk_towards(p,src,3)

		if(usr:stunned)
			return
		if(USR.puppetsout == 2)
			if(params["shift"])
				if(USR.Puppet2 && USR.Puppet2 != src && USR.Puppet2 != USR.Primary)
					spawn() USR.Puppet2.pwalk_towards(USR.Puppet2,src,2)
			else
				if(USR.Puppet1 && USR.Puppet1 != src && USR.Puppet1 != USR.Primary)
					spawn() USR.Puppet1.pwalk_towards(USR.Puppet1,src,2)
		else if(USR.puppetsout == 1)
			if(USR.Puppet1 && USR.Puppet1 != src && USR.Puppet1 != USR.Primary)
				spawn() USR.Puppet1.pwalk_towards(USR.Puppet1,src,2)
			if(USR.Puppet2 && USR.Puppet2 != src && USR.Puppet2 != USR.Primary)
				spawn() USR.Puppet2.pwalk_towards(USR.Puppet2,src,2)

		if(USR.pet)
			var/mob/human/sandmonster/p=USR.Get_Sand_Pet()

			if(p) walk_towards(p,src,1)
