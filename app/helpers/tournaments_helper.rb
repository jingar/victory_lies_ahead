module TournamentsHelper
  HEAT_INTERVAL = 3600  #every hour
  MAX_HEAT_SIZE = 8  #only 8 tracks available
  CUTTING_FACTOR = 2  #cut the loosers by half

  #round the number to the MAX_HEAT_SIZE
  def round_up_to_heat(number)
    # already a factor
    return number if number % MAX_HEAT_SIZE == 0
    # go to nearest factor
    return number + MAX_HEAT_SIZE - (number % MAX_HEAT_SIZE)
  end

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
      sizes[number-1] = rest 
    end

    return sizes
  end

  def how_many_rounds(divisor)
    #init for vars, i starts at 1, since round 0 is non-standard
    rounds = []; i = 1
    #dummy condition, doesn't actually work due to the fact that 4+4=8
    while divisor >= MAX_HEAT_SIZE
      #populate with array of heat sizes
      rounds[i] = heat_sizes(divisor)

      #the true break, after the last round size has been set
      if divisor == MAX_HEAT_SIZE then break end

      #cut the participants by half
      divisor/=CUTTING_FACTOR

      divisor = round_up_to_heat(divisor)

      i+=1
    end

    return rounds
  end


  def find_round_sizes(number, no_qual)
    rounds = how_many_rounds(number)
    rounds[0] = heat_sizes(no_qual)

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

  #populate a round with hurdles
  def populate_round(tour_date, hurdles, round)
    #init local variables
    hurdles_for_heat=[];heat_full=0;heat_counter=0

    #find optimal heat sizes for the number of participants
    sizes=heat_sizes(hurdles.count)

    hurdles.each do |racer|
      #add racer to heat array and increment heat_full
      hurdles_for_heat << racer;heat_full+=1

      #build a heat when enough racers are gathered
      if heat_full==sizes[heat_number]
        heats[heat_counter].hurdles << hurdlerounroundt

        #allocate lanes for the new heat
        allocate_lanes(heats[heat_counter])
        #reset counting vars for the next heat
        hurdles_for_heat=[];heat_full=0,heat_counter+=1
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
      rounds = find_round_sizes(hurdles.count)

      raise "RoundException" if hurdles==[]
      tour_date=populate_round(tour_date, rounds[round], hurdles, gen) if Heat.count>0
    end

    return tour_date
  end

  def populate_tournament(tour)
    tour_date = Hash["tour"=>tour,"date"=>day]
    tour_date = schedule_heats_for_genders(tour_date)
    
    
    
    return tour
  end

  def generate_tournament(tour)
    raise "TournamentNotEmptyException" if tour.heats.count > 0
    day = tour.start_date;genders = ["m","f"]
    no_qual = Hurdle.where("qualification = ?", Time.new(2000))
    rounds = find_round_sizes(Hurdle.count, no_qual)

    rounds.times do |round|
      genders.each do |gen|
        tour.heats.build(time: day, gender: gen, round: round)
        day+=HEAT_INTERVAL;
      end
      day+=1.day
    end

    return tour
  end
end
