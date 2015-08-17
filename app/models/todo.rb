class Todo < ActiveRecord::Base
  include Workflow
  belongs_to :user
  
  scope :incomplete, ->{ where('workflow_state <> ?',:completed)}
  
  workflow do
    state :started do
      event :complete, :transitions_to => :completed  
    end
    
    state :completed
  end
end
