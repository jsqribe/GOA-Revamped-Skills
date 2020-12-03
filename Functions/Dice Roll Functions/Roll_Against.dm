proc
	Roll_Against(a,d,m) //attackers stats,defenders stats, Multiplier 1%->500%
		var/outcome = ((a*rand(5,10))/(d*rand(5,10))) *m
		var/rank=0
		//critical
		if(outcome >=200)
			rank=6  //way dominated
		if(outcome <200 && outcome >=150)
			rank=5 //dominated
		if(outcome<150 && outcome>=100)
			rank=4 //won
		if(outcome<100 && outcome>=75)
			rank=3 //not fully, but hit
		if(outcome<75 && outcome >=50)
			rank=2 //skimmed
		if(outcome<50 && outcome >=25)
			rank=1 //might have some effect.
		if(outcome <25)
			rank=0 //failed roll
		if(rank<2)
			var/underdog=rand(1,6)
			if(underdog==6)
				rank=4
		return rank