#built using mc-build (https://github.com/mc-build/mc-build)

scoreboard players operation temp0 rng = state rng
scoreboard players operation temp0 rng *= a rng
scoreboard players operation temp0 rng += c rng
scoreboard players operation temp0 rng %= m rng
scoreboard players operation state rng = temp0 rng
scoreboard players operation dimension_rng rng_score = temp0 rng
scoreboard players operation dimension_rng rng_score /= #100000 rng
scoreboard players set min rng 0
scoreboard players set max rng 3
scoreboard players operation size rng = max rng
scoreboard players operation size rng -= min rng
scoreboard players operation dimension_rng rng_score %= size rng
scoreboard players operation dimension_rng rng_score += min rng
scoreboard players set #execute LANG_MC_INTERNAL 0
execute if score dimension_rng rng_score matches 0 run function mtnt.main:__generated__/conditional/5
scoreboard players set #execute LANG_MC_INTERNAL 0
execute if score dimension_rng rng_score matches 1 run function mtnt.main:__generated__/conditional/6
scoreboard players set #execute LANG_MC_INTERNAL 0
execute if score dimension_rng rng_score matches 2 run function mtnt.main:__generated__/conditional/7
kill @e[type=armor_stand,tag=tnt.dimension,distance=..4]
kill @s