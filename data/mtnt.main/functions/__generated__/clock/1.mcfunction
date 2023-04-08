#built using mc-build (https://github.com/mc-build/mc-build)

schedule function mtnt.main:__generated__/clock/1 10t
execute as @e[type=armor_stand, tag=cannon] at @s run tp @s ~ ~ ~ facing entity @a[distance=..30, limit=1, sort=nearest]
execute as @e[type=zombie, tag=dancing] at @s if score dance_move private matches 1 run data merge entity @s {Motion:[0.0,0.3,0.0]}