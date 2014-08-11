class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_logged_in, only: [:new, :create]
  before_action lambda{ restrict_permissions(@user.id) }, except: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
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
    gon.skills = LocationsSkillsUsers.where(user_id: params[:id]).pluck(:skill_id).sort
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_skill_ids] = params[:skill_ids] unless session[:user_is_admin?]
        LocationsSkillsUsers.create(@user.id, @user.location_id, params[:skill_ids]) if params[:skill_ids]

        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        session[:user_skill_ids] = params[:skill_ids] unless session[:user_is_admin?]
        LocationsSkillsUsers.update(@user.id, @user.location_id, params[:skill_ids]) if params[:skill_ids]

        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
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
      params.require(:user).permit(:location_id, :user_name, :email, :first_name, :last_name,
                                   :is_active, :is_available, :password, :password_confirmation)
    end

    #Users who are logged in do not need to create a new user, unless they are admins
    def redirect_if_logged_in
      if session[:user_id].present? && !session[:user_is_admin?]
        flash[:notice] = 'Already Logged in!'
        redirect_to root_path
      end
    end
end
