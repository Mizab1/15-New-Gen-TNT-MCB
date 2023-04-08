#built using mc-build (https://github.com/mc-build/mc-build)

summon zombie ~ ~ ~ {IsBaby:1b}
summon zombie ~ ~ ~ {IsBaby:1b}
summon zombie ~ ~ ~ {IsBaby:1b}
summon zombie ~ ~ ~ {IsBaby:1b}
summon zombie ~ ~ ~ {IsBaby:1b}
summon zombie ~ ~ ~ {IsBaby:1b}
summon zombie ~ ~ ~ {IsBaby:1b}
summon zombie ~ ~ ~ {IsBaby:1b}
tellraw @a {"text":"The output of lucky TNT is Baby Zombies"}
kill @e[type=tnt, distance=..1]
kill @s
scoreboard players set #execute LANG_MC_INTERNAL 1