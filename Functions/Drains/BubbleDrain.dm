//this needs to move...
mob
	proc
		BubbleDrain()
			src.drowning=1
			spawn()
				while(drownA > 0 || drownD > 0 ||  drownF > 0)
					src.curstamina-=300
					sleep(1)
				src.drowning=0
				src.overlays-=image('drowning_bubble.dmi')
