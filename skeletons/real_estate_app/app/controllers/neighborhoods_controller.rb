class NeighborhoodsController < ApplicationController
  def index
    @neighborhoods = Neighborhood.order('created_at desc').all
  end
  
  def show
    @neighborhood = Neighborhood.find(params[:id])
  end
end
