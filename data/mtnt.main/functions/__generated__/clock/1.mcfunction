#built using mc-build (https://github.com/mc-build/mc-build)

schedule function mtnt.main:__generated__/clock/1 10t
execute as @e[type=armor_stand, tag=sat_firing] at @s run particle dust 1.000 0.918 0.180 2 ~ ~-4.5 ~ 0 3 0 1 100 normal
execute as @e[type=armor_stand, tag=cannon] at @s run tp @s ~ ~ ~ facing entity @a[distance=..30, limit=1, sort=nearest]