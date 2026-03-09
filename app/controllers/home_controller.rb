class HomeController < ApplicationController
def index
  @equipment = Equipment.by_name(params[:query]).order(:category_id)
end
end
