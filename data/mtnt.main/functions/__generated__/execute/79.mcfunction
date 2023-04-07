#built using mc-build (https://github.com/mc-build/mc-build)

effect give @e[type=#minecraft:all_living, tag=!master, tag=!is_igniter, distance=..40] slowness 15 30 true
effect give @e[type=#minecraft:ded_mobs, tag=!master, tag=!is_igniter, distance=..40] slowness 15 30 true
execute as @a[tag=!master, tag=!is_igniter] at @s run particle minecraft:elder_guardian ~ ~ ~ 0 0 0 1 1
tellraw @a [{"text":"The time is now stopped","color":"gold"}]