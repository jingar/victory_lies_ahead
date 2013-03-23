class Score < ActiveRecord::Base
  belongs_to :match
  belongs_to :wattball
  attr_accessible :amount, :matches_id, :wattball_id
end
