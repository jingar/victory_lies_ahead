class Admin::MatchesController < Admin::AdminBaseController 
  def new
    @tournament = Tournament.find(1)
    @halfdays = (((@tournament.end_date - @tournament.start_date)/86400)*2).round
    @teams = Team.all
    @hour = populateDays(@tournament, @halfdays)
    @i = 1
    @matchArray = Array.new()
    while @i <= Team.count do
      @j = @i + 1
      while @j <= Team.count do
        @matchArray << [Team.find(@i).team_name, Team.find(@j).team_name]
        @j+= 1
      end
      @i += 1
    end
    @match = Match.new
  end

  def populateDays(tour, hdays)
    @hdays = hdays
    @tour = tour
    @first = tour.start_date
    if @first.hour >= 11 and @first.minute >= 1
      @start = DateTime.new(@first.year,@first.month,@first.day,15,00,00,'')
    else
      @start = DateTime.new(@first.year,@first.month,@first.day,11,00,00,'')
    end
    
  end

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
    params[:match][:user_id] = (Match.where(id: params[:id]).pluck(:user_id)).first
    if @match.update_attributes(params[:match])
      redirect_to [:admin,@match], notice: "Successfully entered match result!"
    else
      render action: 'edit'
    end
 end

end