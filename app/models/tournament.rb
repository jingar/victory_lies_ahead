# == Schema Information
#
# Table name: tournaments
#
#  id         :integer          not null, primary key
#  start_date :datetime
#  end_date   :datetime
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tournament < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date, :heats_attributes

  has_many :heats
  accepts_nested_attributes_for :heats

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_uniqueness_of :start_date
  validates_uniqueness_of :end_date
end
