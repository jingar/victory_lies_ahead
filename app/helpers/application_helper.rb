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
end
