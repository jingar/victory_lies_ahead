<%= form_for ([:admin, @team]) do |f| %>
  <%= render 'shared/error_messages', entity: @team %>
  <p>
    <%= f.label :team_name %>
    <%= f.text_field :team_name %>
  </p>
  <%= f.fields_for :wattballs do |players| %>
    <p>
      <b></b> <br/>
      First Name: <%= players.text_field :first_name %>
      Last Name: <%= players.text_field :last_name %>
    </p>
  <% end %>
  <%= f.hidden_field :user_id, :value => params[:user_id] %>
  <%= link_to_add_player "Add Player", f, :wattballs %>
  <p><%= f.submit %></p>
<% end %>
