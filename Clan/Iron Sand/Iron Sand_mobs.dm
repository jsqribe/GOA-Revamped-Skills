var/sand/iron_mass/iron_mass
var/sand/gaara_mass/gaara_mass

proc
    Sand_Mass(mob/user)
        if(user && user.HasSkill("sand_mass"))
            var/skill/skill = user.GetSkill("sand_mass")
            return skill:sand_mass