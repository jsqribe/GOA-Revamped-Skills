mob/proc/Leaf_Gale_Stun(duration)
	src.Begin_Stun()
	src.dir=turn(SOUTH,-90)
	sleep(5)
	src.dir=turn(WEST,-90)
	sleep(5)
	src.dir=turn(NORTH,-90)
	sleep(5)
	src.dir=turn(EAST,-90)
	sleep(5)
	flick("Knockout", src)
	spawn(duration)
		src.End_Stun()



mob/proc/Nirvana_Stun(duration)
	src.Begin_Stun()
	spawn(duration)
		src.End_Stun()

proc/Lion_Combo(mob/user,mob/etarget)
	var/vx=etarget.x
	var/vy=etarget.y
	var/vz=etarget.z
	user.AppearBefore(etarget)
	flick("KickA-1",user)
	if(etarget.larch) return 0
	if(!user)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.Replacement_End()
		return 0
	if(!etarget)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		return 0
	var/LOx=user.x
	var/LOy=user.y
	var/LOz=user.z

	user.Begin_Stun()
	etarget.Begin_Stun()
	sleep(2)
	if(!user)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.loc=locate(vx,vy,vz)
	user.AppearBefore(etarget)
	sleep(3)
	if(!user)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	user.incombo=1
	etarget.incombo=1
	user.x=vx
	user.y=vy
	user.z=vz
	var/obj/S=new/obj(locate(vx,vy,vz))
	S.density=0
	S.icon='icons/shadow.dmi'

	etarget.dir=SOUTH
	user.Protect(100)
	etarget.Protect(100)
	user.dir=SOUTH
	var/obj/O = new/obj(locate(vx,vy,vz))
	O.density=0
	O.icon='icons/appeartai.dmi'
	spawn(5)
		O.loc = null

	etarget.icon_state="hurt"
	etarget.layer=MOB_LAYER+13
	user.layer=MOB_LAYER+12
	etarget.pixel_y=3
	user.pixel_y=etarget.pixel_y

	etarget.loc = user.loc
	var/E=50
	spawn()
		user.pixel_x = 8
		user.pixel_y += 5
	while(etarget&&user&&E>0)
		etarget.pixel_y += 4
		user.pixel_y += 4

		E-=2
		sleep(1)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0

	S.loc=locate(vx,vy,vz)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	user.dir=WEST
	user.icon_state="Throw1"
	user.pixel_y=etarget.pixel_y+3
	etarget.loc = user.loc

	user.pixel_x=8

	flick("PunchA-1",user)
	spawn()smack(etarget,5,8)
	etarget.pixel_y+=5
	sleep(1)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.pixel_y++
	sleep(1)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.pixel_y++
	sleep(1)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.pixel_y++
	sleep(1)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0

	user.pixel_y+=8
	user.icon_state=""
	user.pixel_y=etarget.pixel_y-3
	etarget.loc = user.loc
	user.pixel_x=8
	flick("KickA-1",user)
	spawn()smack(etarget,2,4)
	sleep(4)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.layer=MOB_LAYER+12
	user.layer=MOB_LAYER+13

	flick("KickA-2",user)
	spawn()smack(etarget,5,6)
	sleep(4)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	user.pixel_x=0
	user.dir=NORTH
	user.pixel_y=etarget.pixel_y+6
	etarget.loc = user.loc
	user.pixel_x=0
	flick("KickA-1",user)
	spawn() if(etarget) smack(etarget,0,8)
	sleep(2)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.pixel_y-=2
	sleep(2)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.pixel_y-=2
	etarget.layer=MOB_LAYER+13
	user.layer=MOB_LAYER+12

	user.dir=EAST
	user.pixel_y=etarget.pixel_y+3
	etarget.loc = user.loc
	user.pixel_x=-8
	flick("KickA-2",user)
	spawn()smack(etarget,-5,6)
	sleep(4)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.layer=MOB_LAYER+12
	user.layer=MOB_LAYER+13

	flick("KickA-1",user)
	spawn()smack(etarget,-2,4)
	sleep(2)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	spawn()
		if(etarget)
			etarget.Fallpwn()
	sleep(2)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	user.overlays+='icons/appeartai.dmi'
	user.pixel_x=0
	user.pixel_y=0
	user.loc=locate(LOx,LOy,LOz)
	etarget.loc=locate(vx,vy,vz)
	etarget.dir=SOUTH
	user.AppearBefore(etarget)
	sleep(6)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.Replacement_End()
		return 0
	user.overlays-='icons/appeartai.dmi'
	sleep(4)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.End_Protect()
		etarget.icon_state=""
		etarget.stunned=0
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.End_Protect()
		user.icon_state=""
		user.stunned=0
		return 0
	user.End_Protect()
	etarget.End_Protect()
	sleep(2)
	if(!user)
		S.loc = null
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.Replacement_End()
		return 0
	if(!etarget)
		S.loc = null
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.icon_state=""
		user.stunned=0
		return 0
	user.incombo=0
	user.End_Stun()
	S.loc = null
	var/result=Roll_Against(user.rfx+user.rfxbuff-user.rfxneg,etarget.rfx+etarget.rfxbuff-etarget.rfxneg,100)
	return result



proc/Front_Lotus(mob/user,mob/etarget)
	var/vx=etarget.x
	var/vy=etarget.y
	var/vz=etarget.z
	user.AppearBefore(etarget)
	spawn()smack(etarget,5,8)
	user.icon_state="Throw2"
//		flick("KickA-1",user)
	if(etarget.larch)
		return 0
	if(!user)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		return 0
	if(!etarget)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		return 0
	var/LOx=user.x
	var/LOy=user.y
	var/LOz=user.z

	user.stunned=15
	etarget.stunned=15
	spawn()smack(etarget,5,8)
	sleep(2)
	if(!user)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.loc=locate(vx,vy,vz)
	user.AppearBefore(etarget)
	spawn()smack(etarget,5,8)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	sleep(3)
	if(!user)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	user.incombo=1
	etarget.incombo=1
	spawn()smack(etarget,5,8)
	user.x=vx
	user.y=vy
	user.z=vz
	var/obj/S=new/obj(locate(vx,vy,vz))
	S.density=0
	S.icon='icons/shadow.dmi'

	etarget.dir=SOUTH
//	user.protected=10
//	etarget.protected=10
	user.dir=SOUTH
	var/obj/O = new/obj(locate(vx,vy,vz))
	O.density=0
	O.icon='icons/appeartai.dmi'
	spawn(5)
		del(O)

	etarget.icon_state="hurt"
	etarget.layer=MOB_LAYER+13
	user.layer=MOB_LAYER+12
	etarget.pixel_y=3
	user.pixel_y=etarget.pixel_y
	spawn()smack(etarget,5,8)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)

	etarget.y=user.y
	var/E=50
	spawn()
		user.pixel_x = 8
		user.pixel_y += 5
	while(etarget&&user&&E>0)
		etarget.pixel_y += 4
		user.pixel_y += 4

		E-=2
		sleep(1)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0

	S.loc=locate(vx,vy,vz)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	user.dir=WEST
//	user.icon_state="Throw1"
	etarget.overlays+=image('icons/front.dmi',icon_state = "1",pixel_x=0,pixel_y=0)
	etarget.overlays+=image('icons/front.dmi',icon_state = "2",pixel_x=0,pixel_y=32)
	user.pixel_y=etarget.pixel_y+3
	etarget.y=user.y

	user.pixel_x=8
	spawn()smack(etarget,5,8)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)

//		flick("PunchA-1",user)
	spawn()smack(etarget,5,8)
	etarget.pixel_y+=5
	sleep(1)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	user.dir=WEST
//	user.icon_state="Throw1"
	etarget.overlays+=image('icons/front.dmi',icon_state = "1",pixel_x=0,pixel_y=0)
	etarget.overlays+=image('icons/front.dmi',icon_state = "2",pixel_x=0,pixel_y=32)
	user.pixel_y=etarget.pixel_y+3
	etarget.y=user.y

	user.pixel_x=8

//		flick("PunchA-1",user)
	spawn()smack(etarget,5,8)
	etarget.pixel_y+=5
	sleep(1)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.pixel_y++
	sleep(1)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.pixel_y++
	sleep(1)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.pixel_y++
	sleep(1)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0

	user.pixel_y+=8
	user.icon_state=""
	user.pixel_y=etarget.pixel_y-3
	etarget.y=user.y
	user.pixel_x=8
//	flick("KickA-1",user)
	spawn()smack(etarget,5,8)
	spawn()smack(etarget,2,4)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	sleep(4)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.layer=MOB_LAYER+12
	user.layer=MOB_LAYER+13
	spawn()smack(etarget,5,8)
//		flick("KickA-2",user)
	spawn()smack(etarget,5,6)
	sleep(4)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	user.pixel_x=0
	user.dir=NORTH
	user.pixel_y=etarget.pixel_y+6
	etarget.y=user.y
	user.pixel_x=0
//		flick("KickA-1",user)
	spawn()smack(etarget,5,8)
	spawn() if(etarget) smack(etarget,0,8)
	sleep(2)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.pixel_y-=2
	sleep(2)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.pixel_y-=2
	etarget.layer=MOB_LAYER+13
	user.layer=MOB_LAYER+12
	spawn()smack(etarget,5,8)

	user.dir=EAST
	user.pixel_y=etarget.pixel_y+9
	etarget.y=user.y
	user.pixel_x=-4
//	flick("KickA-2",user)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	sleep(4)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.layer=MOB_LAYER+12
	user.layer=MOB_LAYER+13
	spawn()smack(etarget,5,8)

//		flick("KickA-1",user)
	spawn()smack(etarget,-2,4)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	etarget.overlays+=image('icons/front.dmi',icon_state = "3",pixel_x=-16,pixel_y=0)
	etarget.overlays+=image('icons/front.dmi',icon_state = "4",pixel_x=16,pixel_y=0)
	etarget.overlays+=image('icons/front.dmi',icon_state = "5",pixel_x=-16,pixel_y=32)
	etarget.overlays+=image('icons/front.dmi',icon_state = "6",pixel_x=16,pixel_y=32)
	etarget.overlays+=image('icons/front.dmi',icon_state = "7",pixel_x=-16,pixel_y=64)
	etarget.overlays+=image('icons/front.dmi',icon_state = "8",pixel_x=16,pixel_y=64)
	sleep(2)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	etarget.pixel_y-=2
	etarget.layer=MOB_LAYER+13
	user.layer=MOB_LAYER+12
	spawn()smack(etarget,5,8)

	user.dir=EAST
	user.pixel_y=etarget.pixel_y+9
	etarget.y=user.y
	user.pixel_x=-4
//	flick("KickA-2",user)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	spawn()smack(etarget,-5,6)
	sleep(4)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	spawn() if(etarget) etarget.Fallpwn()
	sleep(2)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		etarget.loc=locate(vx,vy,vz)
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		user.loc=locate(LOx,LOy,LOz)
		return 0
	user.overlays+='icons/appeartai.dmi'
	user.pixel_x=0
	user.pixel_y=0
	user.loc=locate(LOx,LOy,LOz)
	etarget.loc=locate(vx,vy,vz)
	etarget.dir=SOUTH
	user.AppearBefore(etarget)
	sleep(6)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		return 0
	user.overlays-='icons/appeartai.dmi'
	etarget.overlays-=image('icons/front.dmi',icon_state = "1",pixel_x=0,pixel_y=0)
	etarget.overlays-=image('icons/front.dmi',icon_state = "2",pixel_x=0,pixel_y=32)
	sleep(4)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		return 0
	user.protected=0
	etarget.protected=0
	sleep(2)
	if(!user)
		del(S)
		etarget.pixel_x=0
		etarget.pixel_y=0
		etarget.incombo=0
		etarget.protected=0
		etarget.icon_state=""
		etarget.stunned=0
		return 0
	if(!etarget)
		del(S)
		user.pixel_x=0
		user.pixel_y=0
		user.incombo=0
		user.protected=0
		user.icon_state=""
		user.stunned=0
		return 0
	user.incombo=0
	user.stunned=0
	etarget.overlays-=image('icons/front.dmi',icon_state = "1",pixel_x=0,pixel_y=0)
	etarget.overlays-=image('icons/front.dmi',icon_state = "2",pixel_x=0,pixel_y=32)
	etarget.overlays-=image('icons/front.dmi',icon_state = "3",pixel_x=-16,pixel_y=0)
	etarget.overlays-=image('icons/front.dmi',icon_state = "4",pixel_x=16,pixel_y=0)
	etarget.overlays-=image('icons/front.dmi',icon_state = "5",pixel_x=-16,pixel_y=32)
	etarget.overlays-=image('icons/front.dmi',icon_state = "6",pixel_x=16,pixel_y=32)
	etarget.overlays-=image('icons/front.dmi',icon_state = "7",pixel_x=-16,pixel_y=64)
	etarget.overlays-=image('icons/front.dmi',icon_state = "8",pixel_x=16,pixel_y=64)
	user.icon_state=""
	del(S)
	var/result=Roll_Against(user.rfx+user.rfxbuff-user.rfxneg,etarget.rfx+etarget.rfxbuff-etarget.rfxneg,100)
	return result