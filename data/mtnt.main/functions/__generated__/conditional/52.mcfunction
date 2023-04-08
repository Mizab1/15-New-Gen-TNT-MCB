#built using mc-build (https://github.com/mc-build/mc-build)

summon cave_spider ~ ~ ~
summon cave_spider ~ ~ ~
summon cave_spider ~ ~ ~
summon cave_spider ~ ~ ~
summon cave_spider ~ ~ ~
summon cave_spider ~ ~ ~
summon cave_spider ~ ~ ~
summon cave_spider ~ ~ ~
tellraw @a {"text":"The output of lucky TNT is Cave Spider"}
kill @e[type=tnt, distance=..1]
kill @s
scoreboard players set #execute LANG_MC_INTERNAL 1