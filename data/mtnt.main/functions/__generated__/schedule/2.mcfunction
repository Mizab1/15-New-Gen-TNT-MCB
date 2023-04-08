#built using mc-build (https://github.com/mc-build/mc-build)

execute as @a[tag=!master] at @s run function mtnt.main:shader_off_spider
scoreboard players set acid_rain private 0
time set midnight