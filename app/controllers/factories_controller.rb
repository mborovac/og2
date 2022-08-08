class FactoriesController < ApplicationController
  def show
    factory
  end

  def upgrade_level
    if factory.can_be_upgraded?
      new_level = factory.level + 1
      factory.update_attribute(:level, new_level)
      factory.update_attribute(Factory::LEVEL_TIMESTAMP_MAPPING[Factory.level_symbol(new_level)], DateTime.now + factory.next_upgrade_duration(factory.level).seconds)
    end
  end

  private

  def factory
    @factory ||= current_user.factories.find_by(id: params[:id])
  end
end
