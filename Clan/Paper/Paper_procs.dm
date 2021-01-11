client
	Click(object,location,control,params)
		..()

		for(var/obj/paper_bomb/p in location)
			if(p.owner == mob)
				p.Explode(mob)
				return

		for(var/obj/paper_bomb/p in view(1,object))
			if(p.owner == mob)
				p.Explode(mob)
				return
