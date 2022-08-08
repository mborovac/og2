class CopperFactory < Factory
  PRODUCTION = {
    one: 3,
    two: 7,
    three: 14,
    four: 30,
    five: 60
  }

  UPGRADE_DURATION = {
    one: 15,
    two: 30,
    three: 60,
    four: 90
  }

  UPGRADE_COST = {
    one: { iron: 200, copper: 70, gold: 0 },
    two: { iron: 400, copper: 150, gold: 0 },
    three: { iron: 800, copper: 300, gold: 0 },
    four: { iron: 1600, copper: 600, gold: 0 }
  }
end
