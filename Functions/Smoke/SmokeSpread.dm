proc/SmokeSpread(turf/source, type=0, size=3, delay=2, far=3, mob/user)
	if(!user) return
	var/direction
	if(user.dir == NORTHEAST || user.dir == SOUTHEAST)
		direction = EAST
	else if(user.dir == NORTHWEST || user.dir == SOUTHWEST)
		direction = WEST
	else
		direction = user.dir

	var/obj/L = new/obj(source)
	L.dir = direction
	var/obj/C = new/obj(source)
	C.dir = direction
	var/obj/R = new/obj(source)
	R.dir = direction

	var/length = size*2+1
	var/threshold1 = round(length*0.66)
	var/firstin1 = 1
	var/threshold2 = round(length*0.33)
	var/firstin2 = 1
	var/threshold3 = length*0
	var/firstin3 = 1

	var/min = 0
	switch(far)
		if(1) min = threshold1
		if(2) min = threshold2
		if(3) min = threshold3

	while(length>min)
		if(length>threshold1 && far>=1)
			if(firstin1)
				L.dir = turn(L.dir,45)
				R.dir = turn(R.dir,-45)
				firstin1=0
		else if(length>threshold2 && far>=2)
			if(firstin2)
				L.dir = turn(L.dir,-45)
				R.dir = turn(R.dir,45)
				firstin2=0
		else if(length>threshold3 && far>=3)
			if(firstin3)
				L.dir = turn(L.dir,-45)
				R.dir = turn(R.dir,45)
				firstin3=0

		step(L,L.dir)
		step(C,C.dir)
		step(R,R.dir)

		var/num = 0
		if(C.dir == NORTH)
			while(L.x+num < C.x)
				if(type == "ash") AshSmoke(user,L.x+num,L.y,L.z,direction)
				else if(type == "poison") PoisonSmoke(user,L.x+num,L.y,L.z,direction)
				num++
			num = 0
			while(R.x-num > C.x)
				if(type == "ash") AshSmoke(user,R.x-num,R.y,R.z,direction)
				else if(type == "poison") PoisonSmoke(user,R.x-num,R.y,R.z,direction)
				num++
		if(C.dir == SOUTH)
			while(L.x-num > C.x)
				if(type == "ash") AshSmoke(user,L.x-num,L.y,L.z,direction)
				else if(type == "poison") PoisonSmoke(user,L.x-num,L.y,L.z,direction)
				num++
			num = 0
			while(R.x+num < C.x)
				if(type == "ash") AshSmoke(user,R.x+num,R.y,R.z,direction)
				else if(type == "poison") PoisonSmoke(user,R.x+num,R.y,R.z,direction)
				num++
		if(C.dir == WEST)
			while(L.y+num < C.y)
				if(type == "ash") AshSmoke(user,L.x,L.y+num,L.z,direction)
				else if(type == "poison") PoisonSmoke(user,L.x,L.y+num,L.z,direction)
				num++
			num = 0
			while(R.y-num > C.y)
				if(type == "ash") AshSmoke(user,R.x,R.y-num,R.z,direction)
				else if(type == "poison") PoisonSmoke(user,R.x,R.y-num,R.z,direction)
				num++
		if(C.dir == EAST)
			while(L.y-num > C.y)
				if(type == "ash") AshSmoke(user,L.x,L.y-num,L.z,direction)
				else if(type == "poison") PoisonSmoke(user,L.x,L.y-num,L.z,direction)
				num++
			num = 0
			while(R.y+num < C.y)
				if(type == "ash") AshSmoke(user,R.x,R.y+num,R.z,direction)
				else if(type == "poison") PoisonSmoke(user,R.x,R.y+num,R.z,direction)
				num++
		if(type == "ash") AshSmoke(user,C.x,C.y,C.z,direction)
		else if(type == "poison") PoisonSmoke(user,C.x,C.y,C.z,direction)
		sleep(delay)
		length--