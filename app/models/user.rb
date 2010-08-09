class User < ActiveRecord::Base
  has_many :task_lists
  
  validates_presence_of(:first_name, :message=>"should not be blank")
 
  attr_accessor :password_confirmation,:old_password
  validates_confirmation_of  :password,
    :message=>"is  not matched with Confirm Password ",:on => :create
  validates_uniqueness_of :email
  validates_format_of :email, :with=>/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message=>"is not valid" , :on => :create

  def full_name
    "#{self.first_name} #{self.last_name}"
  end 

end
