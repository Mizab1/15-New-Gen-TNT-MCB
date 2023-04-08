#built using mc-build (https://github.com/mc-build/mc-build)

execute as @e[type=armor_stand, tag=sat] at @s run function mtnt.main:__generated__/execute/125
tellraw @a {"text":"[Satellite] Target Acquired", "color":"green"}