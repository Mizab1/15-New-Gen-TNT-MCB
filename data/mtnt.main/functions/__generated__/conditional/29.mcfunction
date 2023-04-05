#built using mc-build (https://github.com/mc-build/mc-build)

summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.sun","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110006}}]}
tellraw @s {"text":"The output of lucky TNT is Sun TNT"}
kill @s
scoreboard players set #execute LANG_MC_INTERNAL 1