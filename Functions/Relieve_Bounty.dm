mob/proc
	relieve_bounty()
		var/mob/jerk=0
		for(var/mob/ho in world)
			if(ho.client)
				if(ho.key==src.lasthostile)
					jerk=ho

		if(jerk && jerk!=src)
			if(!jerk.faction || !src.faction || (jerk.faction.village!=src.faction.village)||jerk.faction.village=="Missing")
				world<<"<span class='death_info'><span class='name'>[src.realname]</span> has been killed by <span class='name'>[jerk.realname]</span>!</span>"
				jerk.bounty+=round(10+src.blevel*3)/3
				jerk.repgain(0.5,"Killing a player.")
				//var_dump(jerk)
				jerk.killedd++
				src.diedd++
				/*
				if(src==jerk.MissionTarget && jerk.MissionType=="Assasinate Player PvP")
					spawn()jerk.MissionComplete()
				if(jerk.clan=="Akimichi"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
					if(!jerk.HasSkill(PEPER_PILL))
						jerk.AddSkill(PEPER_PILL)
						jerk.RefreshSkillList()
				if(jerk.clan=="Puppeteer"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
					if(!jerk.HasSkill(HUMAN_PUPPET))
						jerk.AddSkill(HUMAN_PUPPET)
						jerk.RefreshSkillList()
				if(jerk.clan=="Sand Control"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
					if(!jerk.HasSkill(SAND_ATTACK))
						jerk.AddSkill(SAND_ATTACK)
						jerk.RefreshSkillList()
				if(jerk.clan=="Deidara"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
					if(!jerk.HasSkill(C4))
						jerk.AddSkill(C4)
						jerk.RefreshSkillList()
				if(jerk.clan=="Hyuuga"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
					if(!jerk.HasSkill(TWIN_LION))
						jerk.AddSkill(TWIN_LION)
						jerk.RefreshSkillList()
				if(jerk.clan=="Paper"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
					if(!jerk.HasSkill(PAPER_MODE))
						jerk.AddSkill(PAPER_MODE)
						jerk.RefreshSkillList()
				if(jerk.clan=="Haku"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
					if(!jerk.HasSkill(SUITON_BAKUSHOUHA))
						jerk.AddSkill(SUITON_BAKUSHOUHA)
						jerk.RefreshSkillList()
				if(jerk.clan=="Kaguya"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
					if(!jerk.HasSkill(BONE_FLOWER))
						jerk.AddSkill(BONE_FLOWER)
						jerk.RefreshSkillList()
				if(jerk.clan=="Jashin"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 3)
					if(!jerk.HasSkill(IMMORTALITY))
						jerk.AddSkill(IMMORTALITY)
						jerk.RefreshSkillList()
				*/
				spawn()
					if(jerk.faction && jerk.faction.village=="Missing")
						jerk<<"You gained [src.bounty] dollars for [src.realname]'s bounty!"
						jerk.money+=src.bounty
						src.bounty=0
			else
				world<<"<span class='death_info'><span class='betrayal'><span class='name'><b><u>[jerk.realname]</span> has killed <span class='name'>[src.realname]</span> and they are in the same village!</span></span>"
				jerk.reploss(0.5,"Betrayed the village")
				jerk.killedd++
				src.diedd++
				/*
				if(jerk.clan=="Uchiha"&&jerk.killedd>=RandomKills && jerk.rankgrade >= 2)
				//	world.log <<" Random = [RandomKills]"
					if(rand(0,100) < 11 && !jerk.HasSkill(ITACHI_MANGEKYOU) && !jerk.HasSkill(SASUKE_MANGEKYOU) && !jerk.HasSkill(MADARA_MANGEKYOU) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_SASUKE) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_MADARA) && !jerk.HasSkill(ITACHI_MANGEKYOU_V2))
						jerk.AddSkill(MADARA_MANGEKYOU)
						jerk.RefreshSkillList()
					else if(rand(0,100) < 31  && !jerk.HasSkill(SASUKE_MANGEKYOU) && !jerk.HasSkill(ITACHI_MANGEKYOU) && !jerk.HasSkill(MADARA_MANGEKYOU) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_SASUKE) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_MADARA) && !jerk.HasSkill(ITACHI_MANGEKYOU_V2))
						jerk.AddSkill(SASUKE_MANGEKYOU)
						jerk.RefreshSkillList()
					else if(rand(0,100) <= 100 && !jerk.HasSkill(ITACHI_MANGEKYOU) && !jerk.HasSkill(SASUKE_MANGEKYOU) && !jerk.HasSkill(MADARA_MANGEKYOU) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_SASUKE) && !jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_MADARA) && !jerk.HasSkill(ITACHI_MANGEKYOU_V2))
						jerk.AddSkill(ITACHI_MANGEKYOU)
						jerk.RefreshSkillList()
				if(jerk.clan=="Uchiha"&&jerk.killedd>=RandomKills2 && jerk.rankgrade >= 4 && jerk.givensharingans >= 1)
				//	world.log <<" Random = [RandomKills2]"
					if(jerk.HasSkill(SASUKE_MANGEKYOU)&&!jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_SASUKE))
						jerk.RemoveSkill(SASUKE_MANGEKYOU)
						jerk.AddSkill(ETERNAL_MANGEKYOU_SHARINGAN_SASUKE)
						jerk.RefreshSkillList()
					else if(jerk.HasSkill(MADARA_MANGEKYOU)&&!jerk.HasSkill(ETERNAL_MANGEKYOU_SHARINGAN_MADARA))
						jerk.RemoveSkill(MADARA_MANGEKYOU)
						jerk.AddSkill(ETERNAL_MANGEKYOU_SHARINGAN_MADARA)
						jerk.RefreshSkillList()
					else if(jerk.HasSkill(ITACHI_MANGEKYOU)&&!jerk.HasSkill(ITACHI_MANGEKYOU_V2))
						jerk.RemoveSkill(ITACHI_MANGEKYOU)
						jerk.AddSkill(ITACHI_MANGEKYOU_V2)
						jerk.RefreshSkillList()
				if(jerk.danzo && jerk.eye_collection<5 && src.clan == "Uchiha")
					jerk.eye_collection++
					jerk << "You now have [jerk.eye_collection] eyes"
				*/
		else
			world<<"<span class='death_info'><span class='name'>[src]</span> has died!</span>"

	Killed(mob/owned)
		// What calls this? It used to do some K/D tracking but I don't think it's used anymore.