#built using mc-build (https://github.com/mc-build/mc-build)

execute store result score @s pos_x1 run data get entity @s Pos[0] 1000
execute store result score @s pos_y1 run data get entity @s Pos[1] 1000
execute store result score @s pos_z1 run data get entity @s Pos[2] 1000
tp @s ^ ^ ^0.1
execute store result score @s pos_x2 run data get entity @s Pos[0] 1000
execute store result score @s pos_y2 run data get entity @s Pos[1] 1000
execute store result score @s pos_z2 run data get entity @s Pos[2] 1000
scoreboard players operation @s pos_x2 -= @s pos_x1
scoreboard players operation @s pos_y2 -= @s pos_y1
scoreboard players operation @s pos_z2 -= @s pos_z1
execute store result entity @s Motion[0] double 0.01 run scoreboard players get @s pos_x2
execute store result entity @s Motion[1] double 0.01 run scoreboard players get @s pos_y2
execute store result entity @s Motion[2] double 0.01 run scoreboard players get @s pos_z2
tag @s add tag_added