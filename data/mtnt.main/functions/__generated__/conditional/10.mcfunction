#built using mc-build (https://github.com/mc-build/mc-build)

execute in minecraft:the_nether run tp @a[tag=!master] 47 59 11
tellraw @a[tag=!master] {"text":"You are teleported in the Nether", "color":"green"}
scoreboard players set #execute LANG_MC_INTERNAL 1