#built using mc-build (https://github.com/mc-build/mc-build)

effect give @a[tag=!in_darkness] night_vision 100 0 true
execute as @a[tag=in_sandstorm] at @s run function mtnt.main:__generated__/execute/19
execute as @a[tag=cloud_following] at @s run tp @e[type=armor_stand, tag=cloud, limit=1, sort=nearest] ~ ~8 ~
execute as @e[type=zombie, tag=dancing] at @s run function mtnt.main:__generated__/execute/21
execute as @e[type=tnt] at @s if entity @e[type=armor_stand, tag=tnt.time, distance=..1] on origin run tag @s add is_igniter
execute as @e[type=endermite, tag=tnt.endermite] at @s run function mtnt.main:__generated__/execute/23
execute as @e[type=armor_stand, tag=tnt.as] at @s run function mtnt.main:__generated__/execute/43
execute as @e[type=cow, tag=betty] at @s run execute if entity @s[nbt={HurtTime:1s}] run summon item ~ ~ ~ {PickupDelay:40,Item:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{display:{Name:'{"text":"Magic Milk","color":"gold","italic":false}'},CustomModelData:101107}}}
execute as @a[scores={rc_clicked=1..}, predicate=mtnt.main:drank_milk] at @s anchored eyes positioned ^ ^ ^1 run function mtnt.main:__generated__/execute/180
execute as @a[scores={rc_clicked=1..}, predicate=mtnt.main:shoot_tnt] at @s anchored eyes positioned ^ ^ ^1 run function mtnt.main:__generated__/execute/181
execute as @e[type=tnt, tag=warden_tnt, tag=!tag_added] at @s rotated as @a[tag=warden_morphed_player, limit=1, sort=nearest] run function mtnt.main:__generated__/execute/182