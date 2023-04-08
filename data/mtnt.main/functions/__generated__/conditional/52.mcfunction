#built using mc-build (https://github.com/mc-build/mc-build)

summon illusioner ~ ~ ~
summon illusioner ~ ~ ~
summon illusioner ~ ~ ~
summon illusioner ~ ~ ~
tellraw @a {"text":"The output of lucky TNT is Illusioner"}
kill @e[type=tnt, distance=..1]
kill @s
scoreboard players set #execute LANG_MC_INTERNAL 1