class Admin::MatchesController < Admin::AdminBaseController 
  def new
    @tournament = Tournament.find(1)
    @matches = Match.all
    @teams = Team.all
    @umpires = Umpire.all
    if not @matches.length == 0
      redirect_to admin_matches_url, notice: "Schedule already exists!"
    else
      matchDates = populateDays(@tournament).shuffle
      i = 1
      matchArray = Array.new()
      while i <= Team.maximum('id') do
        j = i + 1
        while j <= Team.maximum('id') do
          if Team.exists?(i) and Team.exists?(j)
            matchArray << [Team.find(i).id, Team.find(j).id]
          end
          j+= 1
        end
        i += 1
      end
      @matchArray = Array.new()
      matchArray = matchArray.shuffle
      r = rand(matchDates.length)
      Match.destroy_all
      matchArray.each do |match|
        while not validateAvaliable(match[0], match[1], @matchArray,matchDates[r]) and not matchDates[r][1] >= 7
          r = rand(matchDates.length)
        end
        matchDates[r][1] += 1
        @matchArray<<(match << matchDates[r][0]<<matchDates[r][1])
      end

      if not @matchArray.length == matchArray.length
        redirect_to admin_matches_url, notice: "Not enough Timeslots/Pitches to schedule all games "  + 9785.chr(Encoding::UTF_8)
      else
        @matchUmpArray = Array.new()
        matchArray.each do |match|
          @umpires = @umpires.shuffle
          umped = false
          @umpires.each do |umpire|
            if umped == false and validateUmpAvail(umpire, match, @matchUmpArray)
              @matchUmpArray << (match << umpire.id)
              umped = true
            end
          end
        end
        if @matchArray.length == @matchUmpArray.length
          @matchArray = @matchUmpArray
          matchArray.each do |match|
            enterMatch = Match.create()
            enterMatch.homeTeam = match[0]
            enterMatch.awayTeam = match[1]
            enterMatch.when = match[2]
            enterMatch.pitch = match[3]
            enterMatch.umpire = match[4]
            enterMatch.save
          end
        redirect_to admin_matches_url, notice: "Successfully generated schedule!"
        else
          redirect_to admin_matches_url, notice: "Not enough Umpires to schedule all games "  + 9785.chr(Encoding::UTF_8)
        end
      end  
    end
  end

  def populateDays(tour)
    @tour = tour
    @first = tour.start_date
    if @first.hour >= 11 and @first.minute >= 1
      @start = DateTime.new(@first.year,@first.month,@first.day,15,00,00,'')
    else
      @start = DateTime.new(@first.year,@first.month,@first.day,11,00,00,'')
    end
    i = 0
    dateArray = Array.new()
    lastDate = @start
    dateArray << [@start, 0]

    while lastDate < tour.end_date do
      if lastDate.hour == 11 and (lastDate + 4.hour)< tour.end_date
        lastDate = lastDate + 4.hour
        dateArray << [lastDate, 0]
      elsif lastDate.hour == 15 and (lastDate + 20.hour)< tour.end_date
        lastDate = lastDate + 20.hour
        dateArray << [lastDate, 0]
      else (lastDate.hour == 15 and (lastDate + 20.hour)>= tour.end_date) or (lastDate.hour == 11 and (lastDate + 4.hour)>= tour.end_date)
        lastDate = tour.end_date
      end
      i += 1
    end
    return dateArray
  end

#########################
  def validateAvaliable(p1, p2, m, d)
    free = true
    playing1 = p1
    playing2 = p2
    matches = m
    date = d
    matches.each do |match|
      if match[2]==date[0] and ((playing1 == match[0] or playing1 == match[1]) or (playing2 == match[0] or playing2 == match[1]))
        free = false
      end
    end
    return free
  end
#########################
  def validateUmpAvail(u, ma, mu)
    umpire = u
    match = ma
    matches = mu
    free = true
    matches.each do |current|
      if current[2] == match[2] and current[4] == umpire.id
        free = false
      end
    end
    return free
  end
#########################

  def show
    @match = Match.find(params[:id])
  end
  
  def index
    @matches = Match.all
  end
    
  def create
    @match = Match.new(params[:match])
    if @match.save
      redirect_to admin_matches_url, notice: "Match is now created!"
    else
      render 'new'
    end
  end
  
  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to admin_matches_url, :notice => "Successfully deleted match!"
  end

 def edit
    @match = Match.find(params[:id])
 end
 
 def update
    @match = Match.find(params[:id])
    if @match.update_attributes(params[:match])
      flash[:success] = "Match result updated"
      redirect_to  [:admin,@match]
    else
      render 'edit'
    end
  end

end
