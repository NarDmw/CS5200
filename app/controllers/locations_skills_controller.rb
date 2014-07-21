class LocationsSkillsController < ApplicationController
  before_action :set_locations_skill, only: [:show, :edit, :update, :destroy]

  # GET /locations_skills
  # GET /locations_skills.json
  def index
    @locations_skills = LocationsSkill.all
  end

  # GET /locations_skills/1
  # GET /locations_skills/1.json
  def show
  end

  # GET /locations_skills/new
  def new
    @locations_skill = LocationsSkill.new
  end

  # GET /locations_skills/1/edit
  def edit
  end

  # POST /locations_skills
  # POST /locations_skills.json
  def create
    @locations_skill = LocationsSkill.new(locations_skill_params)

    respond_to do |format|
      if @locations_skill.save
        format.html { redirect_to @locations_skill, notice: 'Locations skill was successfully created.' }
        format.json { render :show, status: :created, location: @locations_skill }
      else
        format.html { render :new }
        format.json { render json: @locations_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations_skills/1
  # PATCH/PUT /locations_skills/1.json
  def update
    respond_to do |format|
      if @locations_skill.update(locations_skill_params)
        format.html { redirect_to @locations_skill, notice: 'Locations skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @locations_skill }
      else
        format.html { render :edit }
        format.json { render json: @locations_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations_skills/1
  # DELETE /locations_skills/1.json
  def destroy
    @locations_skill.destroy
    respond_to do |format|
      format.html { redirect_to locations_skills_url, notice: 'Locations skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_locations_skill
      @locations_skill = LocationsSkill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def locations_skill_params
      params.require(:locations_skill).permit(:location_id, :skill_id, :user_id)
    end
end
