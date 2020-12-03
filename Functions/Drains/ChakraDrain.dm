mob
	proc
		ChakraDrains()
			if(src.sharingan == 1)
				src.chakradrain=3
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && sharingan == 1)
						src.curchakra-=chakradrain
						sleep(50)
					src.sharingan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.sharingan == 2)
				src.chakradrain=6
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && src.sharingan == 2)
						src.curchakra-=chakradrain
						sleep(50)
					src.sharingan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.sharingan == 3)
				src.chakradrain=12
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && src.sharingan == 3)
						src.curchakra-=chakradrain
						sleep(50)
					src.sharingan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.sharingan == 4)
				src.chakradrain=16
				spawn()
					while(((src.curchakra > 0 && src.curchakra >= src.chakradrain) || (src.curstamina > 0 && src.curstamina >= src.stamdrain))  && src.sharingan == 4)
						src.curchakra-=chakradrain
						sleep(50)
					src.sharingan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.sharingan >= 5)
				src.chakradrain=20
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && src.sharingan >= 5)
						src.curchakra-=chakradrain
						sleep(50)
					src.sharingan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.impsharingan == 1 || src.impbyakugan == 1)
				src.chakradrain=18
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && (src.impsharingan == 1 || src.impbyakugan == 1))
						src.curchakra-=chakradrain
						sleep(50)
					src.impsharingan = 0
					src.impbyakugan = 0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

			if(src.shukaku == 1 || src.nibi == 1 || src.sanbi == 1 || src.yonbi == 1 || src.gobi == 1 || src.rokubi == 1 || src.shichibi == 1 || src.hachibi == 1 || src.kyuubi == 1)
				src.chakradrain=50
				spawn()
					while(src.curchakra > 0 && src.curchakra >= src.chakradrain && (src.shukaku == 1 || src.nibi == 1 || src.sanbi == 1 || src.yonbi == 1 || src.gobi == 1 || src.rokubi == 1 || src.shichibi == 1 || src.hachibi == 1 || src.kyuubi == 1))
						src.curchakra-=chakradrain
						sleep(50)
					src.shukaku=0
					src.nibi=0
					src.sanbi=0
					src.yonbi=0
					src.gobi=0
					src.rokubi=0
					src.shichibi=0
					src.hachibi=0
					src.kyuubi=0
					src.rfxbuff=0
					src.intbuff=0
					src.conbuff=0
					src.strbuff=0

