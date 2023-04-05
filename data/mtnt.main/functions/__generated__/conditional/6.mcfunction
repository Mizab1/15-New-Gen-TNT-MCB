#built using mc-build (https://github.com/mc-build/mc-build)

execute in minecraft:the_end run tp @a[tag=!master] 20 100 30
tellraw @a[tag=!master] {"text":"You are teleported in the End", "color":"green"}
scoreboard players set #execute LANG_MC_INTERNAL 1