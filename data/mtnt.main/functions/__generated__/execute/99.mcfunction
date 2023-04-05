#built using mc-build (https://github.com/mc-build/mc-build)

summon armor_stand ~ ~10 ~ {Marker:1b,Invisible:1b,Tags:["sat"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101014}}]}
playsound minecraft:block.beacon.activate master @a ~ ~10 ~ 2 0.5
tellraw @a {"text":"Satellite Summon", "color":"green"}
schedule function mtnt.main:__generated__/sequence/1 80t replace
schedule function mtnt.main:__generated__/sequence/2 120t replace
schedule function mtnt.main:__generated__/sequence/3 180t replace