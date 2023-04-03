import ./macros/rngV2.mcm
import ./macros/private_macros.mcm

function load{
    # Make a Dummy scoreboard of Fuse Timer
    scoreboard objectives add fuse_time dummy
    scoreboard objectives add rng_score dummy
    scoreboard objectives add private dummy
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
                    kill @e[type=armor_stand,tag=tnt.sun,distance=..4]
                    kill @e[type=tnt,distance=..1]
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
                    kill @e[type=armor_stand,tag=tnt.invert,distance=..4]
                    kill @e[type=tnt,distance=..1]
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
    tellraw @a {"text":"Randomly teleport the player to any dimension","color":"green"}
}
function sandstorm{
    givetnt <Sandstorm TNT> 110002 sandstorm
    tellraw @a {"text":"Creates a sandstorm around players","color":"green"}
}
function acid_rain{
    givetnt <Acid Rain TNT> 110003 acid_rain
    tellraw @a {"text":"Acid Rain which will damage the player and the mob","color":"green"}
}
function cloud{
    givetnt <Cloud TNT> 110004 cloud
    tellraw @a {"text":"A cloud will follow the player and drop TNT","color":"green"}
}
function music{
    givetnt <Music TNT> 110005 music
    tellraw @a {"text":"Play music and the player will die dancing","color":"green"}
}
function sun{
    givetnt <Sun TNT> 110006 sun
    tellraw @a {"text":"Make the sun brighter and start killing the player and mob","color":"green"}
}
function time{
    givetnt <Time TNT> 110007 time
    tellraw @a {"text":"Freeze all the mobs and players at their position","color":"green"}
}
function invert{
    givetnt <Invert TNT> 110008 invert
    tellraw @a {"text":"Invert the player's POV","color":"green"}
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



