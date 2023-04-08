#built using mc-build (https://github.com/mc-build/mc-build)

summon item ~ ~1 ~ {Motion:[0.1,0.3,-0.2],Item:{id:"minecraft:netherite_leggings",Count:1b,tag:{display:{Name:'{"text":"OP Armor","color":"gold","italic":false}'},Enchantments:[{id:"minecraft:protection",lvl:5s},{id:"minecraft:fire_protection",lvl:5s},{id:"minecraft:blast_protection",lvl:5s},{id:"minecraft:projectile_protection",lvl:5s},{id:"minecraft:respiration",lvl:5s},{id:"minecraft:aqua_affinity",lvl:5s},{id:"minecraft:thorns",lvl:5s},{id:"minecraft:unbreaking",lvl:5s}]}}}
tellraw @a {"text":"The output of lucky TNT is OP Leggings"}
kill @e[type=tnt, distance=..1]
kill @s
scoreboard players set #execute LANG_MC_INTERNAL 1