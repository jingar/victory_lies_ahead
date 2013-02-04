class Match < ActiveRecord::Base
  attr_accessible :awayGoals, :awayTeam, :homeGoals, :homeTeam, :pitch, :umpire, :when
end
