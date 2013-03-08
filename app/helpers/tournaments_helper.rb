module TournamentsHelper
  HEAT_INTERVAL = 3600  #every hour
  MAX_HEAT_SIZE = 8  #only 8 tracks available
  CUTTING_FACTOR = 2  #cut the loosers by half
  DAY = 86400

  #round the number to the MAX_HEAT_SIZE
  def round_up_to_heat(number)
    # already a factor
    return number if number % MAX_HEAT_SIZE == 0
    # go to nearest factor
    return number + MAX_HEAT_SIZE - (number % MAX_HEAT_SIZE)
  end

  def number_of_heats(divisor)
    #calculate number of heats necessary
    number = divisor / MAX_HEAT_SIZE
    if (divisor % MAX_HEAT_SIZE) !=0
      #if not divided evenly, add one
      number += 1
    end

    return number
  end

  #given number of participants in a round, calculate size of each heat
  def heat_sizes(divisor)
    sizes = []
    number = number_of_heats(divisor)
    #find number of lanes for most of the heats
    general = divisor / number

    #set number of participants of every lane to be general
    number.times do |i|
      sizes[i] = general
    end

    #if any racers are not in heats, add them to the last one
    rest = divisor - general*number; i=1
    while(rest > 0)
      sizes[number-i] += 1
      rest -= 1
      i += 1
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

  #returns an array representing the tournament
  #each element is a round of heats, which size is stored inside
  def find_round_sizes(number, no_qual)
    rounds = how_many_rounds(number)
    rounds[0] = heat_sizes(no_qual)

    return rounds
  end

  def find_heats_per_day(tour)
    start=tour.start_date;stop=tour.end_date
    day_dur=((stop - start).to_i%DAY)
    max_heats_per_day = day_dur / HEAT_INTERVAL #from 8am to 6pm

    return max_heats_per_day
  end

  def count_days(rounds,max_heats)
    days = 0

    rounds.each do |round|
      round_duration = 0
      if round.size >= max_heats
        round_duration /= max_heats
        if round_duration % max_heats > 0 then round_duration += 1 end
      end

      days+= 1 + round_duration
    end

    return days
  end

  #date spreading:
  #first determine if the time to the end of tournament is enough,
  #then spread the heats out as much as possible
  #incomplete
  def date_calculus(tour)
    start=tour.start_date;stop=tour.end_date
    tour_duration = stop.to_date - start.to_date

    rounds = find_round_sizes(106,20)
    max_heats_per_day = find_heats_per_day(tour)
    days_needed = count_days(rounds,max_heats_per_day)

    schedule = []
    if days_needed > tour_duration
      #extend the tournament, notify the staff
      tour_duration += (days_needed - tour_duration)
      #NOTIFY STAFF
    end
    #spread the heats out
    schedule[0] = start
    schedule[tour_duration] = 0#last round

    #look at each round, see if it requires more than one day
    #take another day for the round
    #make rounds into a hash of int[] and date
    rounds.each do |round|
      if round.size > max_heats_per_day
      end

    end

    return schedule
  end

  #need to develop lane allocation for winners
  def allocate_lanes(heat)
    heat=allocate_lanes_randomly(heat)

    return heat
  end

  def allocate_lanes_randomly(heat)
    lanes = (1..heat.heat_hurdles.size).to_a
    #add random lane numbers for each heat
    heat.heat_hurdles.each do |heat_hurdle|
      #delete the number from the array and set num to it
      #add the lanes number to the current hurdle
        heat_hurdle.lane=lanes.delete(lanes.sample)
    end

    #CRUDE WAY TO SAVE LANE, FIX LATER
    heat.save

    return heat
  end

  #populate a round with hurdles
  def populate_round(hurdles, round_size_array, heats)
    #init counting variables
    hurdles_for_heat=[];heat_full=0;heat_counter=0
#puts("round_size_array = "+round_size_array.to_s+"; N_hurdles="+hurdles.count.to_s)

    hurdles.each do |racer|
      #add racer to heat array and increment heat_full
      hurdles_for_heat << racer; heat_full+=1
      #build a heat when enough racers are gathered
      if heat_full==round_size_array[heat_counter]
        heats[heat_counter].hurdles << hurdles_for_heat

        #allocate lanes for the new heat
        heats[heat_counter] = allocate_lanes(heats[heat_counter])
#logger.debug "LANES return: "+heats[heat_counter].heat_hurdles[0].lane.to_s
        #reset counting vars for the next heat
        hurdles_for_heat=[];heat_full=0;heat_counter+=1
      end
    end

#logger.debug "round lane:"+heats[0].heat_hurdles[0].lane.to_s
    return heats
  end

  def generate_tournament(tour)
    raise TournamentNotEmpty if tour.heats.count > 0
    day = tour.start_date;genders = ["m","f"]

    genders.each do |gen|
      unisex_racers = Hurdle.where("gender = ?", gen)
      no_qual = unisex_racers.where("qualification = ?", Time.new(2000))
      rounds = find_round_sizes(unisex_racers.count, no_qual.count)

      i=0
      rounds.each do |round|
        round.each do |heat|
          tour.heats.build(time: day, gender: gen, round: i)
          day+=HEAT_INTERVAL
        end

        day+=1.day;i+=1
      end
    end

    return tour
  end
end
