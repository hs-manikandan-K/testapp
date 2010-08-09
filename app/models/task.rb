class Task < ActiveRecord::Base
  belongs_to :task_list
  named_scope :all_user_tasks,lambda {|user|
    task_list_ids = user.task_list_ids  
    {:conditions => ["tasks.task_list_id in(?)",task_list_ids]}
  }

  def validate
    if not due_date.blank? and due_date <= Time.now 
      errors.add_to_base("Due Date should be before current date time ") 
    end
  end
end
