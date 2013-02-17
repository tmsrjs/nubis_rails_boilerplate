class Property < ActiveRecord::Base
  has_many :images, as: :viewable, order: :position, :dependent => :destroy
  belongs_to :neighborhood
  accepts_nested_attributes_for :images, allow_destroy: true
  attr_protected
  validates :neighborhood, presence: true
end  
