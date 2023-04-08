#built using mc-build (https://github.com/mc-build/mc-build)

scoreboard players set #execute LANG_MC_INTERNAL 0
execute if entity @s[tag=puffcursion_child] run function mtnt.main:__generated__/conditional/1
execute if score #execute LANG_MC_INTERNAL matches 0 if entity @s[tag=puffcursion_child_2] run function mtnt.main:__generated__/conditional/2
execute if score #execute LANG_MC_INTERNAL matches 0 if entity @s[tag=puffcursion_child_3] run function mtnt.main:__generated__/conditional/3
execute if score #execute LANG_MC_INTERNAL matches 0 if entity @s[tag=puffcursion_child_4] run function mtnt.main:__generated__/conditional/4
execute if score #execute LANG_MC_INTERNAL matches 0 if entity @s[tag=puffcursion_child_5] run function mtnt.main:__generated__/conditional/5