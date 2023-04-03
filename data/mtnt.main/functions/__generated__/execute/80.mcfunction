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
execute if score random_tnt rng_score matches 0 run execute as @a run function mtnt.main:dimension
execute if score random_tnt rng_score matches 1 run execute as @a run function mtnt.main:sandstorm
execute if score random_tnt rng_score matches 2 run execute as @a run function mtnt.main:acid_rain
execute if score random_tnt rng_score matches 3 run execute as @a run function mtnt.main:cloud
execute if score random_tnt rng_score matches 4 run execute as @a run function mtnt.main:music
execute if score random_tnt rng_score matches 5 run execute as @a run function mtnt.main:sun
execute if score random_tnt rng_score matches 6 run execute as @a run function mtnt.main:time
execute if score random_tnt rng_score matches 7 run execute as @a run function mtnt.main:invert
execute if score random_tnt rng_score matches 8 run execute as @a run function mtnt.main:lucky
execute if score random_tnt rng_score matches 9 run execute as @a run function mtnt.main:confetti
execute if score random_tnt rng_score matches 10 run execute as @a run function mtnt.main:laser
execute if score random_tnt rng_score matches 11 run execute as @a run function mtnt.main:puffcursion
execute if score random_tnt rng_score matches 12 run execute as @a run function mtnt.main:glitch
execute if score random_tnt rng_score matches 13 run execute as @a run function mtnt.main:ninja