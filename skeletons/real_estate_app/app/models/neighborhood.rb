class Neighborhood < ActiveRecord::Base
  has_many :images, as: :viewable, order: :position, :dependent => :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  attr_protected
  has_many :properties
end  
