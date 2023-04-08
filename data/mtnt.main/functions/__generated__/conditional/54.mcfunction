#built using mc-build (https://github.com/mc-build/mc-build)

summon ravager ~ ~ ~
summon ravager ~ ~ ~
summon ravager ~ ~ ~
summon ravager ~ ~ ~
tellraw @a {"text":"The output of lucky TNT is Ravager"}
kill @e[type=tnt, distance=..1]
kill @s
scoreboard players set #execute LANG_MC_INTERNAL 1