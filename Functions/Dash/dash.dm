mob
	verb
		dash()
			set name="Dash"
			set hidden = 1
			if (usr.is_dashing) usr.is_dashing=0
			/*
			if(!usr.is_dashing || !usr.is_jumping || !usr.pk || !usr.stunned||!usr.handseal_stun||!usr.kstun||!usr.ko||!usr.Size||!usr.Tank||!usr.mole||!usr.skillusecool||!usr.Fly)
				var/mob/etarget = usr.MainTarget()
				var/ei=7
				usr.is_dashing=1
				var/old_loc = src.loc
				if(etarget)
					while(etarget && ei>0)
						for(var/mob/human/o in get_step(usr,usr.dir))
							if(!o.ko&&!o.IsProtected())
								etarget=o
						ei--
						walk(usr,usr.dir,0,32)
						if(old_loc != src.loc)
							var/lightning/shadow_step/shadow_step = new(old_loc)
							shadow_step.dir = src.dir
						sleep(1)
						walk(usr,0)
					sleep(100)
					usr.is_dashing=0
				else
					while(ei>0)
						ei--
						walk(usr,usr.dir,0,32)
						if(old_loc != src.loc)
							var/lightning/shadow_step/shadow_step = new(old_loc)
							shadow_step.dir = src.dir
						sleep(1)
						walk(usr,0)
					sleep(100)
					usr.is_dashing=0
			*/