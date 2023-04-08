#built using mc-build (https://github.com/mc-build/mc-build)

tellraw @a {"text":"[Satellite] Firing", "color":"green"}
summon fireball ~ ~-0.35 ~ {ExplosionPower:15b,power:[0.0,-0.2,0.0],Item:{id:"minecraft:end_crystal",Count:1b}}