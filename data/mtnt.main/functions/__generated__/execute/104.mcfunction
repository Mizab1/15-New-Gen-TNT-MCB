#built using mc-build (https://github.com/mc-build/mc-build)

summon armor_stand ~ ~10 ~ {Marker:1b,Invisible:1b,Tags:["sat"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101014}}]}
playsound minecraft:block.beacon.activate master @a ~ ~10 ~ 2 0.5
tellraw @a {"text":"Satellite Summon", "color":"green"}
schedule function mtnt.main:__generated__/sequence/301 80t replace
schedule function mtnt.main:__generated__/sequence/302 120t replace
schedule function mtnt.main:__generated__/sequence/303 180t replace
schedule function mtnt.main:__generated__/sequence/304 260t replace
schedule function mtnt.main:__generated__/sequence/305 300t replace
schedule function mtnt.main:__generated__/sequence/306 360t replace
schedule function mtnt.main:__generated__/sequence/307 440t replace
schedule function mtnt.main:__generated__/sequence/308 480t replace
schedule function mtnt.main:__generated__/sequence/309 540t replace
schedule function mtnt.main:__generated__/sequence/310 620t replace
schedule function mtnt.main:__generated__/sequence/311 660t replace
schedule function mtnt.main:__generated__/sequence/312 720t replace
schedule function mtnt.main:__generated__/sequence/313 800t replace
schedule function mtnt.main:__generated__/sequence/314 840t replace
schedule function mtnt.main:__generated__/sequence/315 900t replace