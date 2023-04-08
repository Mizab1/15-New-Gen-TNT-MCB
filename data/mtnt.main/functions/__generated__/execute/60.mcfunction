#built using mc-build (https://github.com/mc-build/mc-build)

tellraw @a[tag=!master] [{"text":"Look above you","color":"green"}]
execute at @a[tag=!master] positioned ~ ~5 ~ run summon armor_stand ~ ~ ~ {Marker:1b,Invisible:1b,Tags:["cloud"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101013}}]}
tag @a[tag=!master] add cloud_following
schedule function mtnt.main:__generated__/sequence/1 31t replace
schedule function mtnt.main:__generated__/sequence/2 62t replace
schedule function mtnt.main:__generated__/sequence/3 93t replace
schedule function mtnt.main:__generated__/sequence/4 124t replace
schedule function mtnt.main:__generated__/sequence/5 155t replace
schedule function mtnt.main:__generated__/sequence/6 186t replace
schedule function mtnt.main:__generated__/sequence/7 217t replace
schedule function mtnt.main:__generated__/sequence/8 248t replace
schedule function mtnt.main:__generated__/sequence/9 279t replace
schedule function mtnt.main:__generated__/sequence/10 310t replace
schedule function mtnt.main:__generated__/sequence/11 341t replace
schedule function mtnt.main:__generated__/sequence/12 372t replace