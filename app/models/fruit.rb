class Fruit < ActiveRecord::Base
  include RankedModel
  ranks :row_order
  validates :name, presence: true
end
