#built using mc-build (https://github.com/mc-build/mc-build)

tellraw @a[tag=!master] [{"text":"Look above you","color":"green"}]
execute at @a[tag=!master] positioned ~ ~5 ~ run summon armor_stand ~ ~ ~ {Marker:1b,Invisible:1b,Tags:["cloud"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101013}}]}
tag @a[tag=!master] add cloud_following
schedule function mtnt.main:__generated__/schedule/2 15s replace