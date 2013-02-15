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
    css_class = column == sort_column(model) ? "current #{sort_direction}" : nil
    direction = column == sort_column(model) && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {sort: column, direction: direction}, {class: css_class}
  end

  def sort_column(model)
    model.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  def sport_type(model)
    if model.sport == "hurdles" 
      link_to "Add new hurldles racer", new_admin_hurdle_path(user_id: model.id)
    elsif model.sport == "wattball"
     link_to "Add new Team", new_admin_team_path(user_id: model.id)
    end
  end
end
