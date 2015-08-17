require 'date'

class TodosController < ApplicationController
  before_action :set_user
  before_action :set_todo, only: [:show, :update, :complete]
  before_action :set_due_date, only: [:index, :show, :update, :create]

  def set_user
    @user=User.find(params[:user_id])
    render plain: "User(#{param[:user_id]}) not found", :status => :not_found if @user.nil?
  end

  # Retrieve the todo items for a given user
  def index
    render json: Todo.where(user_id: @user.id)
  end

  # Mark a todo item as complete
  def complete
    if @todo
      @todo.complete!
      render json: @todo
    end
  end
  
  # Retrieve the incomplete todo items for a given user
  def incomplete
    render json: @user.todos.incomplete if @todo.nil?
  end
 
  def show
    render json: @todo
  end

  # Create a new todo item for a given user with a due date
  def create
    render json: @user.todos.create!(due_date: @due_date)
  end

  def update
    @todo.update_attributes(due_date: @due_date) if @todo
    render json: @todo
  end

  protected
    def set_due_date
      if params[:year].present? && params[:month].present? && params[:day].present?
        @due_date=Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      end
      
      if @due_date && @due_date < Date.today
        render plain: "Task expired in the past: #{@due_date}", :status => :internal_server_error
      end
    end
  
    def set_todo
      @todo = Todo.find(params[:id].to_i) if params[:id].present?
      
      if @todo.nil?
        render plain: "Todo(#{params[:id]}) not found", :status => :not_found
      end
    end
end