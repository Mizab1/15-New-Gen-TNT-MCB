#built using mc-build (https://github.com/mc-build/mc-build)

spawnpoint @s ~ ~ ~ ~
gamemode spectator @s
summon creeper ~ ~ ~ {NoAI:1b, Tags:["toggle_shader"]}
spectate @e[tag=toggle_shader, limit=1]
tag @s add on_shader
gamerule doImmediateRespawn true
schedule function mtnt.main:__generated__/sequence/27 10t replace
schedule function mtnt.main:__generated__/sequence/28 20t replace