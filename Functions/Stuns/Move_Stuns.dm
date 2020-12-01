mob
	var/tmp/stunendall = 0
	var/tmp/movestunendall = 0
	var/tmp/list/slows[] = list()
	proc
		//Stun

		Timed_Stun(time)
			if(src.chambered || src.IsProtected()) return
			Begin_Stun()
			spawn()
				while(time > 0)
					if(stunendall) break
					--time
					sleep(1)
				End_Stun()
				src.icon_state=""

		Begin_Stun()
			stunned++

		End_Stun()
			stunned--
			if(stunned < 0) stunned = 0

		Reset_Stun()
			spawn()
				stunned = 0
				stunendall = 1
				sleep(1)
				stunendall = 0

		Stakes_Time(time)
			src.stakes=1
			spawn()
				while(time > 0)
					--time
					sleep(1)
				src.stakes=0
			src.overlays-=image('icons/genjutsuitachi.dmi')

		//Move Stun
		Timed_Move_Stun(time,severity=2)
			if(src.chambered || src.IsProtected()) return
			//Begin_Move_Stun()
			if(client) client.run_count = 0
			move_stun++
			slows.Add(severity)
			spawn()
				while(time > 0)
					if(movestunendall) break
					--time
					sleep(1)
				if(move_stun > 0) move_stun--
				slows.Remove(severity)
				//End_Move_Stun()

		Get_Move_Stun()
			var/highestslow
			if(slows.len)
				for(var/i in slows)
					if(!highestslow)
						highestslow = i
					else if(i > highestslow)
						highestslow = i
				return highestslow
			else
				return 0

		Reset_Move_Stun()
			spawn()
				move_stun = 0
				movestunendall = 1
				sleep(1)
				movestunendall = 0