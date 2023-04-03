#built using mc-build (https://github.com/mc-build/mc-build)

execute as @a[tag=!master] at @s run function mtnt.main:shader_on_creeper
schedule function mtnt.main:__generated__/schedule/5 15s replace
tellraw @a [{"text":"The screen is now inverted","color":"green"}]