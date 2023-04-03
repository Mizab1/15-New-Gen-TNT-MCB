#built using mc-build (https://github.com/mc-build/mc-build)

scoreboard players operation temp0 rng = state rng
scoreboard players operation temp0 rng *= a rng
scoreboard players operation temp0 rng += c rng
scoreboard players operation temp0 rng %= m rng
scoreboard players operation state rng = temp0 rng
scoreboard players operation random_tnt rng_score = temp0 rng
scoreboard players operation random_tnt rng_score /= #100000 rng
scoreboard players set min rng 0
scoreboard players set max rng 5
scoreboard players operation size rng = max rng
scoreboard players operation size rng -= min rng
scoreboard players operation random_tnt rng_score %= size rng
scoreboard players operation random_tnt rng_score += min rng
scoreboard players set #execute LANG_MC_INTERNAL 0
execute if score random_tnt rng_score matches 0 run function mtnt.main:__generated__/conditional/21
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 1 run function mtnt.main:__generated__/conditional/22
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 2 run function mtnt.main:__generated__/conditional/23
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 3 run function mtnt.main:__generated__/conditional/24
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 4 run function mtnt.main:__generated__/conditional/25
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 5 run function mtnt.main:__generated__/conditional/26
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 6 run function mtnt.main:__generated__/conditional/27
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 7 run function mtnt.main:__generated__/conditional/28
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 8 run function mtnt.main:__generated__/conditional/29
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 9 run function mtnt.main:__generated__/conditional/30
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 10 run function mtnt.main:__generated__/conditional/31
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 11 run function mtnt.main:__generated__/conditional/32
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 12 run function mtnt.main:__generated__/conditional/33
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 13 run function mtnt.main:__generated__/conditional/34
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 14 run function mtnt.main:__generated__/conditional/35