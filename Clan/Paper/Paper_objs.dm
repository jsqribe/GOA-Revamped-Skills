obj/paper_spear
	icon = 'paper_bomb.dmi'
	icon_state = "1"
	density = 0
    
obj
	black
		icon='icons/black.dmi'



//moved paper_bomb to use deidara logic.
obj
	paper_bomb

		icon = 'paper_bomb.dmi'
		icon_state = "1"

		layer = MOB_LAYER + 0.1

		Click(location,control,params)
			if(owner == usr)
				Explode(usr)

		New(location)

			var
				state = "[rand(1,14)]"
				time = 120

			loc = location
			pixel_x = rand(-12,12)
			pixel_y = rand(-12,12)

			icon_state = state

			spawn()
				while(time > 0 && loc != null)
					for(var/mob/m in oview(1,src))
						if(m != owner)
							m.movepenalty = 20
					time--
					sleep(10)
				loc = null

		proc
			Explode(mob/user)
				if(user) user.RemoveTrigger(src)
				if(owner != user || user.ko || user.stunned)
					return

				explosion(150*user:ControlDamageMultiplier(),x,y,z,user,dist = 4)

			//	user.protected+=1
				//spawn(10)user.protected=0

				loc = null    