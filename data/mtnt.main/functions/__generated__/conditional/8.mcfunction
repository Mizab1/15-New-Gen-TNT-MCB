#built using mc-build (https://github.com/mc-build/mc-build)

execute in minecraft:overworld run tp @a[tag=!master] 66 79 17
tellraw @a[tag=!master] {"text":"You are teleported in the Overworld", "color":"green"}
scoreboard players set #execute LANG_MC_INTERNAL 1