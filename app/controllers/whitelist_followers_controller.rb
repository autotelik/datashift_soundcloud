class WhitelistFollowersController < ApplicationController
  before_action :set_whitelist_follower, only: [:show, :edit, :update, :destroy]

  # Delegate instantiation of the form object to an abstract factory
  def form
    @form ||= Steps::FormObjectFactory.form_object_for(step, enrollment)
  end

  # GET /whitelist_followers
  # GET /whitelist_followers.json
  def index
    @whitelist_followers = WhitelistFollower.all
  end

  # GET /whitelist_followers/1
  # GET /whitelist_followers/1.json
  def show
  end

  # GET /whitelist_followers/new
  def new
    @whitelist_follower = WhitelistFollower.new
  end

  # GET /whitelist_followers/1/edit
  def edit
  end

  # POST /whitelist_followers
  # POST /whitelist_followers.json
  def create
    @whitelist_follower = WhitelistFollower.new(whitelist_follower_params)

    respond_to do |format|
      if @whitelist_follower.save
        format.html { redirect_to @whitelist_follower, notice: 'Whitelist follower was successfully created.' }
        format.json { render :show, status: :created, location: @whitelist_follower }
      else
        format.html { render :new }
        format.json { render json: @whitelist_follower.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /whitelist_followers/1
  # PATCH/PUT /whitelist_followers/1.json
  def update
    respond_to do |format|
      if @whitelist_follower.update(whitelist_follower_params)
        format.html { redirect_to @whitelist_follower, notice: 'Whitelist follower was successfully updated.' }
        format.json { render :show, status: :ok, location: @whitelist_follower }
      else
        format.html { render :edit }
        format.json { render json: @whitelist_follower.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /whitelist_followers/1
  # DELETE /whitelist_followers/1.json
  def destroy
    @whitelist_follower.destroy
    respond_to do |format|
      format.html { redirect_to whitelist_followers_url, notice: 'Whitelist follower was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_whitelist_follower
      @whitelist_follower = WhitelistFollower.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def whitelist_follower_params
      params.fetch(:whitelist_follower, {})
    end
end
