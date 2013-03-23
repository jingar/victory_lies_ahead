module ApplicationHelper
  def full_title(page_title)
		base_title = "Heriot-Watt Sports Tournament"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

  def link_to_add_player(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    player = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_player(this, \"#{association}\", \"#{escape_javascript(player)}\")")
  end
  
  def link_to_remove_player(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_player(this)")
  end
  
  def sortable(column,model,title = nil)
    title ||= column.titleize
    direction = column == sort_column(model) && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {sort: column, direction: direction}
  end

  def sort_column(model)
    model.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sortable_matches(column,model,title = nil)
    title ||= column.titleize
    direction = column == sort_column_matches(model) && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {sort: column, direction: direction}
  end

  def sort_column_matches(model)
    model.column_names.include?(params[:sort]) ? params[:sort] : "points"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
  def sport_type(model)
    if model.sport == "hurdles" 
      link_to "Add new hurldles racer", new_admin_hurdle_path(user_id: model.id)
    elsif model.sport == "wattball"
     link_to "Add new Team", new_admin_team_path(user_id: model.id)
    end
  end

  def generate_ticket_id()
    id = Digest::SHA1.hexdigest("#{Time.now.to_f}#{rand}")
    id[0..5]
  end
  
  def calculate_adult_tickets(order_id)
      Ticket.where(order_id: order_id).sum(:adult_tickets_bought)
  end

  def calculate_concession_tickets(order_id)
      Ticket.where(order_id: order_id).sum(:concession_tickets_bought)
  end

  def total_adult_tickets()
    Ticket.sum(:adult_tickets_bought)
  end
  
  def total_concession_tickets()
    Ticket.sum(:concession_tickets_bought)
  end

  def calculate_total_cost(adult_price,concession_price,order_id)
    (calculate_adult_tickets(order_id) * adult_price) + (calculate_concession_tickets(order_id) * concession_price)
  end
  
  def unique_dates()
    all_times = Match.find(:all)
    all_times = all_times.map { |x| x.when }
    only_valid_times = all_times.reject{|x| x < Date.today }
    #only_unique_and_valid_times  = (only_valid_times.uniq_by { |x|  x.to_date }).map { | z | z }
    only_unique_and_valid_times = (only_valid_times.uniq_by { |x|  x.to_date }).map { | z | z.strftime("%d-%B-%Y")}
  end
  
  def free_tickets_today(user_id)
    User.find(user_id).sport == "wattball"
    t_name = Team.find_by_user_id(user_id)
    if t_name
      t_id = Team.find_by_user_id(user_id).id
      if t_id
        a = Match.find(:all, conditions:["homeTeam = ? OR awayTeam = ?",t_id,t_id])
        t_dates = a.map{ |x| x.when.to_date }
        ##add here to simulate later dates
        valid_times = t_dates.reject { |x| x != Date.today}.any?
      end
    end
  end

  def find_players(match_ids)
    a = Wattball.find_by_team_id(Match.find(match_ids).homeTeam)
  end

  def is_sent?(email)
    Ticket.where("email = ? and ticket_type = ? and ticket_date = ?",email,"free",Date.today).any?
  end
end


