obj/BSEnter
	icon='icons/bloodtracks.dmi'
	icon_state="enter"
	New()
		..()
		spawn(rand(70,110))
			del(src)
obj/BSExit
	icon='icons/bloodtracks.dmi'
	icon_state="exit"
	New()
		..()
		spawn(rand(70,110))
			del(src)




mob/proc/Blood_Add(mob/V)
	if(V)
		if(!bloodrem.Find(V))
			bloodrem+=V
			//world<<"Adding [V.name] to blood list"
			spawn(600+world.tick_lag) //Spawn Tick Changes
				bloodrem-=V

		//else
			//world<<"[V.name] already in blood list"