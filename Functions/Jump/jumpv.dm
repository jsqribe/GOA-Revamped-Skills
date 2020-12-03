mob
	verb
		jumpv()
			set name="Jump"
			set hidden = 1
			if(!usr.is_jumping || !usr.pk || !usr.stunned||!usr.handseal_stun||!usr.kstun||!usr.ko||!usr.Size||!usr.Tank||!usr.mole||!usr.skillusecool||!usr.Fly)
				usr.jump()

mob/proc
	jump()
		if(usr.is_jumping || !usr.pk || usr.stunned||usr.handseal_stun||usr.kstun||usr.ko||usr.Size||usr.Tank||usr.mole||usr.skillusecool||usr.Fly)
			return
		var/atom/a = get_steps(usr, usr.dir, 7)
		if(a.density || !a)
			return


		spawn()
			usr.curstamina-=200
			usr.is_jumping = 1
			var/jumpt = 0
			usr.icon_state = "Run"
			usr.density = 0
			usr.layer += 140
			while(src && jumpt <= jump_time/2)
				jumpt += 10
				usr.pixel_y += 5
				switch(usr.dir)
					if(NORTH)
						usr.loc = locate(usr.x, usr.y+1, usr.z)
					if(SOUTH)
						usr.loc = locate(usr.x, usr.y-1, usr.z)
					if(EAST)
						usr.loc = locate(usr.x+1, usr.y, usr.z)
					if(WEST)
						usr.loc = locate(usr.x-1, usr.y, usr.z)
					if(NORTHEAST)
						usr.loc = locate(usr.x+1, usr.y+1, usr.z)
					if(NORTHWEST)
						usr.loc = locate(usr.x-1, usr.y+1, usr.z)
					if(SOUTHEAST)
						usr.loc = locate(usr.x+1, usr.y-1, usr.z)
					if(SOUTHWEST)
						usr.loc = locate(usr.x-1, usr.y-1, usr.z)
				sleep(1)
			sleep(1)
			while(src && jumpt <= jump_time)
				jumpt += 16
				usr.pixel_y -= 8
				switch(usr.dir)
					if(NORTH)
						usr.loc = locate(usr.x, usr.y+1, usr.z)
					if(SOUTH)
						usr.loc = locate(usr.x, usr.y-1, usr.z)
					if(EAST)
						usr.loc = locate(usr.x+1, usr.y, usr.z)
					if(WEST)
						usr.loc = locate(usr.x-1, usr.y, usr.z)
					if(NORTHEAST)
						usr.loc = locate(usr.x+1, usr.y+1, usr.z)
					if(NORTHWEST)
						usr.loc = locate(usr.x-1, usr.y+1, usr.z)
					if(SOUTHEAST)
						usr.loc = locate(usr.x+1, usr.y-1, usr.z)
					if(SOUTHWEST)
						usr.loc = locate(usr.x-1, usr.y-1, usr.z)
				sleep(1)
			usr.pixel_y = 0
			usr.icon_state = "Run"
			//usr.is_jumping = 0
			usr.density = 1
			usr.layer -= 140
			sleep(100)
			usr.is_jumping = 0