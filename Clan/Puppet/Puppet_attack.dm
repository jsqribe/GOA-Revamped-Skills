mob/proc
	Puppet_attack()
		if(puppetsout)
			if(!Primary)
				if(puppetsout == 1) //usev for Puppet1
					if(Puppet1 in oview())
						var/mob/human/ptarget = usr.MainTarget()
						if(ptarget && !ptarget.ko) Puppet1.pwalk_towards(Puppet1,ptarget,1,20)
						Puppet1.Melee(usr)
						return
					else if(Puppet2 in oview())
						var/mob/human/ptarget = usr.MainTarget()
						if(ptarget && !ptarget.ko) Puppet2.pwalk_towards(Puppet2,ptarget,1,20)
						Puppet2.Melee(usr)
						return
				else if(puppetsout == 2)
					if(Puppet1 in oview())
						var/mob/human/ptarget = usr.MainTarget()
						if(ptarget && !ptarget.ko && Puppet1) Puppet1.pwalk_towards(Puppet1,ptarget,1,20)
						if(Puppet1) Puppet1.Melee(usr)
						return
			else
				if(Primary) //usev for opposite puppet from Primary, if exists
					if(Primary == Puppet1 && Puppet2)
						if(Puppet2 in oview())
							var/mob/human/ptarget = usr.MainTarget()
							if(ptarget && !ptarget.ko && Puppet2) Puppet2.pwalk_towards(Puppet2,ptarget,1,20)
							if(Puppet2) Puppet2.Melee(usr)
							return
					if(Primary == Puppet2 && Puppet1)
						if(Puppet1 in oview())
							var/mob/human/ptarget = usr.MainTarget()
							if(ptarget && !ptarget.ko && Puppet1) Puppet1.pwalk_towards(Puppet1,ptarget,1,20)
							if(Puppet1) Puppet1.Melee(usr)
							return