#built using mc-build (https://github.com/mc-build/mc-build)

summon armor_stand ~ ~10 ~ {Marker:1b,Invisible:1b,Tags:["sat"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101014}}]}
playsound minecraft:block.beacon.activate master @a ~ ~10 ~ 2 0.5
tellraw @a {"text":"Satellite Summon", "color":"green"}
schedule function mtnt.main:__generated__/sequence/317 40t replace
schedule function mtnt.main:__generated__/sequence/318 60t replace
schedule function mtnt.main:__generated__/sequence/319 80t replace
schedule function mtnt.main:__generated__/sequence/320 120t replace
schedule function mtnt.main:__generated__/sequence/321 140t replace
schedule function mtnt.main:__generated__/sequence/322 160t replace
schedule function mtnt.main:__generated__/sequence/323 200t replace
schedule function mtnt.main:__generated__/sequence/324 220t replace
schedule function mtnt.main:__generated__/sequence/325 240t replace
schedule function mtnt.main:__generated__/sequence/326 280t replace
schedule function mtnt.main:__generated__/sequence/327 300t replace
schedule function mtnt.main:__generated__/sequence/328 320t replace
schedule function mtnt.main:__generated__/sequence/329 360t replace
schedule function mtnt.main:__generated__/sequence/330 380t replace
schedule function mtnt.main:__generated__/sequence/331 400t replace