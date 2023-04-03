import ./macros/rngV2.mcm
import ./macros/private_macros.mcm

function load{
    # Make a Dummy scoreboard of Fuse Timer
    scoreboard objectives add LANG_MC_INTERNAL dummy

    scoreboard objectives add fuse_time dummy
    scoreboard objectives add rng_score dummy
    scoreboard objectives add private dummy

    scoreboard objectives add pos_x1 dummy
    scoreboard objectives add pos_y1 dummy
    scoreboard objectives add pos_z1 dummy

    scoreboard objectives add pos_x2 dummy
    scoreboard objectives add pos_y2 dummy
    scoreboard objectives add pos_z2 dummy


    gamerule universalAnger true  
    gamerule showDeathMessages false
    gamerule keepInventory true
    gamerule doWeatherCycle false
    gamerule doDaylightCycle false
}
clock 30t{
    execute(if score acid_rain private matches 1){
        execute as @e[type=#minecraft:all_living, tag=!master] run{
            effect give @s instant_damage 1 0 true
        } 
        execute as @e[type=#minecraft:ded_mobs] run{
            effect give @s instant_health 1 0 true
        } 
    }

    # cloud throwing tnt
    execute at @e[type=armor_stand, tag=cloud] run{
        summon tnt ~ ~ ~ {Fuse:40}
    }

    # cannon firing
    execute as @e[type=armor_stand, tag=cannon] at @s anchored eyes positioned ^ ^ ^1 if entity @a[distance=..20] run{
        summon tnt ~ ~ ~ {Tags:["cannon_ball"], Fuse:40}
    }
    execute as @e[type=tnt, tag=cannon_ball] at @s rotated as @e[type=armor_stand, tag=cannon, limit=1, sort=nearest] run{
        execute store result score @s pos_x1 run data get entity @s Pos[0] 1000
        execute store result score @s pos_y1 run data get entity @s Pos[1] 1000
        execute store result score @s pos_z1 run data get entity @s Pos[2] 1000

        tp @s ^ ^ ^0.1

        execute store result score @s pos_x2 run data get entity @s Pos[0] 1000
        execute store result score @s pos_y2 run data get entity @s Pos[1] 1000
        execute store result score @s pos_z2 run data get entity @s Pos[2] 1000

        scoreboard players operation @s pos_x2 -= @s pos_x1
        scoreboard players operation @s pos_y2 -= @s pos_y1
        scoreboard players operation @s pos_z2 -= @s pos_z1 

        execute store result entity @s Motion[0] double 0.01 run scoreboard players get @s pos_x2
        execute store result entity @s Motion[1] double 0.01 run scoreboard players get @s pos_y2
        execute store result entity @s Motion[2] double 0.01 run scoreboard players get @s pos_z2 

        tag @s add tag_added
    }
}
clock 10t{
    execute as @e[type=armor_stand, tag=sat_firing] at @s run{
        particle dust 1.000 0.918 0.180 2 ~ ~-4.5 ~ 0 3 0 1 100 normal
    }
    #cannon
    execute as @e[type=armor_stand, tag=cannon] at @s run{
        tp @s ~ ~ ~ facing entity @a[distance=..30, limit=1, sort=nearest]
    }
}
function tick{
    effect give @a[tag=!in_darkness] night_vision 100 0 true

    # sandstorm
    execute as @a[tag=in_sandstorm] at @s run{
        # particle cloud ~ ~ ~ 2 2 2 1 200 normal
        particle block red_sand ~ ~1 ~ 1 1 1 1 100 normal
        effect give @s minecraft:blindness 3 10 true
        effect give @s minecraft:darkness 3 10 true
        effect give @s minecraft:slowness 3 3 true
    }
    # cloud
    execute as @a[tag=cloud_following] at @s run{
        tp @e[type=armor_stand, tag=cloud, limit=1, sort=nearest] ~ ~5 ~
    }
    # music
    execute as @e[tag=dancing] at @s run{
        tp @s ~ ~ ~ ~5 ~
        particle minecraft:note ~ ~2 ~ 0 0 0 1 1
    }
    # Puffcursion child
    execute as @e[type=pufferfish, tag=puffcursion] at @s run{
        execute if entity @s[tag=puffcursion_child] run{
            LOOP(10, i){
                summon pufferfish ~<%Math.cos(i)*2%> ~1 ~<%Math.sin(i)*2%> {Tags:["puffcursion_child_2", "puffcursion"]}
            }
        }
        execute if entity @s[tag=puffcursion_child_2] run{
            LOOP(10, i){
                summon pufferfish ~<%Math.cos(i)*2%> ~1 ~<%Math.sin(i)*2%> {Tags:["puffcursion_child_3", "puffcursion"]}
            }
        }
        execute if entity @s[tag=puffcursion_child_3] run{
            LOOP(10, i){
                summon pufferfish ~<%Math.cos(i)*2%> ~1 ~<%Math.sin(i)*2%> {Tags:["puffcursion_child_4", "puffcursion"]}
            }
        }
    }

    # setblock the custom TNT
    execute as @e[type=endermite, tag=tnt.endermite] at @s run{
        #*------ TODO: Change Custom model data
        #--- dimension
        execute if entity @s[tag=dimension] run{
            placetnt dimension 110001
        }
        #--- sandstorm
        execute if entity @s[tag=sandstorm] run{
            placetnt sandstorm 110002
        }
        #--- acid_rain
        execute if entity @s[tag=acid_rain] run{
            placetnt acid_rain 110003
        }
        #--- cloud
        execute if entity @s[tag=cloud] run{
            placetnt cloud 110004
        }
        #--- music
        execute if entity @s[tag=music] run{
            placetnt music 110005
        }
        #--- sun
        execute if entity @s[tag=sun] run{
            placetnt sun 110006
        }
        #--- time
        execute if entity @s[tag=time] run{
            placetnt time 110007
        }
        #--- invert
        execute if entity @s[tag=invert] run{
            placetnt invert 110008
        }
        #--- lucky
        execute if entity @s[tag=lucky] run{
            placetnt lucky 110009
        }
        #--- confetti
        execute if entity @s[tag=confetti] run{
            placetnt confetti 110010
        }
        #--- laser
        execute if entity @s[tag=laser] run{
            placetnt laser 110011
        }
        #--- puffcursion
        execute if entity @s[tag=puffcursion] run{
            placetnt puffcursion 110012
        }
        #--- glitch
        execute if entity @s[tag=glitch] run{
            placetnt glitch 110013
        }
        #--- ninja
        execute if entity @s[tag=ninja] run{
            placetnt ninja 110014
        }
        #--- pirate
        execute if entity @s[tag=pirate] run{
            placetnt pirate 110015
        }
    }

    # Tnt validation and explosion handler
    execute as @e[type=armor_stand, tag=tnt.as] at @s run{
        #--- dimension
        execute if entity @s[tag=tnt.dimension] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle portal ~ ~ ~ 1 1 1 1 20
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    rng range 0 3 dimension_rng rng_score
                    execute(if score dimension_rng rng_score matches 0){
                        execute in minecraft:overworld run tp @a[tag=!master] 20 100 30
                    } 
                    execute(if score dimension_rng rng_score matches 1){
                        execute in minecraft:the_end run tp @a[tag=!master] 20 100 30
                    } 
                    execute(if score dimension_rng rng_score matches 2){
                        execute in minecraft:the_nether run tp @a[tag=!master] 20 100 30
                    }
                    kill @e[type=armor_stand,tag=tnt.dimension,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- sandstorm
        execute if entity @s[tag=tnt.sandstorm] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block red_sand ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    tag @a[tag=!master] add in_sandstorm
                    schedule 15s replace{
                        tag @a[tag=in_sandstorm] remove in_sandstorm
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.sandstorm,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- acid_rain
        execute if entity @s[tag=tnt.acid_rain] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block water ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    weather rain
                    scoreboard players set acid_rain private 1
                    # ! TODO: Change rain particle
                    schedule 15s replace{
                        weather clear
                        scoreboard players set acid_rain private 0
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.acid_rain,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- cloud
        execute if entity @s[tag=tnt.cloud] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block white_terracotta ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    tellraw @a[tag=!master] [{"text":"Look above you","color":"green"}]
                    execute at @a[tag=!master] positioned ~ ~5 ~ run{
                        summon armor_stand ~ ~ ~ {Marker:1b,Invisible:1b,Tags:["cloud"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101013}}]}
                    }
                    tag @a[tag=!master] add cloud_following
                    schedule 15s replace{
                        tag @a[tag=cloud_following] remove cloud_following
                        kill @e[type=armor_stand, tag=cloud]
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.cloud,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
        
        #--- music
        execute if entity @s[tag=tnt.music] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block white_terracotta ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    execute as @e[type=#minecraft:all_living, type=!player, distance=..20] run{
                        tag @s add dancing
                    }
                    playsound minecraft:music_disc.pigstep master @a ~ ~ ~ 1 1.5
                    schedule 20s replace{
                        stopsound @a
                        execute as @a[tag=!master] run{
                            tellraw @a [{"selector":"@s"},{"text":" Died of Dancing","color":"red"}]
                            kill @s
                        }
                        kill @e[tag=dancing]
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.music,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- sun
        execute if entity @s[tag=tnt.sun] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block gold_block ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    execute as @a[tag=!master] at @s run{
                        function mtnt.main:shader_on_spider
                    }
                    scoreboard players set acid_rain private 1
                    # ! TODO: Add Shaders
                    schedule 15s replace{
                        execute as @a[tag=!master] at @s run{
                            function mtnt.main:shader_off_spider
                        }
                        scoreboard players set acid_rain private 0
                    }
                    tellraw @a [{"text":"The sun is now very bright","color":"red"}]
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=tnt,distance=..1]
                    kill @e[type=armor_stand,tag=tnt.sun,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- time
        execute if entity @s[tag=tnt.time] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block yellow_terracotta ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    effect give @e[type=#minecraft:all_living, tag=!master, distance=..40] slowness 15 30 true
                    effect give @e[type=#minecraft:ded_mobs, tag=!master, distance=..40] slowness 15 30 true
                    execute as @a[tag=!master] at @s run{
                        particle minecraft:elder_guardian ~ ~ ~ 0 0 0 1 1
                    }
                    tellraw @a [{"text":"The time is now stopped","color":"gold"}]
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.time,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- invert
        execute if entity @s[tag=tnt.invert] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:reverse_portal ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    execute as @a[tag=!master] at @s run{
                        function mtnt.main:shader_on_creeper
                    }
                    # ! TODO: Add Shaders
                    schedule 15s replace{
                        execute as @a[tag=!master] at @s run{
                            function mtnt.main:shader_off_creeper
                        }
                    }
                    tellraw @a [{"text":"The screen is now inverted","color":"green"}]
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=tnt,distance=..1]
                    kill @e[type=armor_stand,tag=tnt.invert,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        # ! UPDATE TNT DATA
        #--- lucky
        execute if entity @s[tag=tnt.lucky] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block diamond_block ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    rng range 0 5 random_tnt rng_score
                    execute(if score random_tnt rng_score matches 0){
                        execute as @a run function mtnt.main:dimension
                    }else execute(if score random_tnt rng_score matches 1){
                        execute as @a run function mtnt.main:sandstorm
                    }else execute(if score random_tnt rng_score matches 2){
                        execute as @a run function mtnt.main:acid_rain
                    }else execute(if score random_tnt rng_score matches 3){
                        execute as @a run function mtnt.main:cloud
                    }else execute(if score random_tnt rng_score matches 4){
                        execute as @a run function mtnt.main:music
                    }else execute(if score random_tnt rng_score matches 5){
                        execute as @a run function mtnt.main:sun
                    }else execute(if score random_tnt rng_score matches 6){
                        execute as @a run function mtnt.main:time
                    }else execute(if score random_tnt rng_score matches 7){
                        execute as @a run function mtnt.main:invert
                    }else execute(if score random_tnt rng_score matches 8){
                        execute as @a run function mtnt.main:lucky
                    }else execute(if score random_tnt rng_score matches 9){
                        execute as @a run function mtnt.main:confetti
                    }else execute(if score random_tnt rng_score matches 10){
                        execute as @a run function mtnt.main:laser
                    }else execute(if score random_tnt rng_score matches 11){
                        execute as @a run function mtnt.main:puffcursion
                    }else execute(if score random_tnt rng_score matches 12){
                        execute as @a run function mtnt.main:glitch
                    }else execute(if score random_tnt rng_score matches 13){
                        execute as @a run function mtnt.main:ninja
                    }else execute(if score random_tnt rng_score matches 14){
                        execute as @a run function mtnt.main:pirate
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.lucky,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- confetti
        execute if entity @s[tag=tnt.confetti] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle dust 1.000 0.000 0.000 1 ~ ~ ~ 1 1 1 1 10 normal
                    particle dust 0.000 1.000 0.000 1 ~ ~ ~ 1 1 1 1 10 normal
                    particle dust 0.000 0.000 1.000 1 ~ ~ ~ 1 1 1 1 10 normal
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    LOOP(10,i){
                        <%%
                            function getRandomArbitrary(min, max) {
                                return Math.random() * (max - min) + min;
                            }
                            emit(`summon firework_rocket ~${getRandomArbitrary(-10, 10)} ~5 ~${getRandomArbitrary(-10, 10)} {FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Explosions:[{Type:2,Flicker:1b,Trail:1b,Colors:[I;16711680,1647103,16776963]}]}}}}`)
                        %%>
                        particle dust 1.000 0.000 0.000 1 ~ ~ ~ 3 3 3 1 700 normal
                        particle dust 0.000 1.000 0.000 1 ~ ~ ~ 3 3 3 1 700 normal
                        particle dust 0.000 0.000 1.000 1 ~ ~ ~ 3 3 3 1 700 normal
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.confetti,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- laser
        execute if entity @s[tag=tnt.laser] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle dust 1.000 0.918 0.180 1 ~ ~ ~ 1 1 1 1 10 normal
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    summon armor_stand ~ ~10 ~ {Marker:1b,Invisible:1b,Tags:["sat"],ArmorItems:[{},{},{},{id:"minecraft:wooden_hoe",Count:1b,tag:{CustomModelData:101014}}]}
                    playsound minecraft:block.beacon.activate master @a ~ ~10 ~ 2 0.5
                    tellraw @a {"text":"Satellite Summon", "color":"green"}
                    sequence{
                        delay 4s
                        execute as @e[type=armor_stand, tag=sat] at @s run{
                            tag @s add sat_firing
                            playsound minecraft:item.trident.return master @a ~ ~ ~ 2 0.1
                        } 
                        tellraw @a {"text":"[Satellite] Target Acquired", "color":"green"}
                        delay 2s
                        execute at @e[type=armor_stand, tag=sat] run{
                            tellraw @a {"text":"[Satellite] Firing", "color":"green"}
                            summon fireball ~ ~-0.35 ~ {ExplosionPower:15b,power:[0.0,-0.2,0.0],Item:{id:"minecraft:end_crystal",Count:1b}}
                        }
                        delay 3s
                        tellraw @a {"text":"[Satellite] Target Destroyed", "color":"green"}
                        kill @e[type=armor_stand, tag=sat]
                    }
                    
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=armor_stand,tag=tnt.laser,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- puffcursion
        execute if entity @s[tag=tnt.puffcursion] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle dust 1.000 0.918 0.180 1 ~ ~ ~ 1 1 1 1 10 normal
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    LOOP(10, i){
                        summon pufferfish ~<%Math.cos(i)*2%> ~1 ~<%Math.sin(i)*2%> {Tags:["puffcursion_child", "puffcursion"]}
                    }  
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=tnt, distance=..1]
                    kill @e[type=armor_stand,tag=tnt.puffcursion,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- glitch
        execute if entity @s[tag=tnt.glitch] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle dust 1.000 0.918 0.180 1 ~ ~ ~ 1 1 1 1 10 normal
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    sequence{
                        LOOP(15,i){
                            delay 30t
                            <%%
                                function getRandomArbitrary(min, max) {
                                    return Math.random() * (max - min) + min;
                                }
                                emit(`execute as @a[tag=!master] at @s run tp @s ~${getRandomArbitrary(-5, 5)} ~${getRandomArbitrary(-1, 5)} ~${getRandomArbitrary(-5, 5)}`)
                            %%>
                        }
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=tnt, distance=..1]
                    kill @e[type=armor_stand,tag=tnt.glitch,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
   
        #--- ninja
        execute if entity @s[tag=tnt.ninja] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle dust 0 0 0 1 ~ ~ ~ 1 1 1 1 50 normal
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    LOOP(5,i){
                       summon zombie ~ ~ ~ {DeathLootTable:"minecraft:bat",Tags:["ninja"],CustomName:'{"text":"Ninja"}',ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",Count:1b,tag:{display:{color:0}}}],Attributes:[{Name:generic.movement_speed,Base:1},{Name:generic.attack_knockback,Base:5}]} 
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=tnt, distance=..1]
                    kill @e[type=armor_stand,tag=tnt.ninja,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- pirate
        execute if entity @s[tag=tnt.pirate] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block jungle_planks ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    tellraw @a {"text":"A pirate ship has been summoned!", "color":"red"}
                    place template mtnt.main:ship ~-3 ~ ~-10
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=tnt, distance=..1]
                    kill @e[type=armor_stand,tag=tnt.pirate,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
    }
}
function shader_on_spider{
    spawnpoint @s ~ ~ ~ ~ 
    gamemode spectator @s 
    summon spider ~ ~ ~ {NoAI:1b, Tags:["toggle_shader"]}
    spectate @e[tag=toggle_shader, limit=1]
    tag @s add on_shader
    gamerule doImmediateRespawn true
    sequence{
        delay 10t
        kill @a[tag=on_shader]
        gamerule doImmediateRespawn false
        delay 10t
        tp @e[type=spider, tag=toggle_shader] ~ ~-600 ~
        gamemode survival @a[tag=on_shader]
        tag @a[tag=on_shader] remove on_shader
    }
}
function shader_off_spider{
    spawnpoint @s ~ ~ ~ ~ 
    gamemode spectator @s 
    summon sheep ~ ~ ~ {NoAI:1b, Tags:["toggle_shader_undo"]}
    spectate @e[tag=toggle_shader_undo, limit=1]
    tag @s add on_shader_undo
    gamerule doImmediateRespawn true
    sequence{
        delay 10t
        kill @a[tag=on_shader_undo]
        gamerule doImmediateRespawn false
        delay 10t
        tp @e[type=sheep, tag=toggle_shader_undo] ~ ~-600 ~
        gamemode survival @a[tag=on_shader_undo]
        tag @a[tag=on_shader_undo] remove on_shader_undo
    }
}
function shader_on_creeper{
    spawnpoint @s ~ ~ ~ ~ 
    gamemode spectator @s 
    summon creeper ~ ~ ~ {NoAI:1b, Tags:["toggle_shader"]}
    spectate @e[tag=toggle_shader, limit=1]
    tag @s add on_shader
    gamerule doImmediateRespawn true
    sequence{
        delay 10t
        kill @a[tag=on_shader]
        gamerule doImmediateRespawn false
        delay 10t
        tp @e[type=creeper, tag=toggle_shader] ~ ~-600 ~
        gamemode survival @a[tag=on_shader]
        tag @a[tag=on_shader] remove on_shader
    }
}
function shader_off_creeper{
    spawnpoint @s ~ ~ ~ ~ 
    gamemode spectator @s 
    summon sheep ~ ~ ~ {NoAI:1b, Tags:["toggle_shader_undo"]}
    spectate @e[tag=toggle_shader_undo, limit=1]
    tag @s add on_shader_undo
    gamerule doImmediateRespawn true
    sequence{
        delay 10t
        kill @a[tag=on_shader_undo]
        gamerule doImmediateRespawn false
        delay 10t
        tp @e[type=sheep, tag=toggle_shader_undo] ~ ~-600 ~
        gamemode survival @a[tag=on_shader_undo]
        tag @a[tag=on_shader_undo] remove on_shader_undo
    }
}

#> TNT Command
function dimension{
    givetnt <Dimension TNT> 110001 dimension
    tellraw @s {"text":"Randomly teleport the player to any dimension","color":"green"}
}
function sandstorm{
    givetnt <Sandstorm TNT> 110002 sandstorm
    tellraw @s {"text":"Creates a sandstorm around players","color":"green"}
}
function acid_rain{
    givetnt <Acid Rain TNT> 110003 acid_rain
    tellraw @s {"text":"Acid Rain which will damage the player and the mob","color":"green"}
}
function cloud{
    givetnt <Cloud TNT> 110004 cloud
    tellraw @s {"text":"A cloud will follow the player and drop TNT","color":"green"}
}
function music{
    givetnt <Music TNT> 110005 music
    tellraw @s {"text":"Play music and the player will die dancing","color":"green"}
}
function sun{
    givetnt <Sun TNT> 110006 sun
    tellraw @s {"text":"Make the sun brighter and start killing the player and mob","color":"green"}
}
function time{
    givetnt <Time TNT> 110007 time
    tellraw @s {"text":"Freeze all the mobs and players at their position","color":"green"}
}
function invert{
    givetnt <Invert TNT> 110008 invert
    tellraw @s {"text":"Invert the player's POV","color":"green"}
}
function lucky{
    givetnt <Lucky TNT> 110009 lucky
    tellraw @s {"text":"Gives you any TNT","color":"green"}
}
function confetti{
    givetnt <Confetti TNT> 110010 confetti
    tellraw @s {"text":"Lots of rainbow colors!","color":"gold"}
}
function laser{
    givetnt <Laser TNT> 110011 laser
    tellraw @s {"text":"Summons a deadly destructive laser","color":"gold"}
}
function puffcursion{
    givetnt <Puffcursion TNT> 110012 puffcursion
    tellraw @s {"text":"Summon pufferfish which will grow exponentially","color":"gold"}
}
function glitch{
    givetnt <Glitch TNT> 110013 glitch
    tellraw @s {"text":"Introduce movement glitch to everyone","color":"gold"}
}
function ninja{
    givetnt <Ninja TNT> 110014 ninja
    tellraw @s {"text":"Summon ninja which will try to kill the player","color":"gold"}
}
function pirate{
    givetnt <Pirate TNT> 110015 pirate
    tellraw @s {"text":"Summon pirate ship with cannon","color":"gold"}
}

#> Misc.
function reset_hat{
    summon item_frame 328 161 223 {Facing:4b,Invulnerable:1b,Invisible:1b,Tags:["hat_if"],Item:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{display:{Name:'{"text":"Click the button if you see the hat","color":"green"}'},CustomModelData:123321}}}

    setblock 328 160 223 polished_blackstone_button[facing=west]
}
function click_hat{
    kill @e[type=item_frame, tag=hat_if]
    setblock 328 160 223 air
    execute as @a at @s run{
        summon firework_rocket ^1 ^ ^ {LifeTime:20,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:2,Trail:1b,Colors:[I;3691519,16383810,16711680]},{Type:0,Colors:[I;382463,16723676]}]}}}}
        summon firework_rocket ^-1 ^ ^ {LifeTime:20,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:2,Trail:1b,Colors:[I;3691519,16383810,16711680]},{Type:0,Colors:[I;382463,16723676]}]}}}}
    }
}



