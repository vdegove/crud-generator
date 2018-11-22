puts "What is the name of your model? (lowcase plz)"
print "> "
model = gets.chomp()

puts "What are the fields you want your users to edit?
Write them in symbols with comas like ':name, :address, :rating'"
print "> "
authorized_fields = gets.chomp()

first_field = authorized_fields.split(",")[0][1..-1]

Models = model.capitalize + "s"
Model = model.capitalize
models = model + "s"


controller_template = "class #{Models}Controller < ApplicationController
  before_action :set_#{model}, only: [:show, :edit, :update, :destroy]

  def index
    @#{models} = #{Model}.all
  end

  def show
  end

  def new
    @#{model} = #{Model}.new
  end

  def create
    #{Model}.create(#{model}_params)
    redirect_to #{models}_path
  end

  def edit
  end

  def update
    @#{model}.update(#{model}_params)
    redirect_to #{model}_path(@#{model})
  end

  def destroy
    @#{model}.destroy
    redirect_to #{models}_path
  end

  private

  def #{model}_params
    params.require(:#{model}).permit(#{authorized_fields})
  end

  def set_#{model}
    @#{model} = #{Model}.find(params[:id])
  end
end"


index_template = "<h1>#{Models}</h1>

<ul>

<% @#{models}.each do |#{model}| %>

<li><%= link_to(#{model}.#{first_field}, #{model}_path(#{model})) %></li>

<% end %>

</ul>

<%= link_to 'Add a new #{model}', new_#{model}_path %>"

new_template = "<h1>Add a new #{model}</h1>

<%= simple_form_for @#{model} do |f| %>
<%= f.input :#{first_field} %>
<%= f.submit %>
<% end %>"

show_template = "<h1><%= @#{model}.name %></h1>

  <ul>
    <li>#{first_field.upcase}: <%= @#{model}.#{first_field} %></li>
  </ul>
  <%= link_to('Back to #{model} list', #{models}_path) %>"

puts "1. Add `ressources :#{models}, only: [:index, :new, :create, :show, :edit, :update, :detroy]`
in your routes.rb file (just delete the actions you won't use)"
puts "2. Copy this in app/controllers/#{models}_controller.rb"
puts "#####"
puts controller_template
puts "#####"
puts "3. Copy this in app/views/#{models}/index.html.erb"
puts "#####"
puts index_template
puts "#####"
puts "4. Copy this in app/views/#{models}/show.html.erb"
puts "#####"
puts show_template
puts "#####"
puts "4. Copy this in app/views/#{models}/new.html.erb"
puts "#####"
puts new_template
puts "#####"
