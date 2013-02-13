module TournamentsHelper
  def auto_gen_heats_no_qual(tour)
    heat_interval = 1.hour
    #create heats for the first day - no qualifications
    gen = "m"; date = tour.start_date; heat_full = 0; hurdles_for_heat = []
    #find all male racers with no qualification
    Hurdle.where("qualification IS NULL AND gender = ?", gen).each do |qual|
      hurdles_for_heat << qual; heat_full=heat_full+1
      if heat_full==8
        tour.heats.build(time: date, gender: gen).hurdles << hurdles_for_heat
        hurdles_for_heat = []; heat_full = 0; date = date+heat_interval
      end
    end
    if heat_full != 0
      tour.heats.build(time: date, gender: gen).hurdles << hurdles_for_heat
      hurdles_for_heat = []; heat_full = 0; date = date+heat_interval
    end

    gen = "f"
    #find all female hurdles with no qualification
    Hurdle.where("qualification IS NULL AND gender = ?", gen).each do |qual|
      hurdles_for_heat << qual; heat_full=heat_full+1
      if heat_full==8
        tour.heats.build(time: date, gender: gen).hurdles << hurdles_for_heat
        hurdles_for_heat = []; heat_full = 0; date = date+heat_interval
      end
    end
    if heat_full != 0
      tour.heats.build(time: date, gender: gen).hurdles << hurdles_for_heat
      hurdles_for_heat = []; heat_full = 0; date = date+heat_interval
    end
    return tour
  end
end
