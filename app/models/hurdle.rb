# == Schema Information
#
# Table name: hurdles
#
#  id            :integer          not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  qualification :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
<<<<<<< HEAD
=======
#  gender        :string(255)
>>>>>>> d7b29788053d6854a65e539c2cf4e82262e3cb46
#

class Hurdle < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :qualification, :gender
    belongs_to :user

    validates :user_id, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :gender, presence: true 
end
