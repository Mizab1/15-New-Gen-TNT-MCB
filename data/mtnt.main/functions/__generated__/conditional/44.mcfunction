#built using mc-build (https://github.com/mc-build/mc-build)

fill ~5 ~-1 ~5 ~-5 ~-1 ~-5 minecraft:emerald_block
tellraw @a {"text":"The output of lucky TNT is Emerald Blocks"}
kill @e[type=tnt, distance=..1]
kill @s
scoreboard players set #execute LANG_MC_INTERNAL 1