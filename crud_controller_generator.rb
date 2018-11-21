puts "What is the name of your model? (lowcase plz)"
print "> "

model = gets.chomp()

Models = model.capitalize + "s"
Model = model.capitalize
models = model + "s"


template = "class #{Models}Controller < ApplicationController
  before_action :set_#{model}, only: [:show, :edit, :update, :destroy]

  def index
    @#{models} = {#Model}.all
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
    params.require(:#{model}).permit(:name, :address, :rating)
  end

  def set_#{model}
    @#{model} = #{Model}.find(params[:id])
  end
end"

puts "Copy this in app/controllers/#{models}_controller.rb"
puts "#####"
puts template
puts "#####"
