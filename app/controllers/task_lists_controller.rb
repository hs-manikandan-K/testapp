class TaskListsController < ApplicationController
  before_filter :get_user
  layout 'users'
  # GET /task_lists
  # GET /task_lists.xml
  def index
    @task_lists = @user.task_lists.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @task_lists }
    end
  end

  # GET /task_lists/1
  # GET /task_lists/1.xml
  def show
    @task_list = @user.task_lists.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task_list }
    end
  end

  # GET /task_lists/new
  # GET /task_lists/new.xml
  def new
    @task_list = @user.task_lists.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task_list }
    end
  end

  # GET /task_lists/1/edit
  def edit
    @task_list = @user.task_lists.find(params[:id])
  end

  # POST /task_lists
  # POST /task_lists.xml
  def create
    @task_list = @user.task_lists.new(params[:task_list])

    respond_to do |format|
      if @task_list.save
        flash[:notice] = 'TaskList was successfully created.'
        format.html { redirect_to(@task_list) }
        format.xml  { render :xml => @task_list, :status => :created, :location => @task_list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /task_lists/1
  # PUT /task_lists/1.xml
  def update
    @task_list = @user.task_lists.find(params[:id])

    respond_to do |format|
      if @task_list.update_attributes(params[:task_list])
        flash[:notice] = 'TaskList was successfully updated.'
        format.html { redirect_to(@task_list) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /task_lists/1
  # DELETE /task_lists/1.xml
  def destroy
    @task_list = @user.task_lists.find(params[:id])
    @task_list.destroy

    respond_to do |format|
      format.html { redirect_to(task_lists_url) }
      format.xml  { head :ok }
    end
  end
end
