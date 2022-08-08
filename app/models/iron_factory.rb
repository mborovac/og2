class IronFactory < Factory
  PRODUCTION = {
    one: 10,
    two: 20,
    three: 40,
    four: 80,
    five: 150
  }

  UPGRADE_DURATION = {
    one: 15,
    two: 30,
    three: 60,
    four: 90
  }

  UPGRADE_COST = {
    one: { iron: 300, copper: 100, gold: 1 },
    two: { iron: 800, copper: 250, gold: 2 },
    three: { iron: 1600, copper: 500, gold: 4 },
    four: { iron: 3000, copper: 1000, gold: 8 }
  }
end
