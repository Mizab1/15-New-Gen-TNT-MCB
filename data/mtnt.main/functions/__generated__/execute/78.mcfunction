#built using mc-build (https://github.com/mc-build/mc-build)

scoreboard players set dance_move private 0
summon zombie ~ ~ ~ {DeathLootTable:"minecraft:bat", Silent:1b,Tags:["npcs", "dancing"],CustomName:'{"text":"NPC 1"}',ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",Count:1b,tag:{display:{color:4014663}}}]}
summon zombie ~ ~ ~ {DeathLootTable:"minecraft:bat", Silent:1b,Tags:["npcs", "dancing"],CustomName:'{"text":"NPC 2"}',ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",Count:1b,tag:{display:{color:4014663}}}]}
summon zombie ~ ~ ~ {DeathLootTable:"minecraft:bat", Silent:1b,Tags:["npcs", "dancing"],CustomName:'{"text":"NPC 3"}',ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",Count:1b,tag:{display:{color:4014663}}}]}
playsound minecraft:music_disc.pigstep master @a ~ ~ ~ 1 1.5
spreadplayers ~ ~ 3 3 false @e[type=minecraft:zombie, tag=npcs]
schedule function mtnt.main:__generated__/sequence/14 300t replace
schedule function mtnt.main:__generated__/sequence/15 460t replace