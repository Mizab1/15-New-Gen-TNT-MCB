#built using mc-build (https://github.com/mc-build/mc-build)

time set noon
tellraw @a [{"text":"The sun is now very bright","color":"red"}]
execute as @a[tag=!master] at @s run function mtnt.main:shader_on_spider
scoreboard players set acid_rain private 1
schedule function mtnt.main:__generated__/schedule/4 15s replace