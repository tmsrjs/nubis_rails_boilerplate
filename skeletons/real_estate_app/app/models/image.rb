class Image < ActiveRecord::Base
  attr_accessible :file, :position
  has_attached_file :file, styles: {small: '240x240>', large: '600x600>'}
  validates_attachment :file, presence: true,
    content_type: { content_type: ['image/jpg', 'image/png', 'image/gif', 'image/jpeg'] }
  belongs_to :viewable, :polymorphic => true
end
