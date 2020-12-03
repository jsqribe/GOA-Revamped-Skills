mob
	proc
		Kyuubi_Regen()
			if(src.chambered || src.IsProtected() || !src.kyuubi) return
			src.kyuubi=1
			spawn()
				while(src.curwound > 0)
					src.curwound-=2
					sleep(10)
