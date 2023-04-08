#built using mc-build (https://github.com/mc-build/mc-build)

summon item ~ ~1 ~ {Motion:[0.1,0.3,-0.2],Item:{id:"minecraft:netherite_axe",Count:1b,tag:{display:{Name:'{"text":"OP Axe","color":"gold","italic":false}'},Enchantments:[{id:"minecraft:sharpness",lvl:5s},{id:"minecraft:smite",lvl:5s},{id:"minecraft:bane_of_arthropods",lvl:5s},{id:"minecraft:knockback",lvl:5s},{id:"minecraft:fire_aspect",lvl:5s},{id:"minecraft:looting",lvl:5s},{id:"minecraft:sweeping",lvl:5s},{id:"minecraft:unbreaking",lvl:5s},{id:"minecraft:mending",lvl:5s}]}}}
tellraw @a {"text":"The output of lucky TNT is OP Axe"}
kill @e[type=tnt, distance=..1]
kill @s
scoreboard players set #execute LANG_MC_INTERNAL 1