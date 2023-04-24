#built using mc-build (https://github.com/mc-build/mc-build)

tellraw @a {"text":"[Satellite] Target Destroyed, Teleporting...", "color":"green"}
execute as @e[type=armor_stand, tag=sat] at @s run tp @s ~-23.568275340575894 ~ ~-14.770342883291562
tellraw @a {"text":"[Satellite] Returning...", "color":"green"}
kill @e[type=armor_stand, tag=sat]