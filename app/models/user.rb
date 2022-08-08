class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :factories, dependent: :delete_all

  validates :username, presence: true, uniqueness: {case_sensitive: false}

  after_create :create_factories

  # TODO need to subtract resources spent on upgrades
  def resources
    {
      iron: iron_factory.produced_so_far,
      copper: copper_factory.produced_so_far,
      gold: gold_factory.produced_so_far
    }
  end

  def iron_factory
    @iron_factory ||= factories.where(type: "IronFactory").first
  end

  def copper_factory
    @copper_factory ||= factories.where(type: "CopperFactory").first
  end

  def gold_factory
    @gold_factory ||= factories.where(type: "GoldFactory").first
  end

  def has_enough_resources?(resource_request)
    self.resources[:iron] >= resource_request[:iron] &&
    self.resources[:copper] >= resource_request[:copper] &&
    self.resources[:gold] >= resource_request[:gold]
  end

  private

  def create_factories
    [IronFactory, CopperFactory, GoldFactory].each do |factory|
      factory.create(user: self)
    end
  end
end
