mob/proc/Poison_Regen()

	var/skip_regeneration = 0 //chance they don't regen this tick

	if(Poison)
		var
			poison_effectiveness = clan == "Battle Conditioned" ? 0 : 10

		curchakra  = max(0, curchakra - 1 * poison_effectiveness * wregenlag)
		curstamina = max(0, curstamina - 1 * poison_effectiveness * wregenlag)

		Recovery++
		if(Recovery >= 2)
			Recovery = 0
			Poison = max(0, Poison - 1 * wregenlag)

		if(clan != "Battle Conditioned")
			skip_regeneration = prob(25) ? 1 : 0

		if(!status_effect_poison)
			status_effect_poison = image('icons/base_m_poison.dmi',layer=FLOAT_LAYER)
			spawn() Load_Overlays()

	else
		//remove poison overlay
		if(status_effect_poison)
			status_effect_poison = null

	return skip_regeneration