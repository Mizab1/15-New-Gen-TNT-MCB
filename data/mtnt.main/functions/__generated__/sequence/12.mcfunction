#built using mc-build (https://github.com/mc-build/mc-build)

execute at @e[type=armor_stand, tag=cloud] run function mtnt.main:__generated__/execute/73
tag @a[tag=cloud_following] remove cloud_following
kill @e[type=armor_stand, tag=cloud]