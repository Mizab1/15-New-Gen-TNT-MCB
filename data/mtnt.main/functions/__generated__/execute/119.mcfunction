#built using mc-build (https://github.com/mc-build/mc-build)

summon armor_stand ~ ~10 ~ {Marker:1b,Invisible:1b,Tags:["sat"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101014}}]}
playsound minecraft:block.beacon.activate master @a ~ ~10 ~ 2 0.5
tellraw @a {"text":"Satellite Summon", "color":"green"}
schedule function mtnt.main:__generated__/sequence/317 10t replace
schedule function mtnt.main:__generated__/sequence/318 30t replace
schedule function mtnt.main:__generated__/sequence/319 40t replace
schedule function mtnt.main:__generated__/sequence/320 50t replace
schedule function mtnt.main:__generated__/sequence/321 70t replace
schedule function mtnt.main:__generated__/sequence/322 80t replace
schedule function mtnt.main:__generated__/sequence/323 90t replace
schedule function mtnt.main:__generated__/sequence/324 110t replace
schedule function mtnt.main:__generated__/sequence/325 120t replace
schedule function mtnt.main:__generated__/sequence/326 130t replace
schedule function mtnt.main:__generated__/sequence/327 150t replace
schedule function mtnt.main:__generated__/sequence/328 160t replace
schedule function mtnt.main:__generated__/sequence/329 170t replace
schedule function mtnt.main:__generated__/sequence/330 190t replace
schedule function mtnt.main:__generated__/sequence/331 200t replace