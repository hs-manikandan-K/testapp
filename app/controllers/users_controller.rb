class UsersController < ApplicationController
  # GET /users
  # GET /users.xml

  before_filter :require_authorization,:except=>[:login,:verify_login,:logout]
  layout 'users',:except=>[:login]
  

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'Users was successfully created.'
        format.html { redirect_to(users_url) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Users was successfully updated.'
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def login  
    render "login"
  end
  
  def verify_login 
    reset_session
    if User.table_exists?
      if not params[:login].blank?
        if not params[:login][:email].blank? and not params[:login][:password].blank?
          user_email=params[:login][:email]
          password=params[:login][:password]
          @user = User.find(:first,:conditions=>["email=? and password=?",user_email,password])    
          if @user    
            session[:user_id]=@user.id   
            redirect_to users_path
          else
            flash[:notice]= 'Incorrect user name or password'
            redirect_to root_url
          end
        else
          flash[:notice]= 'Incorrect user name or password'
          redirect_to root_url
        end
      else
        flash[:notice]= 'You are not Authorized Person to login'
        redirect_to root_url
      end
    else
      flash[:notice]= 'Please run the rake db:migrate. Your login details are Username:admin@helios.com & password:helios'
      redirect_to root_url
    end
  end
  
  def logout 
    reset_session    
    flash[:notice]= 'Sucessfully Logged out'
    redirect_to :action=>"login"
  end 
  
  def change_password
    @user = User.find(session[:user_id])    
  end
  
  def changing_new_password
    user_id=params[:user][:email]
    @user = User.find_by_email(user_id)
    if @user.id == session[:user_id] and (params[:user][:old_password]).downcase==@user.password.downcase
      if @user.update_attributes(params[:user]) and @user.update_attributes(:email=>params[:user][:email].strip)          
        flash[:notice] = 'Your Password has been changed'
        render :action=>"change_password"
      else
        flash[:notice] = 'sorry password is not matched'
        render :action=>"change_password"
      end
    else
      flash[:notice] = 'sorry password is not matched'
      render :action=>"change_password"  
    end
  end  
  
  def tasks
    @user=User.find(session[:user_id])
    @tasks = Task.all_user_tasks(@user)
    render :template=>"tasks/index"
  end
end
