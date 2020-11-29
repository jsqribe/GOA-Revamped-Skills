proc
	advancedprojectile_angle(icon, icon_state, mob/user, speed, angle, distance, damage, wounds=0, daze=0, burn=0, radius=8, atom/from=user)
		if(!from || !speed)
			return

		if(wounds=="passive")
			if(user && user.skillspassive[14] && prob(5*user.skillspassive[14]))
				wounds=pick(1,2,3,4)
			else
				wounds=0

		if(!isnum(wounds))
			wounds = 0

		var/obj/projectile/p = new /obj/projectile(from.loc)
		p.icon = icon
		p.icon_state = icon_state

		p.owner = user
		p.radius = radius
		p.dir=angle2dir_cardinal(angle)

		var/extra_list = list("IgnoreMobs"=list(from))
		if(wounds)
			extra_list["Wound"] = wounds
		if(daze)
			extra_list["Daze"] = daze
		if(burn)
			extra_list["Burn"] = burn

		M_Projectile_Degree(p, user, damage, (distance*32)/speed, speed, angle, extra_list)

	advancedprojectilen(i,estate,mob/efrom,xvel,yvel,distance,damage,wnd,vel,pwn,mob/trueowner,radius)
		if(wnd=="passive")
			if(trueowner&& trueowner.skillspassive[14]&& prob(5*trueowner.skillspassive[14]))
				wnd=pick(1,2,3,4)
			else
				wnd=0
		if(!isnum(wnd))wnd=0
		if(!efrom)
			return
		var/obj/projectile/p = new/obj/projectile(locate(efrom.x,efrom.y,efrom.z))

		p.icon=i
		p.icon_state=estate
		if(radius)p.radius=radius
		else p.radius=8
		if(trueowner)efrom=trueowner
		p.powner=efrom
		var/speed = sqrt(xvel*xvel+yvel*yvel)
		if((!xvel && !yvel )|| speed ==0)
			p.loc = null
			return
		M_Projectile(p,efrom,damage,xvel,yvel,(distance*32) / speed,list("Wound"=wnd,"IgnoreMobs"=list(efrom)))
		return

	advancedprojectile(i,estate,mob/efrom,xvel,yvel,distance,damage,wnd,vel,pwn,mob/trueowner=efrom,radius)
		var/obj/projectile/p = new/obj/projectile(locate(efrom.x,efrom.y,efrom.z))
		p.icon=i
		p.powner=efrom
		p.icon_state=estate
		if(radius)p.radius=radius
		else p.radius=8
		M_Projectile(p,trueowner,damage,xvel,yvel,(distance * 32)/sqrt(xvel*xvel+yvel*yvel),list("Wound"=wnd,"IgnoreMobs"=list(efrom)))
		return

proc
	advancedprojectile_ramped(i,estate,mob/efrom,xvel,yvel,distance,damage,wnd,vel,pwn,daze,radius)//daze as percent/100
		var/obj/projectile/p = new/obj/projectile(locate(efrom.x,efrom.y,efrom.z))
		p.icon=i
		p.powner=efrom
		p.icon_state=estate
		if(radius)p.radius=radius
		else if(pwn) p.radius=16
		else p.radius=8

		M_Projectile(p,efrom,damage,xvel,yvel,(distance * 32)/sqrt(xvel*xvel+yvel*yvel),list("Wound"=wnd,"Daze"=daze,"IgnoreMobs"=list(efrom)))

	advancedprojectile_returnloc(xtype,mob/efrom,xvel,yvel,distance,vel,dx,dy,dz)
		var/obj/p = new xtype(locate(dx,dy,dz))
		var/horiz=0
		var/vertic=0
		if(abs(xvel)>abs(2*yvel))
			horiz=1
		else if(abs(yvel)>abs(2*xvel))
			vertic=1
		if(!horiz&&!vertic)
			if(xvel>0 && yvel>0)
				p.dir=NORTHEAST
			if(xvel<0 && yvel>0)
				p.dir=NORTHWEST
			if(xvel>0 && yvel<0)
				p.dir=SOUTHEAST
			if(xvel<0 && yvel<0)
				p.dir=SOUTHWEST
		if(horiz)
			if(xvel>0)
				p.dir=EAST
			else
				p.dir=WEST
		if(vertic)
			if(yvel>0)
				p.dir=NORTH
			else
				p.dir=SOUTH
		p.owner=efrom
		p.xvel=xvel*vel/100
		p.yvel=yvel*vel/100
		p.beenclashed=0

		p.mot=distance
		sleep(3)
	//	walk_to(p,eto,0,1)
		while(p.mot>0&&p)
			if(p.mot<=1)
				p.icon=0
				var/xmod=0
				while(p.pixel_x>32)
					p.pixel_x-=32
					xmod++
				while(p.pixel_x<-32)
					p.pixel_x+=32
					xmod--
				var/ymod=0
				while(p.pixel_y>32)
					p.pixel_y-=32
					ymod++
				while(p.pixel_y<-32)
					p.pixel_y+=32
					ymod--
				var/ploc=locate(p.x+xmod,p.y+ymod,p.z)
				p.loc = null
				return ploc

			if(!p.beenclashed)
				p.pixel_x+=xvel/2
				p.pixel_y+=yvel/2

			if(p.pixel_x>=32)

				var/pass=1
				var/turf/x=locate(p.x+1,p.y,p.z)
				if(!x||x.density==1)
					pass=0
				if(pass)
					p.loc=locate(p.x+1,p.y,p.z)
				//	spawn()if(p)p.pixel_x-=32
				else
					p.mot=0
					var/ploc=p.loc
					p.loc = null
					return ploc

			if(p.pixel_x<=-32)

				var/pass=1
				var/turf/x =locate(p.x-1,p.y,p.z)
				if(!x||x.density==1)
					pass=0
				if(pass)
					p.loc=locate(p.x-1,p.y,p.z)
				//	spawn()if(p)p.pixel_x+=32
				else
					p.mot=0
					var/ploc=p.loc
					p.loc = null
					return ploc
			if(p.pixel_y>=32)

				var/pass=1
				var/turf/x=locate(p.x,p.y+1,p.z)
				if(!x||x.density==1)
					pass=0
				if(pass)
					p.loc=locate(p.x,p.y+1,p.z)
				//	spawn()if(p)p.pixel_y-=32
				else
					p.mot=0
					var/ploc=p.loc
					p.loc = null
					return ploc
			if(p.pixel_y<=-32)
				var/pass=1
				var/turf/x= locate(p.x,p.y-1,p.z)
				if(!x||x.density==1)
					pass=0
				if(pass)
					p.loc=locate(p.x,p.y-1,p.z)
				//	spawn()if(p)p.pixel_y+=32
				else
					p.mot=0
					var/ploc=p.loc
					p.loc = null
					return ploc
			for(var/mob/human/m in oview(1,p))
				if(m!=efrom && !m.mole)
					p.icon=0
					if(!m.icon_state)
						flick("hurt",m)
					p.mot=0
					var/ploc=m.loc
					p.loc = null
					return ploc
			for(var/obj/projc/m in oview(0,p))
				if(m.owner!=p.owner&&m.beenclashed==0&&p.beenclashed==0)

					m.xvel=p.xvel*rand(60,140)/100
					m.yvel=p.xvel*rand(60,140)/100
					m.mot=m.mot/3
					m.beenclashed=1

					var/er=rand(1,3)

					m.icon_state="[m.icon_state]-clashed[er]"
					p.mot=0
					var/ploc=p.loc
					p.loc = null
					return ploc
					//clang
			sleep(1)
			if(p)
				p.mot--

		sleep(5)
		if(p)
			p.mot=0

proc
	projectile_to(i,estate,mob/efrom,atom/eto, maxdistance=-1)
		if(!(efrom&&eto))return
		var/obj/p
		if(efrom)p = new/obj/proj(locate(efrom.x,efrom.y,efrom.z))
		if(p)
			p.icon=i
			p.icon_state=estate
			sleep(1)

			while(p.loc != turf_at(eto) && maxdistance != 0)
				if(!step_to(p, eto)) break
				if(maxdistance > 0)
					--maxdistance
				sleep(1)

			var/turf/end_loc = p.loc

			if(istype(eto,/mob/human))
				if(!eto.icon_state)
					flick("hurt",eto)

			//sleep(5) //commenting this out to see if it improves poison bomb, amungst other things. it seems pointless atm.
			p.loc = null

			return end_loc

	projectile_to2(type,mob/efrom,atom/eto, maxdistance=-1)
		var/obj/p = new type(locate(efrom.x,efrom.y,efrom.z))

		sleep(1)

		while(p.loc != turf_at(eto) && maxdistance != 0)
			if(!step_to(p, eto)) break
			if(maxdistance > 0)
				--maxdistance
			sleep(1)

		var/turf/end_loc = p.loc

		if(istype(eto,/mob/human))
			if(!eto.icon_state)
				flick("hurt",eto)

		sleep(5)
		p.loc = null

		return end_loc

	// Returns the turf at the location of A
	turf_at(atom/A)
		if(A)
			var/turf/loc = A
			while(!istype(loc) && loc.loc)
				loc = loc.loc
			return loc

obj/proj
	density=0
	layer=MOB_LAYER+1
	New()
		spawn(100)
			loc = null


proc
	straight_proj()
		var
			projectile_type = /obj/proj
			projectile_icon
			projectile_icon_state
			next_arg = 1
		if(ispath(args[1]))
			projectile_type = args[1]
		else
			projectile_icon = args[1]
			projectile_icon_state = args[2]
			next_arg = 2

		var
			dist = args[++next_arg]
			mob/human/user = args[++next_arg]
			starting_loc = user.loc
			allow_diags = 0

		if(args.len >= next_arg+3)
			starting_loc = locate(args[++next_arg], args[++next_arg], args[++next_arg])

		if(args.len >= next_arg+1)
			allow_diags = args[++next_arg]

		var/obj/M = new projectile_type(starting_loc)
		if(projectile_icon)
			M.icon = projectile_icon
			M.icon_state = projectile_icon_state

		if(!allow_diags)
			switch(user.dir)
				if(NORTHEAST, NORTHWEST)
					M.dir = NORTH
				if(SOUTHEAST, SOUTHWEST)
					M.dir = SOUTH
				else
					M.dir = user.dir
		else
			M.dir = user.dir

		sleep(1)
		while(dist > 0 && M)
			if(M && user)
				var/mob/hit
				for(var/mob/O in get_step(M,M.dir))
					if(istype(O, /mob/human))
						if(O != user && !O.mole)
							hit = O
							break
				step(M, M.dir)
				sleep(1)
				--dist
				if(hit)
					sleep(1)
					M.loc = null
					return hit
			else if(!user)
				M.loc = null
				return

		if(args.len >= 6 && args[6])
			sleep(1)
			var/returnloc = M.loc
			M.loc = null
			return returnloc
		sleep(2)
		M.loc = null

/*	straight_proj4(eicon,estate,dist,mob/human/u,dx,dy,dz)
		var/obj/proj/M = new/obj/proj(locate(dx,dy,dz))
		M.icon=eicon
		M.icon_state=estate

		sleep(1)
		var/stepsleft=dist
		while(stepsleft>0 && M)
			if(M && u)
				var/mob/hit
				for(var/mob/O in get_step(M,M.dir))
					if(istype(O,/mob/human))
						if(O!=u)
							hit=O
				step(M,M.dir)
				sleep(1)
				stepsleft--
				if(hit)
					sleep(1)
					M.loc = null
					return hit
			else if(!u)
				M.loc = null
				return

		sleep(2)
		M.loc = null

	straight_proj3(type,dist,mob/human/u)
		var/obj/M = new type(locate(u.x,u.y,u.z))
		spawn(20)
			if(M)
				M.loc = null
		if(u.dir==NORTH||u.dir==SOUTH||u.dir==EAST||u.dir==WEST)
			M.dir=u.dir
		if(u.dir==NORTHEAST||u.dir==NORTHWEST)
			M.dir=NORTH
		else if(u.dir==SOUTHEAST|u.dir==SOUTHWEST)
			M.dir=SOUTH
		sleep(1)
		var/stepsleft=dist
		while(stepsleft>0 && M)
			if(M && u)
				var/mob/hit
				for(var/mob/O in get_step(M,M.dir))
					if(istype(O,/mob/human))
						if(O!=u)
							hit=O
				step(M,M.dir)
				sleep(1)
				stepsleft--
				if(hit)
					sleep(1)
					M.loc = null
					return hit
			else if(!u)
				M.loc = null
				return

		sleep(2)
		M.loc = null

	straight_proj2(eicon,estate,dist,mob/human/u)
		var/obj/proj/M = new/obj/proj(locate(u.x,u.y,u.z))
		M.icon=eicon
		M.icon_state=estate
		if(u.dir==NORTH||u.dir==SOUTH||u.dir==EAST||u.dir==WEST)
			M.dir=u.dir
		if(u.dir==NORTHEAST||u.dir==NORTHWEST)
			M.dir=NORTH
		else if(u.dir==SOUTHEAST|u.dir==SOUTHWEST)
			M.dir=SOUTH
		sleep(1)
		var/stepsleft=dist
		while(stepsleft>0 && M)
			if(M && u)
				var/mob/hit
				for(var/mob/O in get_step(M,M.dir))
					if(istype(O,/mob/human))
						if(O!=u)
							hit=O
				step(M,M.dir)
				sleep(1)
				stepsleft--
				if(hit)
					sleep(1)
					M.loc = null
					return hit
			else if(!u)
				M.loc = null
				return

		sleep(2)
		M.loc = null

	straight_proj(eicon,estate,mob/human/u,dist,espeed,epower,ename,maxwound,minwound)
		var/obj/proj/M = new/obj/proj(locate(u.x,u.y,u.z))
		M.icon=eicon
		M.icon_state=estate
		sleep(1)
		if(u.dir==NORTH||u.dir==SOUTH||u.dir==EAST||u.dir==WEST)
			M.dir=u.dir
		if(u.dir==NORTHEAST||u.dir==NORTHWEST)
			M.dir=NORTH
		else if(u.dir==SOUTHEAST|u.dir==SOUTHWEST)
			M.dir=SOUTH
		var/stepsleft=dist
		while(stepsleft>0 && M)
			if(M && u)
				var/mob/hit
				for(var/mob/O in get_step(M,M.dir))
					if(istype(O,/mob/human))
						if(O!=u)
							hit=O
				step(M,M.dir)
				sleep(1)
				stepsleft--
				if(hit)
					var/r=rand(100,200)
					var/result=Roll_Against(usr.rfx+usr.rfxbuff-usr.rfxneg,hit.rfx+hit.rfxbuff-hit.rfxneg,r)
					var/wound_dam
					if(result==6)

						view(6)<<"[usr] Nailed [hit] with [ename]"

						wound_dam = rand(minwound+3,maxwound)
						//hit.Wound(rand(minwound+3,maxwound),0,u)
						Blood2(hit)
					if(result==5)
						view(6)<<"[usr] accurately hit [hit] with [ename]"

						wound_dam = rand(minwound+1,maxwound/2)
						//hit.Wound(rand(minwound+1,maxwound/2),0,u)
						Blood2(hit)
					if(result==4)
						view(6)<<"[usr] hit [hit] dead on with [ename]"

						wound_dam = rand(minwound,minwound+1)
						//hit.Wound(rand(minwound,minwound+1),0,u)

					if(result==3)
						view(6)<<"[usr] partially hit [hit] with [ename]"
					if(result>=3)
						hit.Damage(epower, wound_dam, u, "Projectile Straight", "Normal")
						if(u)
							spawn()hit.Hostile(u)
					sleep(1)
					M.loc = null
			else if(!u)
				M.loc = null
				return
		sleep(2)
		M.loc = null*/