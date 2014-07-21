class SkillsUsersController < ApplicationController
  before_action :set_skills_user, only: [:show, :edit, :update, :destroy]

  # GET /skills_users
  # GET /skills_users.json
  def index
    @skills_users = SkillsUser.all
  end

  # GET /skills_users/1
  # GET /skills_users/1.json
  def show
  end

  # GET /skills_users/new
  def new
    @skills_user = SkillsUser.new
  end

  # GET /skills_users/1/edit
  def edit
  end

  # POST /skills_users
  # POST /skills_users.json
  def create
    @skills_user = SkillsUser.new(skills_user_params)

    respond_to do |format|
      if @skills_user.save
        format.html { redirect_to @skills_user, notice: 'Skills user was successfully created.' }
        format.json { render :show, status: :created, location: @skills_user }
      else
        format.html { render :new }
        format.json { render json: @skills_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skills_users/1
  # PATCH/PUT /skills_users/1.json
  def update
    respond_to do |format|
      if @skills_user.update(skills_user_params)
        format.html { redirect_to @skills_user, notice: 'Skills user was successfully updated.' }
        format.json { render :show, status: :ok, location: @skills_user }
      else
        format.html { render :edit }
        format.json { render json: @skills_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skills_users/1
  # DELETE /skills_users/1.json
  def destroy
    @skills_user.destroy
    respond_to do |format|
      format.html { redirect_to skills_users_url, notice: 'Skills user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skills_user
      @skills_user = SkillsUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skills_user_params
      params.require(:skills_user).permit(:skill_id, :user_id, :proficiency_level)
    end
end
