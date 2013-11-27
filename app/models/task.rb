class Task < ActiveRecord::Base

  attr_accessible :user_id, :content, :name

  belongs_to :user

  #validates :user_id, :presence => true
  validates :name, :presence => true
  validates :content, :presence => true

  before_save :check_user_existence
  before_destroy :valid_if_user_task

  def check_user_existence
    if self.user_id.blank?
      self.errors.add(:base, 'User should not be blank')
      return false
    end
  end

  def valid_if_user_task
    if !self.marked_for_destruction?
      self.errors.add(:base, 'You cannot delete this task')
      return false
    end
  end

end
