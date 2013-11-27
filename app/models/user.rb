class User < ActiveRecord::Base

  attr_accessible :email, :name, :tasks_attributes

  has_many :tasks

  accepts_nested_attributes_for :tasks, allow_destroy: true
  #validates_associated :tasks

  validates :name, :presence => true
  validates :email, :presence => true

  validate :tasks_presence

  def tasks_presence
    if tasks.blank? or tasks.all? {|child| child.marked_for_destruction? }
      errors.add(:base, 'Must have at least one child')
    end
  end

end
