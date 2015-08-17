class User < ActiveRecord::Base
  has_many :todos, :dependent => :destroy
  
  def complete_all!
    @todos.each do |todo|
      todo.complete!
    end
    
    @todos.save!
  end
end
