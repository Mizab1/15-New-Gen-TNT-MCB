#built using mc-build (https://github.com/mc-build/mc-build)

scoreboard players set dance_move private 0
stopsound @a
execute as @a[tag=!master] run function mtnt.main:__generated__/execute/79
kill @e[tag=dancing]