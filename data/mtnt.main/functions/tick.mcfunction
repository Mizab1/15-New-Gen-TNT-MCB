#built using mc-build (https://github.com/mc-build/mc-build)

effect give @a[tag=!in_darkness] night_vision 100 0 true
execute as @a[tag=in_sandstorm] at @s run function mtnt.main:__generated__/execute/18
execute as @a[tag=cloud_following] at @s run tp @e[type=armor_stand, tag=cloud, limit=1, sort=nearest] ~ ~8 ~
execute as @e[tag=dancing] at @s run function mtnt.main:__generated__/execute/20
execute as @e[type=tnt] at @s if entity @e[type=armor_stand, tag=tnt.time, distance=..1] on origin run tag @s add is_igniter
execute as @e[type=endermite, tag=tnt.endermite] at @s run function mtnt.main:__generated__/execute/22
execute as @e[type=armor_stand, tag=tnt.as] at @s run function mtnt.main:__generated__/execute/38