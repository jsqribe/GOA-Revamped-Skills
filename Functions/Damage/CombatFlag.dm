mob
	proc
		CombatFlag(type)
			switch(type)
				if("offense")
					combatflago = world.time
				if("defense")
					combatflagd = world.time
				else
					combatflago = world.time
					combatflagd = world.time
		isCombatFlag(var/num=15, type)
			switch(type)
				if("offense")
					if(combatflago < world.time - num*10)
						return 0
				if("defense")
					if(combatflagd < world.time - num*10)
						return 0
				else
					if((combatflago < world.time - num*10) || (combatflagd < world.time - num*10))
						return 0
			return 1