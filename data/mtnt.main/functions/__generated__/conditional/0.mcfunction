#built using mc-build (https://github.com/mc-build/mc-build)

execute as @e[type=#minecraft:all_living, tag=!master] run effect give @s instant_damage 1 0 true
execute as @e[type=#minecraft:ded_mobs] run effect give @s instant_health 1 0 true
scoreboard players set #execute LANG_MC_INTERNAL 1