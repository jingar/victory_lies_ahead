class Tournament < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date, :heats_attributes

  has_many: :heats
  accepts_nested_attributes_for: :heats

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_uniqueness_of :start_date
  validates_uniqueness_of :end_date
end
