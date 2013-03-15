class Admin::MatchesController < Admin::AdminBaseController
 include ActiveModel::MassAssignmentSecurity

  attr_accessible :awayGoals, :awayTeam, :homeGoals, :homeTeam, :pitch, :umpire, :when

require 'rrschedule'

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
    
    @teams = Team.all(:select => "team_name")
    
    #creating the array of teams to be used for automatic scheduling
    array = Array.new
	@teams.each do |t|
		array.push t.team_name
	end

  @schedule=RRSchedule::Schedule.new(
  #array of teams that will compete against each other. If you group teams into multiple flights (divisions),
  #a separate round-robin is generated in each of them but the "physical constraints" are shared
  :teams => [array],

  #Setup some scheduling rules
  :rules => [
    RRSchedule::Rule.new(:wday => 0, :gt => ["12:00PM", "7:45PM"], :ps => ["1", "2", "3", "4", "5", "6", "7", "8"]),
    RRSchedule::Rule.new(:wday => 1, :gt => ["12:00PM", "7:45PM"], :ps => ["1", "2", "3", "4", "5", "6", "7", "8"]),
    RRSchedule::Rule.new(:wday => 2, :gt => ["12:00PM", "7:45PM"], :ps => ["1", "2", "3", "4", "5", "6", "7", "8"]),
    RRSchedule::Rule.new(:wday => 3, :gt => ["12:00PM", "7:45PM"], :ps => ["1", "2", "3", "4", "5", "6", "7", "8"]),
    RRSchedule::Rule.new(:wday => 4, :gt => ["12:00PM", "7:45PM"], :ps => ["1", "2", "3", "4", "5", "6", "7", "8"]),
    RRSchedule::Rule.new(:wday => 5, :gt => ["15:00PM"], :ps => ["1", "2", "3", "4", "5", "6", "7", "8"]),
    RRSchedule::Rule.new(:wday => 6, :gt => ["1:00PM"], :ps => ["1", "2", "3", "4", "5", "6", "7", "8"]),
  ],

  #First games are played on...
  :start_date => Date.parse("2013/3/13"),

  #array of dates to exclude
  :exclude_dates => [Date.parse("2013/3/14"),Date.parse("2013/3/15")],

  #Number of times each team must play against each other (default is 1)
  :cycles => 1,

  #Shuffle team order before each cycle. Default is true
  :shuffle => true
  )
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matches }
    end
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
    @match = Match.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @match }
    end
  end

  # GET /matches/new
  # GET /matches/new.json
  def new
    @match = Match.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @match }
    end
  end

  # GET /matches/1/edit
  def edit
    @match = Match.find(params[:id])
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(params[:match])

    respond_to do |format|
      if @match.save
        format.html { redirect_to [:admin,@match], notice: 'Match was successfully created.' }
        format.json { render json: [:admin,@match], status: :created, location: [:admin,@match] }
      else
        format.html { render action: "new" }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /matches/1
  # PUT /matches/1.json
  def update
    @match = Match.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to [:admin,@match], notice: 'Match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    respond_to do |format|
      format.html { redirect_to admin_matches_url }
      format.json { head :no_content }
    end
  end
  
  def generate
  @schedule=RRSchedule::Schedule.new(
  #array of teams that will compete against each other. If you group teams into multiple flights (divisions),
  #a separate round-robin is generated in each of them but the "physical constraints" are shared
  :teams => [
    %w(A1 A2 A3 A4 A5 A6 A7 A8),
    %w(B1 B2 B3 B4 B5 B6 B7 B8)
  ],

  #Setup some scheduling rules
  :rules => [
    RRSchedule::Rule.new(:wday => 3, :gt => ["10:00AM","3:00PM"], :ps => ["1", "2", "3", "4", "5", "6", "7", "8"]),
    RRSchedule::Rule.new(:wday => 5, :gt => ["10:00AM"], :ps => ["1"])
  ],

  #First games are played on...
  :start_date => Date.parse("2013/10/13"),

  #array of dates to exclude
  :exclude_dates => [Date.parse("2013/10/14"),Date.parse("2013/10/15")],

  #Number of times each team must play against each other (default is 1)
  :cycles => 1,

  #Shuffle team order before each cycle. Default is true
  :shuffle => true
  )
  @schedule.generate
  puts @schedule.to_s
  @schedule.gamedays.each do |gd|
  puts "Date: "
  puts gd.date.strftime("%Y/%m/%d")
  puts "\n"
  gd.games.each do |g|
    puts g.team_a.to_s + " Vs " + g.team_b.to_s + " Pitch: #{g.playing_surface} KickOff: #{g.game_time.strftime("%I:%M %p")}"     
  end
  puts "\n"
end
end
end
