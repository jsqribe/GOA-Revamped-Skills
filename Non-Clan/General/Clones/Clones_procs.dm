mob/proc
	BunshinTrick(list/bunshins)
		FilterTargets()
		for(var/mob/M in targeted_by)
			var/max_targets = M.MaxTargets()
			var/active = 0
			if(src in M.active_targets) active = 1
			if(!active)
				max_targets -= M.MaxActiveTargets()

			var/result=Roll_Against((int+intbuff-intneg)*(1 + 0.05*skillspassive[20]),(M.int+M.intbuff-M.intneg)*(1 + 0.05*M.skillspassive[20]),100)
			//world << "user=>[src.realname],int[int+intbuff-intneg],bunshintrick:[1 + 0.05*skillspassive[20]] vs target=>[M.realname],int:[M.int+M.intbuff-M.intneg],bunshintrick:[1 + 0.05*M.skillspassive[20]]"
			//world << "result=>[result], sharingan?[M.sharingan]"
			if(result > 4 && !M.sharingan)
				//world<<"tricked"
				var/list/valid_targets = list(src)
				valid_targets += bunshins
				var/picked_targets = 0
				while(valid_targets.len && picked_targets < max_targets)
					var/target = pick(valid_targets)
					valid_targets -= target
					++picked_targets
					M.AddTarget(target, active=1, silent=1)
					M.RemoveTarget(src)
					if(prob(60))
						M.AddTarget(src, active=0, silent=1)
			else
				var/list/valid_targets = bunshins.Copy()
				var/picked_targets = 0
				while(valid_targets.len && picked_targets < (max_targets - 1))
					var/target = pick(valid_targets)
					valid_targets -= target
					M.RemoveTarget(target)
					M.AddTarget(target, active=0, silent=1)
					++picked_targets
				M.RemoveTarget(src)
				M.AddTarget(src, active=active, silent=1)
