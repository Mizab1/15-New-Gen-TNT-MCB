#built using mc-build (https://github.com/mc-build/mc-build)

scoreboard players set #execute LANG_MC_INTERNAL 0
execute if entity @e[type=tnt,distance=..0.5] run function mtnt.main:__generated__/conditional/26
scoreboard players set #execute LANG_MC_INTERNAL 0
execute unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5] run function mtnt.main:__generated__/conditional/27