class PostingsController < ApplicationController
  before_action :set_posting, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in

  # GET /postings
  # GET /postings.json
  def index
    @view_hashes = {}
    @view_hashes[:skills] = hash_id_to_s(Skill.all)

    #TODO ajax the loading
    if session[:user_is_admin?]
      @view_hashes[:location_name] = 'All'
      @view_hashes[:locations] = hash_id_to_s(Location.all)
      @view_hashes[:users] = hash_id_to_s(User.all)
      @postings = Posting.all
    else
      @view_hashes[:location_name] = Location.find(session[:user_location_id]).to_s
      @postings = Posting.where(location_id: session[:user_location_id], open_posting: true)
    end

  end

  # GET /postings/1
  # GET /postings/1.json
  def show
  end

  # GET /postings/new
  def new
    @posting = Posting.new
  end

  # GET /postings/1/edit
  def edit
  end

  # POST /postings
  # POST /postings.json
  def create
    @posting = Posting.new(posting_params)

    @posting.poster_id = session[:user_id]
    @posting.location_id = session[:user_location_id]
    @posting.open_posting = true
    @posting.is_request = true

    respond_to do |format|
      if @posting.save
        format.html { redirect_to @posting, notice: 'Posting was successfully created.' }
        format.json { render :show, status: :created, location: @posting }
      else
        format.html { render :new }
        format.json { render json: @posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /postings/1
  # PATCH/PUT /postings/1.json
  def update
    respond_to do |format|
      if @posting.update(posting_params)
        format.html { redirect_to @posting, notice: 'Posting was successfully updated.' }
        format.json { render :show, status: :ok, location: @posting }
      else
        format.html { render :edit }
        format.json { render json: @posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postings/1
  # DELETE /postings/1.json
  def destroy
    @posting.destroy
    respond_to do |format|
      format.html { redirect_to postings_url, notice: 'Posting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posting
      @posting = Posting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def posting_params
      params.require(:posting).permit(:responder_id, :skill_id, :header, :body, :open_posting, :is_request, :duration)
    end
end
