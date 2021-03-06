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
    if divisor == 0 then return 0 end
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

#  def find_heats_per_day(start,stop)
#    day_dur=((stop - start).to_i%DAY)
#    max_heats_per_day = day_dur / HEAT_INTERVAL #from 8am to 6pm
#
#    return max_heats_per_day
#  end

#  def count_days(rounds,max_heats)
#    days = 0
#
#    rounds.each do |round|
#      round_duration = 0
#      if round.size >= max_heats
#        round_duration /= max_heats
#        if round_duration % max_heats > 0 then round_duration += 1 end
#      end
#
#      days+= 1 + round_duration
#    end
#
#    return days
#  end

  #date spreading:
  def date_calc(start,day_start,day_duration,round)
    time=start;schedule=[]
    round.size.times do |r|
#print day_start+day_duration;print "\n"
      if time >= day_start + day_duration
#print time;print "\n"
        time=day_start+1.day
        day_start = time
      end
      schedule[r] = time
      time+=HEAT_INTERVAL
    end

    return schedule
  end

  #need to develop lane allocation for winners
  def allocate_lanes(heat,round)
    if round < 1
     heat=allocate_lanes_randomly(heat)
    else
      heat=allocate_lanes_in_order(heat)
    end

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

  def allocate_lanes_in_order(heat)
    lanes = [4,5,3,6,2,7,1,8]
    h_hs = heat.heat_hurdles
    h_hs.sort! { |a,b| a.finish_time <=> b.finish_time }
    h_hs.each do |h_h|
      h_h.lane = lanes.delete_at(0)
    end

    heat.save
    return heat
  end

  #populate a round with hurdles
  def populate_round(hurdles, round_size_array, heats)
    #init counting variables
    hurdles_for_heat=[];heat_full=0;heat_counter=0;i=0
#puts("round_size_array = "+round_size_array.to_s+"; N_hurdles="+hurdles.count.to_s)

    round_size_array.size.times do
      round_size_array[heat_counter].times do
        #add racer to heat array and increment heat_full
        hurdles_for_heat << hurdles[i]; heat_full+=1; i+=1
        #build a heat when enough racers are gathered
        if heat_full==round_size_array[heat_counter]
          heats[heat_counter].hurdles << hurdles_for_heat

          #allocate lanes for the new heat
          heats[heat_counter] = allocate_lanes(heats[heat_counter],hurdles.first.round)
#lo  gger.debug "LANES return: "+heats[heat_counter].heat_hurdles[0].lane.to_s
          #reset counting vars for the next heat
          hurdles_for_heat=[];heat_full=0;heat_counter+=1
        end
      end
    end

#logger.debug "round lane:"+heats[0].heat_hurdles[0].lane.to_s
    return heats
  end

  def populate_tournament(tour)
    genders = ["m","f"];heats=[];

    genders.each do |gen|
      #find the last played heat -> round, if none - assume round 0
      last_heat=Heat.where("played=? and gender=?",true,gen).order(:updated_at).last
      round = if last_heat == nil then 0 else last_heat.round + 1 end

      heats = tour.heats.where("round=? AND gender = ?",round,gen)
      raise NoHeats if heats==[]

      #find all racers for this round, raise exception, if none
      hurdles = Hurdle.where("round = ? AND gender = ?",round,gen)
      raise NoHurdles if hurdles==[]
      hurdles = hurdles.sort_by { |h| if h.heat_hurdles == [] then h.qualification else h.heat_hurdles.last.finish_time end }

      #COMMENT TO DEBUG
      raise RoundNotEmpty if Heat.where("round=? and gender=?",round,gen)[0].hurdles !=[]

      #calculate round size
      unisex_racers = Hurdle.where("gender = ?", gen)
      no_qual = unisex_racers.where("round = ?", 0)
      rounds = find_round_sizes(unisex_racers.count, no_qual.count)

      #do nothing, if at the end of the tournament
      if rounds[round]==nil
        flash[:failure] = "Tournament is finished."
        return
      end

      heats=populate_round(hurdles, rounds[round], heats)
    end

    return tour
  end

  def generate_tournament(tour)
    raise TournamentNotEmpty if tour.heats.count >0

    schedule=[]
    start = tour.start_date;stop = tour.end_date;genders =["m","f"]
    morn = start.hour.hours+start.min.minutes
    day_duration = ((stop-start)-(stop.to_date-start.to_date).days).to_i
    rounds=[]
    genders.size.times do |g|
      racers = Hurdle.where("gender = ?",genders[g])
      no_qual = racers.where("qualification=?",Time.new(2000))
      rounds[g] = find_round_sizes(racers.count,no_qual.count)
    end

    round = if rounds[0].size>=rounds[1].size then rounds[0] else rounds[1] end
    round.size.times do |r|
      genders.size.times do |g|
        if rounds[g][r] != nil
          schedule[r]=[];day_start = start.beginning_of_day + morn
#print day_start;print " CURRENT\n"
          schedule[r][g] = date_calc(start,day_start,day_duration,rounds[g][r])
          stop=schedule[r][g].last;start = stop + HEAT_INTERVAL

          schedule[r][g].each do |time|
            tour.heats.build(time: time, gender: genders[g], round: r)
          end
        end
      end
#print schedule.last.last.last;print "\n"
      stop=schedule.last.last.last;start = (stop + 1.day).beginning_of_day + morn
    end

    return tour
    
  end

  def set_heat_results(tour)
    last_heat=Heat.rounded_heats.where("played=?",true).last
    round = if last_heat == nil then 0 else last_heat.round + 1 end
    heats= tour.heats.where("round=?",round);i=1.seconds
    heats.each do |heat|
      if heat == heats.last then break end
      heat.hurdles.each do |hurdle|
        HeatHurdle.find_by_heat_id_and_hurdle_id(heat,hurdle).finish_time = i;i+=1
      end
    end
    return tour
  end
end
