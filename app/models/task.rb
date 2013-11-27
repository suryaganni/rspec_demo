class Task < ActiveRecord::Base

  attr_accessible :user_id, :content, :name

  belongs_to :user

  #validates :user_id, :presence => true
  validates :name, :presence => true
  validates :content, :presence => true

end
