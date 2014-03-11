class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def result
    @sql = params[:search]
    @warning = ""
    @echoSQL = ""
    
    if @sql.downcase.include? "drop".downcase or @sql.downcase.include? "alter".downcase
      @warning = "don't drop tables!"
      @records_array = nil
    else
      @sql = "select name, phone_number from users where name=" + "'" + @sql + "';"
      begin 
        @records_array = ActiveRecord::Base.connection.execute(@sql)
      rescue Exception
        @echoSQL = @sql
        @warning = "Incorrect SQL found. Your statement was: "
      end
    end
  end

  def safe_result
    @name = params[:safe_search]
    # random prepared statement name
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    string = (0...50).map { o[rand(o.length)] }.join  
    # connect to your database
    connection = ActiveRecord::Base.connection.raw_connection
    # prepare that statement, creating a query to be run against  
    connection.prepare(string, "select name, phone_number FROM users WHERE name = $1")
    # add your name as a variable to your statement
    @records_array = connection.exec_prepared(string, [ @name ])
  end

  def sanitized_result
    @sql = params[:sanitized_search]

    @records_array = []

    # sanitize
    @sql = @sql.gsub("'","''")
    
    @sql = "select name, phone_number from users where name=" + "'" + @sql + "'" 
    @records_array = ActiveRecord::Base.connection.execute(@sql)
   

  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :phone_number, :ssn)
    end
end
