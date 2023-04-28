import ./macros/rngV2.mcm
import ./macros/private_macros.mcm

function load{
    # Make a Dummy scoreboard of Fuse Timer
    scoreboard objectives add LANG_MC_INTERNAL dummy

    scoreboard objectives add fuse_time dummy
    scoreboard objectives add cloud_fuse_time dummy
    scoreboard objectives add rng_score dummy
    scoreboard objectives add private dummy

    scoreboard objectives add pos_x1 dummy
    scoreboard objectives add pos_y1 dummy
    scoreboard objectives add pos_z1 dummy

    scoreboard objectives add pos_x2 dummy
    scoreboard objectives add pos_y2 dummy
    scoreboard objectives add pos_z2 dummy

    scoreboard objectives add rc_clicked minecraft.used:minecraft.carrot_on_a_stick


    gamerule universalAnger true  
    gamerule showDeathMessages false
    gamerule keepInventory true
    gamerule doWeatherCycle false
    gamerule doDaylightCycle false
}
clock 30t{
    execute(if score acid_rain private matches 1){
        execute as @a[tag=!master] at @s if blocks ~ ~ ~ ~ ~30 ~ ~ 200 ~ masked run{
            effect give @s instant_damage 1 0 true
        }
        execute as @e[type=#minecraft:all_living, type=!player] run{
            effect give @s instant_damage 1 0 true
        } 
        execute as @e[type=#minecraft:ded_mobs] run{
            effect give @s instant_health 1 0 true
        } 
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
    # Puffcursion child
    execute as @e[type=pufferfish, tag=puffcursion] at @s run{
        execute(if entity @s[tag=puffcursion_child]){
            LOOP(10, i){
                summon pufferfish ~<%Math.cos(i)*2%> ~1 ~<%Math.sin(i)*2%> {Tags:["puffcursion_child_2", "puffcursion"]}
            }
        }else execute(if entity @s[tag=puffcursion_child_2]){
            LOOP(10, i){
                summon pufferfish ~<%Math.cos(i)*2%> ~1 ~<%Math.sin(i)*2%> {Tags:["puffcursion_child_3", "puffcursion"]}
            }
        }else execute(if entity @s[tag=puffcursion_child_3]){
            LOOP(10, i){
                summon pufferfish ~<%Math.cos(i)*2%> ~1 ~<%Math.sin(i)*2%> {Tags:["puffcursion_child_4", "puffcursion"]}
            }
            execute as @a at @s run particle dust 1.000 0.918 0.180 1 ~ ~5 ~ 0 0 0 1 1000000000 normal 
        }else execute(if entity @s[tag=puffcursion_child_4]){
            LOOP(10, i){
                summon pufferfish ~<%Math.cos(i)*2%> ~1 ~<%Math.sin(i)*2%> {Tags:["puffcursion_child_5", "puffcursion"]}
            }
        }else execute(if entity @s[tag=puffcursion_child_5]){
            LOOP(10, i){
                summon pufferfish ~<%Math.cos(i)*2%> ~1 ~<%Math.sin(i)*2%> {Tags:["puffcursion_child_6", "puffcursion"]}
            }
        }
    }
}
clock 10t{
    #cannon
    execute as @e[type=armor_stand, tag=cannon] at @s run{
        tp @s ~ ~ ~ facing entity @a[distance=..30, limit=1, sort=nearest]
    }
    # music TNT
    execute as @e[type=zombie, tag=dancing] at @s if score dance_move private matches 1 run{
        data merge entity @s {Motion:[0.0,0.3,0.0]}
    }
}
clock 5t{
    execute as @e[type=armor_stand, tag=sat_firing] at @s run block{
        name particle_test
        LOOP(360,i){
            particle dust 1.000 0.918 0.180 1 ~<%Math.sin(i)%> ~-<%i/30%> ~<%Math.cos(i)%> 0 0 0 1 1 normal
        }
    }
}
function tick{
    effect give @a[tag=!in_darkness] night_vision 100 0 true

    # sandstorm
    execute as @a[tag=in_sandstorm] at @s run{
        playsound minecraft:block.big_dripleaf.tilt_down master @s
        # particle block red_sand ~ ~1 ~ 4 4 4 1 2000 normal
        # effect give @s minecraft:blindness 3 10 true
        effect give @s minecraft:darkness 3 10 true
        particle cloud ~ ~ ~ 2 2 2 1 20 normal
        # particle minecraft:falling_spore_blossom ~ ~1 ~ 3 3 3 1 1000
        particle minecraft:white_ash ~ ~1 ~ 3 3 3 1 5000
        particle minecraft:crimson_spore ~ ~1 ~ 3 3 3 1 5000
        effect give @s minecraft:slowness 3 3 true
    }
    # cloud
    execute as @a[tag=cloud_following] at @s run{
        tp @e[type=armor_stand, tag=cloud, limit=1, sort=nearest] ~ ~8 ~
    }
    # execute as @e[type=armor_stand, tag=cloud] store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse
    # music
    execute as @e[type=zombie, tag=dancing] at @s run{
        execute(if score dance_move private matches 0){
            tp @s ~ ~ ~ ~5 ~
        }
        particle minecraft:note ~ ~2 ~ 0 0 0 1 1
    }
    #Time TNT
    execute as @e[type=tnt] at @s if entity @e[type=armor_stand, tag=tnt.time, distance=..1] on origin run{
        tag @s add is_igniter
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
            tellraw @a {"text":"Puffcursion TNT might crash the game. Proceed with caution", "color":"red"}
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
        #--- warden
        execute if entity @s[tag=warden] run{
            placetnt warden 110016
        }
        #--- drone
        execute if entity @s[tag=drone] run{
            placetnt drone 110017
        }
        #--- betty
        execute if entity @s[tag=betty] run{
            placetnt betty 110018
        }
        #--- uav
        execute if entity @s[tag=uav] run{
            placetnt uav 110019
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
                        execute in minecraft:overworld run tp @a[tag=!master] 66 79 17
                        tellraw @a[tag=!master] {"text":"You are teleported in the Overworld", "color":"green"}
                    } 
                    execute(if score dimension_rng rng_score matches 1){
                        execute in minecraft:the_end run tp @a[tag=!master] 20 100 30
                        tellraw @a[tag=!master] {"text":"You are teleported in the End", "color":"green"}
                    } 
                    execute(if score dimension_rng rng_score matches 2){
                        execute in minecraft:the_nether run tp @a[tag=!master] 47 59 11
                        tellraw @a[tag=!master] {"text":"You are teleported in the Nether", "color":"green"}
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
                    sequence{
                        LOOP(12,i){
                            delay 31t
                            execute at @e[type=armor_stand, tag=cloud] run{
                                summon creeper ~ ~ ~ {Silent:1b,ExplosionRadius:<%i + 1 * 2%>b,Fuse:29,ignited:1b,ActiveEffects:[{Id:14,Amplifier:1b,Duration:25}]}
                                summon tnt ~ ~ ~ {Fuse:30}
                            }
                            <%%
                                if(i == 11){
                                    emit(`tag @a[tag=cloud_following] remove cloud_following`)
                                    emit(`kill @e[type=armor_stand, tag=cloud]`)
                                }
                            %%>
                        }
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
                    scoreboard players set dance_move private 0
                    summon zombie ~ ~ ~ {DeathLootTable:"minecraft:bat", Silent:1b,Tags:["npcs", "dancing"],CustomName:'{"text":"NPC 1"}',ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",Count:1b,tag:{display:{color:4014663}}}]}
                    summon zombie ~ ~ ~ {DeathLootTable:"minecraft:bat", Silent:1b,Tags:["npcs", "dancing"],CustomName:'{"text":"NPC 2"}',ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",Count:1b,tag:{display:{color:4014663}}}]}
                    summon zombie ~ ~ ~ {DeathLootTable:"minecraft:bat", Silent:1b,Tags:["npcs", "dancing"],CustomName:'{"text":"NPC 3"}',ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",Count:1b,tag:{display:{color:4014663}}}]}
                    
                    playsound minecraft:music_disc.pigstep master @a ~ ~ ~ 1 1.5
                    spreadplayers ~ ~ 3 3 false @e[type=minecraft:zombie, tag=npcs]

                    sequence{
                        delay 15s
                        scoreboard players set dance_move private 1
                        delay 8s
                        scoreboard players set dance_move private 0
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
                    kill @e[type=tnt,distance=..1]
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
                    time set noon
                    tellraw @a [{"text":"The sun is now very bright","color":"red"}]
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
                        time set midnight
                    }
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
                    # is_igniter: tag for exclusion
                    effect give @e[type=#minecraft:all_living, tag=!master, distance=..40] speed 15 10 true
                    effect give @e[type=#minecraft:ded_mobs, tag=!master, distance=..40] speed 15 10 true
                    execute as @a[tag=!master] at @s run{
                        particle minecraft:elder_guardian ~ ~ ~ 0 0 0 1 1
                    }
                    tellraw @a [{"text":"The time is sped up","color":"gold"}]
                    sequence{
                        LOOP(15*20,i){
                            time add 10s
                            delay 1t
                        }
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    tag @a[tag=is_igniter] remove is_igniter
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

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 10 run{
                    rng range 0 28 random_tnt rng_score
                    execute(if score random_tnt rng_score matches 0){
                        # execute as @a run function mtnt.main:dimension
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.dimension","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110001}}]}
                        tellraw @a {"text":"The output of lucky TNT is Dimension TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 1){
                        # execute as @a run function mtnt.main:sandstorm
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.sandstorm","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110002}}]}
                        tellraw @a {"text":"The output of lucky TNT is Sandstorm TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 2){
                        # execute as @a run function mtnt.main:acid_rain
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.acid_rain","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110003}}]}
                        tellraw @a {"text":"The output of lucky TNT is Acid Rain TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 3){
                        # execute as @a run function mtnt.main:cloud
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.cloud","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110004}}]}
                        tellraw @a {"text":"The output of lucky TNT is Cloud TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 4){
                        # execute as @a run function mtnt.main:music
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.music","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110005}}]}
                        tellraw @a {"text":"The output of lucky TNT is Music TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 5){
                        # execute as @a run function mtnt.main:sun
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.sun","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110006}}]}
                        tellraw @a {"text":"The output of lucky TNT is Sun TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 6){
                        # execute as @a run function mtnt.main:time
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.time","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110007}}]}
                        tellraw @a {"text":"The output of lucky TNT is Time TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 7){
                        # execute as @a run function mtnt.main:invert
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.invert","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110008}}]}
                        tellraw @a {"text":"The output of lucky TNT is Invert TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 8){
                        # execute as @a run function mtnt.main:confetti
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.confetti","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110010}}]}
                        tellraw @a {"text":"The output of lucky TNT is Confetti TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 9){
                        # execute as @a run function mtnt.main:laser
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.laser","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110011}}]}
                        tellraw @a {"text":"The output of lucky TNT is Laser TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 10){
                        # execute as @a run function mtnt.main:puffcursion
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.puffcursion","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110012}}]}
                        tellraw @a {"text":"The output of lucky TNT is Puffcursion TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 11){
                        # execute as @a run function mtnt.main:glitch
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.glitch","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110013}}]}
                        tellraw @a {"text":"The output of lucky TNT is Glitch TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 12){
                        # execute as @a run function mtnt.main:ninja
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.ninja","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110014}}]}
                        tellraw @a {"text":"The output of lucky TNT is Ninja TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 13){
                        # execute as @a run function mtnt.main:pirate
                        summon armor_stand ~ ~ ~ {NoGravity:1b,Invisible:1b,Tags:["tnt.pirate","tnt.as"],ArmorItems:[{},{},{},{id:"minecraft:endermite_spawn_egg",Count:1b,tag:{CustomModelData:110015}}]}
                        tellraw @a {"text":"The output of lucky TNT is Pirate TNT"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 14){
                        execute positioned ~-10 ~20 ~-10 run{
                            LOOP(20,i){
                                LOOP(20,j){
                                    summon item ~<%i%> ~ ~<%j%> {Item:{id:"minecraft:diamond",Count:1b}}
                                }
                            }
                        }
                        tellraw @a {"text":"The output of lucky TNT is Diamonds"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 15){
                        execute positioned ~-10 ~20 ~-10 run{
                            LOOP(20,i){
                                LOOP(20,j){
                                    summon item ~<%i%> ~ ~<%j%> {Item:{id:"minecraft:diamond_block",Count:1b}}
                                }
                            }
                        }
                        tellraw @a {"text":"The output of lucky TNT is Diamonds Blocks"}
                        kill @s
                    }else execute(if score random_tnt rng_score matches 16){
                        fill ~5 ~-1 ~5 ~-5 ~-1 ~-5 minecraft:diamond_block
                        tellraw @a {"text":"The output of lucky TNT is Diamonds Blocks"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }else execute(if score random_tnt rng_score matches 17){
                        fill ~5 ~-1 ~5 ~-5 ~-1 ~-5 minecraft:emerald_block
                        tellraw @a {"text":"The output of lucky TNT is Emerald Blocks"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }else execute(if score random_tnt rng_score matches 18){
                        summon item ~ ~1 ~ {Motion:[0.1,0.3,-0.2],Item:{id:"minecraft:netherite_helmet",Count:1b,tag:{display:{Name:'{"text":"OP Armor","color":"gold","italic":false}'},Enchantments:[{id:"minecraft:protection",lvl:5s},{id:"minecraft:fire_protection",lvl:5s},{id:"minecraft:blast_protection",lvl:5s},{id:"minecraft:projectile_protection",lvl:5s},{id:"minecraft:respiration",lvl:5s},{id:"minecraft:aqua_affinity",lvl:5s},{id:"minecraft:thorns",lvl:5s},{id:"minecraft:unbreaking",lvl:5s}]}}}
                        tellraw @a {"text":"The output of lucky TNT is OP Helmet"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }else execute(if score random_tnt rng_score matches 19){
                        summon item ~ ~1 ~ {Motion:[0.1,0.3,-0.2],Item:{id:"minecraft:netherite_chestplate",Count:1b,tag:{display:{Name:'{"text":"OP Armor","color":"gold","italic":false}'},Enchantments:[{id:"minecraft:protection",lvl:5s},{id:"minecraft:fire_protection",lvl:5s},{id:"minecraft:blast_protection",lvl:5s},{id:"minecraft:projectile_protection",lvl:5s},{id:"minecraft:respiration",lvl:5s},{id:"minecraft:aqua_affinity",lvl:5s},{id:"minecraft:thorns",lvl:5s},{id:"minecraft:unbreaking",lvl:5s}]}}}
                        tellraw @a {"text":"The output of lucky TNT is OP Chestplate"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }else execute(if score random_tnt rng_score matches 20){
                        summon item ~ ~1 ~ {Motion:[0.1,0.3,-0.2],Item:{id:"minecraft:netherite_leggings",Count:1b,tag:{display:{Name:'{"text":"OP Armor","color":"gold","italic":false}'},Enchantments:[{id:"minecraft:protection",lvl:5s},{id:"minecraft:fire_protection",lvl:5s},{id:"minecraft:blast_protection",lvl:5s},{id:"minecraft:projectile_protection",lvl:5s},{id:"minecraft:respiration",lvl:5s},{id:"minecraft:aqua_affinity",lvl:5s},{id:"minecraft:thorns",lvl:5s},{id:"minecraft:unbreaking",lvl:5s}]}}}
                        tellraw @a {"text":"The output of lucky TNT is OP Leggings"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }else execute(if score random_tnt rng_score matches 21){
                        summon item ~ ~1 ~ {Motion:[0.1,0.3,-0.2],Item:{id:"minecraft:netherite_boots",Count:1b,tag:{display:{Name:'{"text":"OP Armor","color":"gold","italic":false}'},Enchantments:[{id:"minecraft:protection",lvl:5s},{id:"minecraft:fire_protection",lvl:5s},{id:"minecraft:blast_protection",lvl:5s},{id:"minecraft:projectile_protection",lvl:5s},{id:"minecraft:respiration",lvl:5s},{id:"minecraft:aqua_affinity",lvl:5s},{id:"minecraft:thorns",lvl:5s},{id:"minecraft:unbreaking",lvl:5s}]}}}
                        tellraw @a {"text":"The output of lucky TNT is OP Boots"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }else execute(if score random_tnt rng_score matches 22){
                        summon item ~ ~1 ~ {Motion:[0.1,0.3,-0.2],Item:{id:"minecraft:netherite_sword",Count:1b,tag:{display:{Name:'{"text":"OP Sword","color":"gold","italic":false}'},Enchantments:[{id:"minecraft:sharpness",lvl:5s},{id:"minecraft:smite",lvl:5s},{id:"minecraft:bane_of_arthropods",lvl:5s},{id:"minecraft:knockback",lvl:5s},{id:"minecraft:fire_aspect",lvl:5s},{id:"minecraft:looting",lvl:5s},{id:"minecraft:sweeping",lvl:5s},{id:"minecraft:unbreaking",lvl:5s},{id:"minecraft:mending",lvl:5s}]}}}
                        tellraw @a {"text":"The output of lucky TNT is OP Sword"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }else execute(if score random_tnt rng_score matches 23){
                        summon item ~ ~1 ~ {Motion:[0.1,0.3,-0.2],Item:{id:"minecraft:netherite_axe",Count:1b,tag:{display:{Name:'{"text":"OP Axe","color":"gold","italic":false}'},Enchantments:[{id:"minecraft:sharpness",lvl:5s},{id:"minecraft:smite",lvl:5s},{id:"minecraft:bane_of_arthropods",lvl:5s},{id:"minecraft:knockback",lvl:5s},{id:"minecraft:fire_aspect",lvl:5s},{id:"minecraft:looting",lvl:5s},{id:"minecraft:sweeping",lvl:5s},{id:"minecraft:unbreaking",lvl:5s},{id:"minecraft:mending",lvl:5s}]}}}
                        tellraw @a {"text":"The output of lucky TNT is OP Axe"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }else execute(if score random_tnt rng_score matches 24){
                        LOOP(8,i){
                            summon zombie ~ ~ ~ {IsBaby:1b}
                        }
                        tellraw @a {"text":"The output of lucky TNT is Baby Zombies"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }else execute(if score random_tnt rng_score matches 25){
                        LOOP(8,i){
                            summon cave_spider ~ ~ ~
                        }
                        tellraw @a {"text":"The output of lucky TNT is Cave Spider"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }else execute(if score random_tnt rng_score matches 26){
                        LOOP(4,i){
                            summon illusioner ~ ~ ~
                        }
                        tellraw @a {"text":"The output of lucky TNT is Illusioner"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }else execute(if score random_tnt rng_score matches 27){
                        LOOP(4,i){
                            summon ravager ~ ~ ~
                        }
                        tellraw @a {"text":"The output of lucky TNT is Ravager"}
                        kill @e[type=tnt, distance=..1]
                        kill @s
                    }
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
                    execute positioned ~-10 ~20 ~-10 run{
                        LOOP(20,i){
                            LOOP(20,j){
                                summon item ~<%i%> ~ ~<%j%> {Item:{id:"minecraft:cookie",Count:1b,tag:{Enchantments:[{}]}}}
                            }
                        }
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
                        LOOP(5,i){
                            delay 10t
                            execute as @e[type=armor_stand, tag=sat] at @s run{
                                tag @s add sat_firing
                                playsound minecraft:item.trident.return master @a ~ ~ ~ 2 0.1
                            } 
                            tellraw @a {"text":"[Satellite] Target Acquired", "color":"green"}
                            delay 1s
                            execute at @e[type=armor_stand, tag=sat] run{
                                tellraw @a {"text":"[Satellite] Firing", "color":"green"}
                                summon fireball ~ ~-0.35 ~ {ExplosionPower:15b,power:[0.0,-0.2,0.0],Item:{id:"minecraft:end_crystal",Count:1b}}
                            }
                            delay 10t
                            tellraw @a {"text":"[Satellite] Target Destroyed, Teleporting...", "color":"green"}
                            execute as @e[type=armor_stand, tag=sat] at @s run{
                                <%%
                                    function getRandomArbitrary(min, max) {
                                        return Math.random() * (max - min) + min;
                                    }
                                    emit(`tp @s ~${getRandomArbitrary(-35, 35)} ~ ~${getRandomArbitrary(-35, 35)}`)
                                %%>
                            }
                            <%%
                                if(i == 4){
                                    emit(`tellraw @a {"text":"[Satellite] Returning...", "color":"green"}`)
                                    emit(`kill @e[type=armor_stand, tag=sat]`)
                                }
                            %%>
                        }
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
                    tellraw @a {"text":"There is a glitch in the matrix, all the movements are now corrupted", "color":"red"}
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
                    sequence{
                        LOOP(225,i){
                            <%%
                                function getRandomArbitrary(min, max) {
                                    return Math.random() * (max - min) + min;
                                }
                                emit(`execute as @a at @s run tp @s ~ ~ ~ ~${Number((getRandomArbitrary(-2, 2)).toFixed(2))} ~${Number((getRandomArbitrary(-2, 2)).toFixed(2))}`)
                            %%>
                            delay 2t
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

        #--- warden
        execute if entity @s[tag=tnt.warden] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block black_concrete ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    execute as @a[sort=random, limit=1] at @s run{
                        function main:warden_morph_main
                        give @s carrot_on_a_stick{display:{Name:'{"text":"Shoot TNT","color":"green","italic":false}',Lore:['{"text":"Right Click to Shoot","color":"light_purple","italic":false}']},HideFlags:63,Unbreakable:1b,CustomModelData:101106} 1
                    }
                    schedule 15s replace{
                        execute as @a[tag=warden_morphed_player] at @s run{
                            function main:demorph
                            clear @s carrot_on_a_stick{display:{Name:'{"text":"Shoot TNT","color":"green","italic":false}',Lore:['{"text":"Right Click to Shoot","color":"light_purple","italic":false}']},HideFlags:63,Unbreakable:1b,CustomModelData:101106}
                        }
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=tnt, distance=..1]
                    kill @e[type=armor_stand,tag=tnt.warden,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- drone
        execute if entity @s[tag=tnt.drone] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block white_concrete ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    function lockdown:devices/drone/summon
                    schedule 30s replace{
                        kill @e[type=armor_stand, tag=ld_drone]
                        kill @e[type=bee, tag=ld_drone_hitbox]
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=tnt, distance=..1]
                    kill @e[type=armor_stand,tag=tnt.drone,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- betty
        execute if entity @s[tag=tnt.betty] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block brown_concrete ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    summon cow ~ ~ ~ {DeathLootTable:"minecraft:bat",Health:300f,Tags:["betty"],Attributes:[{Name:generic.max_health,Base:300},{Name:generic.movement_speed,Base:0.5}]}
                    schedule 20s replace{
                        kill @e[type=cow,tag=betty]
                    }
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    kill @e[type=tnt, distance=..1]
                    kill @e[type=armor_stand,tag=tnt.betty,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }

        #--- uav
        execute if entity @s[tag=tnt.uav] run{
            execute(if entity @e[type=tnt,distance=..0.5]){
                # Teleport itself to the ignited TNT
                tp @s @e[type=tnt,distance=..0.5,sort=nearest,limit=1]

                # Use its 'fuse_time' scoreboard to link with 'Fuse' of TNT
                execute store result score @s fuse_time run data get entity @e[type=tnt,distance=..0.5,limit=1] Fuse

                # Runs a particle effect when ignited
                execute if score @s fuse_time matches 1..80 run block{
                    particle minecraft:block iron_block ~ ~ ~ 1 1 1 1 20
                }

                # Execute the Exploding Mechanics
                execute if score @s fuse_time matches 2 run{
                    <%%
                        let noOfTnts = 50;
                        let offset = noOfTnts / 2 * 2;
                        for (let i = 0; i < noOfTnts; i++) {
                            for (let j = 0; j < noOfTnts; j++) {
                                emit(`summon tnt ~${(i * 2) - offset} ~30 ~${(j * 2) - offset} {Fuse:50}`)
                            }  
                        }
                    %%>
                }

                # Kill the AS if TNT is exploded
                execute if score @s fuse_time matches 1 run{
                    # kill @e[type=tnt, distance=..1]
                    kill @e[type=armor_stand,tag=tnt.uav,distance=..4]
                    kill @s
                }
            }
            execute(unless block ~ ~ ~ tnt unless entity @e[type=tnt,distance=..0.5]){
                # Breaking
                kill @s
            }
        }
    }

    # Betty 
    execute as @e[type=cow, tag=betty] at @s run{
        execute if entity @s[nbt={HurtTime:1s}] run summon item ~ ~ ~ {PickupDelay:40,Item:{id:"minecraft:carrot_on_a_stick",Count:1b,tag:{display:{Name:'{"text":"Magic Milk","color":"gold","italic":false}'},CustomModelData:101107}}}
    }
    execute as @a[scores={rc_clicked=1..}, predicate=mtnt.main:drank_milk] at @s anchored eyes positioned ^ ^ ^1 run{
        loot give @s loot minecraft:betty_loot
        clear @s carrot_on_a_stick{CustomModelData:101107} 1
        scoreboard players set @s rc_clicked 0
    }
    # Shoot TNT
    execute as @a[scores={rc_clicked=1..}, predicate=mtnt.main:shoot_tnt] at @s anchored eyes positioned ^ ^ ^1 run{
        summon tnt ~ ~ ~ {Tags:["warden_tnt"], Fuse:40}
        scoreboard players set @s rc_clicked 0
    }
    execute as @e[type=tnt, tag=warden_tnt, tag=!tag_added] at @s rotated as @a[tag=warden_morphed_player, limit=1, sort=nearest] run{
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
    tellraw @s {"text":"Lots of rainbow colors! ...and cookies?","color":"gold"}
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
function warden{
    givetnt <Warden TNT> 110016 warden
    tellraw @s {"text":"Morph any one player into warden","color":"gold"}
}
function drone{
    givetnt <Drone TNT> 110017 drone
    tellraw @s {"text":"Summons a drone that will attack the player","color":"gold"}
}
function betty{
    givetnt <Betty TNT> 110018 betty
    tellraw @s {"text":"Spawns a very fast cow, which when hit drop a milk bucket and right clicking it will give you a random loot","color":"gold"}
}
function uav{
    givetnt <UAV TNT> 110019 uav
    tellraw @s {"text":"Spawns a bunch of falling TNT","color":"gold"}
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

predicate shoot_tnt{
    "condition": "minecraft:entity_properties",
    "entity": "this",
    "predicate": {
        "equipment": {
            "mainhand": {
                "item": "minecraft:carrot_on_a_stick",
                "nbt": "{CustomModelData:101106}"
            }
        }
    }
}
predicate drank_milk{
    "condition": "minecraft:entity_properties",
    "entity": "this",
    "predicate": {
        "equipment": {
            "mainhand": {
                "item": "minecraft:carrot_on_a_stick",
                "nbt": "{CustomModelData:101107}"
            }
        }
    }
}



