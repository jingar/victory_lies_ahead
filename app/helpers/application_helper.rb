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
  		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    		render(association.to_s.singularize + "_fields", :f => builder)
  		end
  	link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
	end
end
