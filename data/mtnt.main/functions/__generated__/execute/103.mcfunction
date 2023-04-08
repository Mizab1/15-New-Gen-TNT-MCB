#built using mc-build (https://github.com/mc-build/mc-build)

scoreboard players operation temp0 rng = state rng
scoreboard players operation temp0 rng *= a rng
scoreboard players operation temp0 rng += c rng
scoreboard players operation temp0 rng %= m rng
scoreboard players operation state rng = temp0 rng
scoreboard players operation random_tnt rng_score = temp0 rng
scoreboard players operation random_tnt rng_score /= #100000 rng
scoreboard players set min rng 0
scoreboard players set max rng 28
scoreboard players operation size rng = max rng
scoreboard players operation size rng -= min rng
scoreboard players operation random_tnt rng_score %= size rng
scoreboard players operation random_tnt rng_score += min rng
scoreboard players set #execute LANG_MC_INTERNAL 0
execute if score random_tnt rng_score matches 0 run function mtnt.main:__generated__/conditional/27
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 1 run function mtnt.main:__generated__/conditional/28
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 2 run function mtnt.main:__generated__/conditional/29
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 3 run function mtnt.main:__generated__/conditional/30
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 4 run function mtnt.main:__generated__/conditional/31
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 5 run function mtnt.main:__generated__/conditional/32
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 6 run function mtnt.main:__generated__/conditional/33
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 7 run function mtnt.main:__generated__/conditional/34
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 8 run function mtnt.main:__generated__/conditional/35
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 9 run function mtnt.main:__generated__/conditional/36
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 10 run function mtnt.main:__generated__/conditional/37
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 11 run function mtnt.main:__generated__/conditional/38
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 12 run function mtnt.main:__generated__/conditional/39
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 13 run function mtnt.main:__generated__/conditional/40
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 14 run function mtnt.main:__generated__/conditional/41
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 15 run function mtnt.main:__generated__/conditional/42
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 16 run function mtnt.main:__generated__/conditional/43
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 17 run function mtnt.main:__generated__/conditional/44
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 18 run function mtnt.main:__generated__/conditional/45
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 19 run function mtnt.main:__generated__/conditional/46
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 20 run function mtnt.main:__generated__/conditional/47
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 21 run function mtnt.main:__generated__/conditional/48
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 22 run function mtnt.main:__generated__/conditional/49
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 23 run function mtnt.main:__generated__/conditional/50
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 24 run function mtnt.main:__generated__/conditional/51
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 25 run function mtnt.main:__generated__/conditional/52
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 26 run function mtnt.main:__generated__/conditional/53
execute if score #execute LANG_MC_INTERNAL matches 0 if score random_tnt rng_score matches 27 run function mtnt.main:__generated__/conditional/54