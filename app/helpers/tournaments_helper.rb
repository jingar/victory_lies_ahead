module TournamentsHelper
  HEAT_INTERVAL = 3600  #every hour
  MAX_HEAT_SIZE = 8  #only 8 tracks available

  #given number of participants in a round, calculate size of each heat
  def heat_sizes(divisor)
    sizes = []
    #calculate number of heats necessary
    number = divisor / MAX_HEAT_SIZE
    if (divisor % MAX_HEAT_SIZE) !=0
      #if not divided evenly, add one
      number += 1
    end

    #find number of lanes for most of the heats
    general = divisor / number

    #set number of participants of every lane to be general
    number.times do |i|
      sizes[i] = general
    end

    rest = divisor % number
    if (rest) !=0
      #if any racers are not in heats, add them to the last one
      sizes[number-1] = general + rest 
    end

    return sizes
  end

  def how_many_rounds(divisor)
    rounds = []; i = 1
    while divisor >= MAX_HEAT_SIZE
      rounds[i] = divisor
      
      if divisor == MAX_HEAT_SIZE then break end

      divisor/=2
      remainder = divisor % MAX_HEAT_SIZE
      if remainder !=0 && 
        add = MAX_HEAT_SIZE - remainder
        divisor += add
      end

      i+=1
    end

    return rounds
  end

  def allocate_lanes(heat)
    allocate_lanes_randomly(heat)
  end

  def allocate_lanes_randomly(heat)
    lanes = (1..MAX_HEAT_SIZE).to_a
    #add random lane numbers for each heat
    heat.hurdles.each do |hurdle|
      heat.heat_hurdles.each do |heat_hurdle|
        #if array is empty
        if(lanes.empty?)
          lanes = (1..MAX_HEAT_SIZE).to_a
        end

        #delete the number from the array and set num to it
        #add the lanes number to the current hurdle
        if(heat_hurdle.hurdle_id == hurdle.id)
          heat_hurdle.lane=lanes.delete(lanes.sample)
        end
      end
    end
  end

  def schedule_round(tour_date, round, hurdles, gen)
    #init local variables
    hurdles_for_heat=[];heat_full=0;heat_number=0

    #find optimal heat sizes for the number of participants
    sizes=heat_sizes(hurdles.count)

    hurdles.each do |racer|
      #add racer to heat array and increment heat_full
      hurdles_for_heat << racer;heat_full+=1

      #build a heat when enough racers are gathered
      if heat_full==sizes[heat_number]
        heat = tour_date["tour"].heats.build(time: tour_date["date"], gender: gen, round: round)
        heat.hurdles << hurdles_for_heat

        #allocate lanes for the new heat
        allocate_lanes(heat)
        #reset counting vars for the next heat
        hurdles_for_heat=[];tour_date["date"]+=HEAT_INTERVAL;heat_number+=1;heat_full=0
      end
    end

    #return date available for a new heat
    return tour_date
  end

  def schedule_heats_for_genders(tour_date)
    #create heats for the first day - no qualifications
    genders = ["m","f"]
    round = Heat.last.round + 1
    #find all male racers with no qualification
    genders.each do |gen|
      hurdles = Hurdle.where("round = ? AND gender = ?", round, gen)
      tour_date=schedule_round(tour_date, round, hurdles, gen)
    end

    return tour_date
  end

  def schedule_tournament_heats(tour)
    day = find_day_from_tour(tour.start_date)
    tour_date = Hash["tour"=>tour,"date"=>day]

    return schedule_heats_for_genders(tour_date)["tour"]
  end
end
