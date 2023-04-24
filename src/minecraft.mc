advancement punched{
  "criteria": {
    "requirement": {
      "trigger": "minecraft:player_hurt_entity",
      "conditions": {
        "entity": [
          {
            "condition": "minecraft:entity_properties",
            "entity": "this",
            "predicate": {
              "type": "minecraft:villager",
              "nbt": "{Tags:[\"count_punch_AS\"]}"
            }
          }
        ]
      }
    }
  },
  "rewards": {
    "function": "mtnt.main:increment_punch"
  }
}

loot_table betty_loot{
  "type": "minecraft:generic",
  "pools": [
    {
      "rolls": 1,
      "entries": [
        {
          "type": "minecraft:sequence",
          "children": [
            {
              "type": "minecraft:item",
              "quality": 3,
              "name": "minecraft:iron_ingot"
            },
            {
              "type": "minecraft:item",
              "quality": 2,
              "name": "minecraft:gold_ingot"
            },
            {
              "type": "minecraft:item",
              "name": "minecraft:diamond"
            },
            {
              "type": "minecraft:item",
              "name": "minecraft:redstone"
            },
            {
              "type": "minecraft:item",
              "name": "minecraft:coal"
            },
            {
              "type": "minecraft:item",
              "weight": 4,
              "name": "minecraft:cookie"
            },
            {
              "type": "minecraft:item",
              "name": "minecraft:netherite_scrap"
            },
            {
              "type": "minecraft:item",
              "name": "minecraft:quartz"
            }
          ]
        }
      ],
      "functions": [
        {
          "function": "minecraft:set_count",
          "count": {
            "min": 1,
            "max": 3
          }
        }
      ]
    }
  ]
}

entities all_living{
  
  glow_squid
  pig
  
  wolf
  bat
  witch
  polar_bear
  spider
  
  guardian
  ender_dragon
  piglin_brute
  magma_cube
  
  tropical_fish
  wither
  frog
  creeper
  
  fox
  illusioner
  iron_golem
  player
  ravager
  chicken
  llama
  piglin
  axolotl
  wither_skeleton
  cow
  parrot
  villager
  blaze
  salmon
  bee
  
  silverfish
  cave_spider
  ghast
  mule
  vex
  vindicator
  enderman
  
  trader_llama
  elder_guardian
  turtle
  rabbit
  shulker
  goat
  tadpole
  pillager
  cod
  
  hoglin
  
  evoker
  cat
  mooshroom
  slime
  strider
  dolphin
  horse
  wandering_trader
  endermite
  squid
  warden
  donkey
  allay
  pufferfish
  sheep
  snow_golem
  panda
  ocelot
}

entities ded_mobs{
  husk
  skeleton
  phantom
  drowned
  zombie_horse
  stray
  zombie
  zoglin
  giant
  skeleton_horse
  zombie_villager
  zombified_piglin
}

entities laughing_mob{
  sheep
  cow
  chicken
  pig
  ocelot
}