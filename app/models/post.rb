class Post < ActiveRecord::Base

  attr_accessible :name, :subject

  validates :name, :presence => true
  validates :subject, :presence => true

end
