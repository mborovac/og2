class GoldFactory < Factory
  PRODUCTION = {
    one: 2,
    two: 3,
    three: 4,
    four: 6,
    five: 8
  }

  UPGRADE_DURATION = {
    one: 15,
    two: 30,
    three: 60,
    four: 90
  }

  UPGRADE_COST = {
    one: { iron: 0, copper: 100, gold: 2 },
    two: { iron: 0, copper: 200, gold: 4 },
    three: { iron: 0, copper: 400, gold: 8 },
    four: { iron: 0, copper: 800, gold: 16 }
  }
end
