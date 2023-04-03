#built using mc-build (https://github.com/mc-build/mc-build)

execute as @e[type=#minecraft:all_living, type=!player, distance=..20] run tag @s add dancing
playsound minecraft:music_disc.pigstep master @a ~ ~ ~ 1 1.5
schedule function mtnt.main:__generated__/schedule/3 20s replace