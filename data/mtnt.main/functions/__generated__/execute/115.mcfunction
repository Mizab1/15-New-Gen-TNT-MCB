#built using mc-build (https://github.com/mc-build/mc-build)

summon armor_stand ~ ~10 ~ {Marker:1b,Invisible:1b,Tags:["sat"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101014}}]}
playsound minecraft:block.beacon.activate master @a ~ ~10 ~ 2 0.5
tellraw @a {"text":"Satellite Summon", "color":"green"}
schedule function mtnt.main:__generated__/sequence/317 80t replace
schedule function mtnt.main:__generated__/sequence/318 120t replace
schedule function mtnt.main:__generated__/sequence/319 180t replace
schedule function mtnt.main:__generated__/sequence/320 260t replace
schedule function mtnt.main:__generated__/sequence/321 300t replace
schedule function mtnt.main:__generated__/sequence/322 360t replace
schedule function mtnt.main:__generated__/sequence/323 440t replace
schedule function mtnt.main:__generated__/sequence/324 480t replace
schedule function mtnt.main:__generated__/sequence/325 540t replace
schedule function mtnt.main:__generated__/sequence/326 620t replace
schedule function mtnt.main:__generated__/sequence/327 660t replace
schedule function mtnt.main:__generated__/sequence/328 720t replace
schedule function mtnt.main:__generated__/sequence/329 800t replace
schedule function mtnt.main:__generated__/sequence/330 840t replace
schedule function mtnt.main:__generated__/sequence/331 900t replace