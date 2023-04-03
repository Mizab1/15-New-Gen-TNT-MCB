#built using mc-build (https://github.com/mc-build/mc-build)

spawnpoint @s ~ ~ ~ ~
gamemode spectator @s
summon sheep ~ ~ ~ {NoAI:1b, Tags:["toggle_shader_undo"]}
spectate @e[tag=toggle_shader_undo, limit=1]
tag @s add on_shader_undo
gamerule doImmediateRespawn true
schedule function mtnt.main:__generated__/sequence/4 10t replace
schedule function mtnt.main:__generated__/sequence/5 20t replace