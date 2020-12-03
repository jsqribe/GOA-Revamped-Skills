mob/var
	iaido_active = FALSE
mob/var
	sabre = 0
	break_armour = 0

skill
	samurai
		copyable = 0

		Iaido
			id = IAIDO
			name = "Iaidõ"
			icon_state = "iaido"
			default_chakra_cost = 50
			default_cooldown = 60*4
//this move is prevented to be op
			Use(mob/user)
				if(user) user.iaido_active = TRUE
				viewers(user) << output("[user]: Laidõ!", "combat_output")
				spawn(5*60*2)//lasts half the time of cooldown
					user.iaido_active = FALSE
					user.combat("You lost your immense speed")



//like rakiri just not allowed to move while no target on screen otherwise could be op.Made it quicker than raikiri
		Iai_Beheading
			id = IAI
			name = "Iai Beheading"
			icon_state = "iai"
			default_chakra_cost = 400
			default_cooldown = 60
			default_seal_time = 2

			Use(mob/human/user)
				viewers(user) << output("[user]: Iai Beheading!", "combat_output")
				var/mob/human/X = user.MainTarget()

				user.stunned=50
				spawn(30) user.stunned=0
				spawn()
					if(!X)
						user.combat("There was no target")
						return
					else if(X)
						user.usemove=1
						sleep(15)//1.5 seconds before he attacks
						var/inrange=(X in oview(user, 10))

						if(X && user.usemove==1 && inrange)
							var/result=Roll_Against(user.rfx+user.rfxbuff-user.rfxneg,X.rfx+X.rfxbuff-X.rfxneg,70)
							if(result>=5)
								user.combat("[user] beheaded [X]!")
								X.combat("[user] beheaded [X]!")
								X.stunned = rand(2,3)
							//	X.Wound(rand(15, 75), 1, user)
								X.Damage(rand(1100, 5000)+rand(100, 150)*user.ControlDamageMultiplier(),rand(15,75), 1, user)

							else if(result==4||result==3)
								user.combat("[user] barely scratched [X]")
								X.combat("[user] barely scratched [X]")
							//	X.Wound(rand(5,10),1,user)
								X.Damage(rand(100,1000),rand(5,10),1,user)
								X.stunned = rand(2,3)

							else if(result<3)
								user.combat("[user] Missed [X]!")

							if(user.AppearMyDir(X))
								if(result>=3)
									flick("w-attack",user)
									X.move_stun=10
									spawn()Blood2(X,user)
									spawn()X.Hostile(user)

							user.usemove = 0
