module TournamentsHelper
  HEAT_INTERVAL = 3600
  MAX_HEAT_SIZE = 8

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

  def gen_heats_from_hurdles(tour_date, round, hurdles, gen)
    #init local variables
    hurdles_for_heat=[];heat_full=0;heat_number=0

    #find optimal heat sizes for the number of participants
    sizes=heat_sizes(hurdles.count)

    hurdles.each do |racer|
      #add racer to heat array and increment heat_full
      hurdles_for_heat << racer;heat_full+=1
      #lanes = (1..8).to_a

      #build a heat when enough racers are gathered
      if heat_full==sizes[heat_number]
        heat = tour_date["tour"].heats.build(time: tour_date["date"], gender: gen, round: round, tournament_id: tour_date["tour"].id)
        heat.hurdles << hurdles_for_heat

        #add random lane numbers for each heat
        #heat.hurdles.each do |hurdle|
        #  HeatHurdle.find_by_heat_id_and_hurdle_id(heat, hurdle).lane = 
        #end

        #reset counting vars for the next heat
        hurdles_for_heat=[];tour_date["date"]+=HEAT_INTERVAL;heat_number+=1;heat_full=0
      end
    end

    #return date available for a new heat
    return tour_date
  end

  def auto_gen_heats_no_qual(tour_date)
    #create heats for the first day - no qualifications
    genders = ["m","f"];round=0
    #find all male racers with no qualification
    genders.each do |gen|
      hurdles_no_qual = Hurdle.where("qualification IS NULL AND gender = ?", gen)
      tour_date=gen_heats_from_hurdles(tour_date, round, hurdles_no_qual, gen)
      #tour = t_d[0]
      #date = t_d[1]
    end

    return tour_date
  end

  def auto_gen_heats(tour)
    tour_date = Hash["tour"=>tour,"date"=>tour.start_date]
    tour_date_day0 = auto_gen_heats_no_qual(tour_date)

    return tour_date_day0["tour"]
  end
end
