class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :update_status]
  
  # GET /todos
  def index
    @todos = Todo.all
    @todo = Todo.new
  end
  
  # GET /todos/1
  def show
  end
  
  # GET /todos/new
  def new
    @todo = Todo.new
  end
  
  # GET /todos/1/edit
  def edit
  end
  
  # POST /todos
  def create
    @todo = Todo.new(todo_params)
    # Set default status if not provided
    @todo.status = "not_started" unless params[:todo][:status].present?
    
    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
        format.js
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
  
  # PATCH/PUT /todos/1
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to todos_path, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
  
  # DELETE /todos/1
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_path, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end
  
  # PATCH /todos/1/update_status
  def update_status
    new_status = params[:status]
    if @todo.update(status: new_status)
      redirect_to todos_path, notice: 'Todo status was successfully updated.'
    else
      redirect_to todos_path, alert: 'Error updating todo status.'
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:title, :description, :status, :due_date, :priority)
    end
end