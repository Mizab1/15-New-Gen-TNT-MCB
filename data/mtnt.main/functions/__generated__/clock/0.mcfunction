#built using mc-build (https://github.com/mc-build/mc-build)

schedule function mtnt.main:__generated__/clock/0 30t
scoreboard players set #execute LANG_MC_INTERNAL 0
execute if score acid_rain private matches 1 run function mtnt.main:__generated__/conditional/0
execute as @e[type=armor_stand, tag=cannon] at @s anchored eyes positioned ^ ^ ^1 if entity @a[distance=..20] run summon tnt ~ ~ ~ {Tags:["cannon_ball"], Fuse:40}
execute as @e[type=tnt, tag=cannon_ball] at @s rotated as @e[type=armor_stand, tag=cannon, limit=1, sort=nearest] run function mtnt.main:__generated__/execute/4
execute as @e[type=pufferfish, tag=puffcursion] at @s run function mtnt.main:__generated__/execute/14