module TournamentsHelper
  HEAT_INTERVAL = 3600
  MAX_HEAT_SIZE = 8

  def heat_size(divisor)
    number = divisor / MAX_HEAT_SIZE
    if (divisor % MAX_HEAT_SIZE) !=0
      number = number + 1
    end
    sizes = []
    general = divisor / number
    number.times do |i|
      sizes[i] = general
    end
    if (divisor % number) !=0
      sizes[number-1] = general + divisor%number 
    end
    return sizes
  end

  def auto_gen_heats_no_qual(tour)
    #create heats for the first day - no qualifications
    genders = ["m","f"]; date = tour.start_date; heat_full = 0; hurdles_for_heat = []
    #find all male racers with no qualification
    genders.each do |gen|
      sizes = heat_size(Hurdle.where("qualification IS NULL AND gender = ?", gen).count)
      heat_number = 0
      Hurdle.where("qualification IS NULL AND gender = ?", gen).each do |qual|
        hurdles_for_heat << qual; heat_full=heat_full+1
        if heat_full==sizes[heat_number]
          tour.heats.build(time: date, gender: gen).hurdles << hurdles_for_heat
          hurdles_for_heat = []; heat_full = 0; date = date+HEAT_INTERVAL; heat_number = heat_number +1
        end
      end
      if heat_full != 0
        tour.heats.build(time: date, gender: gen).hurdles << hurdles_for_heat
        hurdles_for_heat = []; heat_full = 0; date = date+HEAT_INTERVAL
      end
    end
    return tour
  end
end
