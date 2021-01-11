
mob/proc
	CheckBonesword()
		if(boneuses<=0)
			hasbonesword=0
			boneuses=0
			for(var/obj/items/weapons/xox in contents)
				if(istype(xox,/obj/items/weapons/melee/sword/Bone_Sword))
					weapon=new/list
					xox.loc = null
			Load_Overlays()
			
proc
	SpireCircle(bx, by, bz, finrad, mob/cause)
		var/rad = 0
		var/rad2 = 0
		var/nx = bx
		var/ny = by
		var/nx2 = bx
		var/list/listx = new()
		var/nx3 = bx
		var/nx4 = bx

		while(rad < finrad)
			rad += 2
			rad2 += 1
			nx = bx + rad
			nx2 = bx + rad2
			nx3 = bx - rad
			nx4 = bx - rad2
			var/diff = 0
			var/diff2 = 1

			spawn()
				var/mx2 = nx2

				if(rad2 == 1)
					listx += new /obj/Bonespire(locate(bx, ny+rad2, bz), cause)
					listx += new /obj/Bonespire(locate(bx, ny-rad2, bz), cause)
				else
					listx += new /obj/Bonespire(locate(bx, ny+rad2-1, bz), cause)
					listx += new /obj/Bonespire(locate(bx, ny-rad2+1, bz), cause)

				while(mx2 > bx)
					listx += new /obj/Bonespire(locate(mx2, ny-diff2, bz), cause)
					listx += new /obj/Bonespire(locate(mx2, ny+diff2, bz), cause)

					mx2 -= 2
					diff2 += 2

			spawn()
				var/mx = nx
				while(mx > bx)
					if(diff)
						listx += new /obj/Bonespire(locate(mx, ny+diff, bz), cause)
						listx += new /obj/Bonespire(locate(mx, ny-diff, bz), cause)

					mx -= 2
					diff += 2

			var/diff3 = 0
			var/diff4 = 1

			spawn()
				var/mx2 = nx4

				if(rad2 == 1)
					listx += new /obj/Bonespire(locate(bx+rad2, ny, bz), cause)
					listx += new /obj/Bonespire(locate(bx-rad2, ny, bz), cause)
				else
					listx += new /obj/Bonespire(locate(bx+rad2-1, ny, bz), cause)
					listx += new /obj/Bonespire(locate(bx-rad2+1, ny, bz), cause)

				while(mx2 < bx)
					listx += new /obj/Bonespire(locate(mx2, ny+diff4, bz), cause)
					listx += new /obj/Bonespire(locate(mx2, ny-diff4, bz), cause)
					mx2 += 2
					diff4 += 2

			spawn()
				var/mx = nx3
				while(mx < bx)
					if(diff3)
						listx += new /obj/Bonespire(locate(mx, ny+diff3, bz), cause)
						listx += new /obj/Bonespire(locate(mx, ny-diff3, bz), cause)

					mx += 2
					diff3 += 2

			rad2 += 1
			sleep(5)

		for(var/obj/Bonespire/E in listx)
			E.causer = cause
