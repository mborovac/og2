class Factory < ApplicationRecord
  # to avoid self.send("upgraded_to_level_#{level_symbol(self.level).to_s}_at"
  LEVEL_TIMESTAMP_MAPPING = {
    one: :created_at,
    two: :upgraded_to_level_two_at,
    three: :upgraded_to_level_three_at,
    four: :upgraded_to_level_four_at,
    five: :upgraded_to_level_five_at
  }

  belongs_to :user

  def production(for_level)
    self.type.constantize::PRODUCTION[Factory.level_symbol(for_level)]
  end

  def next_upgrade_duration(for_level)
    self.type.constantize::UPGRADE_DURATION[Factory.level_symbol(for_level)]
  end

  def upgrade_cost(for_level)
    self.type.constantize::UPGRADE_COST[Factory.level_symbol(for_level)]
  end

  def produced_so_far
    if self.level == 1
      produced_between(self.created_at, Time.now, 1)
    elsif self.level == 2
      [
        produced_between(self.created_at, self.send(LEVEL_TIMESTAMP_MAPPING[:two]), 1),
        produced_between(send(LEVEL_TIMESTAMP_MAPPING[:two]), Time.now, 2)
      ].reduce(&:+)
    else
      [
        produced_between(self.created_at, self.send(LEVEL_TIMESTAMP_MAPPING[:two]), 1),
        produced_between(send(LEVEL_TIMESTAMP_MAPPING[Factory.level_symbol(self.level)]), Time.now, self.level),
        (2..self.level-1).to_a.map{ |i|
          produced_between(
            send(LEVEL_TIMESTAMP_MAPPING[Factory.level_symbol(i)]),
            send(LEVEL_TIMESTAMP_MAPPING[Factory.level_symbol(i+1)]),
            i
          )
        }.reduce(&:+)
      ].reduce(&:+)
    end
  end

  def can_be_upgraded?
    self.level < 5 && DateTime.now.after?(send(Factory::LEVEL_TIMESTAMP_MAPPING[Factory.level_symbol(self.level)])) && user.has_enough_resources?(upgrade_cost(self.level + 1))
  end

  private

  def total_upgrades_cost

  end

  def produced_between(earlier_timestamp, later_timestamp, level)
    (later_timestamp.to_i - earlier_timestamp.to_i) * production(level)
  end

  def self.level_symbol(for_level)
    case for_level
    when 1
      :one
    when 2
      :two
    when 3
      :three
    when 4
      :four
    when 5
      :five
    else
      :one
    end
  end
end
