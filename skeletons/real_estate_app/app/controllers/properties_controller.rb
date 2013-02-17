class PropertiesController < ApplicationController
  def index
    @properties = Property.order('created_at desc').all
  end
  
  def show
    @property = Property.find(params[:id])
  end
end
