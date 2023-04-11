#built using mc-build (https://github.com/mc-build/mc-build)

tellraw @a {"text":"[Satellite] Target Destroyed, Teleporting...", "color":"green"}
execute as @e[type=armor_stand, tag=sat] at @s run tp @s ~-14.692223658862833 ~ ~8.733428152495954
tellraw @a {"text":"[Satellite] Returning...", "color":"green"}
kill @e[type=armor_stand, tag=sat]