class AnimalBiosController < ApplicationController
  before_action :set_animal_bio, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:new, :create]
  before_action :require_admin, only: [:edit, :update, :destroy]

  # GET /animal_bios
  # GET /animal_bios.json
  def index
    @animal_bios = AnimalBio.all
  end

  # GET /animal_bios/1
  # GET /animal_bios/1.json
  def show
  end

  # GET /animal_bios/new
  def new
    @animal_bio = AnimalBio.new
  end

  # GET /animal_bios/1/edit
  def edit
  end

  # POST /animal_bios
  # POST /animal_bios.json
  def create
    @animal_bio = AnimalBio.new(animal_bio_params)

    respond_to do |format|
      if @animal_bio.save
        format.html { redirect_to @animal_bio, notice: 'Animal bio was successfully created.' }
        format.json { render :show, status: :created, location: @animal_bio }
      else
        format.html { render :new }
        format.json { render json: @animal_bio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animal_bios/1
  # PATCH/PUT /animal_bios/1.json
  def update
    respond_to do |format|
      if @animal_bio.update(animal_bio_params)
        format.html { redirect_to @animal_bio, notice: 'Animal bio was successfully updated.' }
        format.json { render :show, status: :ok, location: @animal_bio }
      else
        format.html { render :edit }
        format.json { render json: @animal_bio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animal_bios/1
  # DELETE /animal_bios/1.json
  def destroy
    @animal_bio.destroy
    respond_to do |format|
      format.html { redirect_to animal_bios_url, notice: 'Animal bio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal_bio
      @animal_bio = AnimalBio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_bio_params
      params.require(:animal_bio).permit(:name, :age, :breed, :likes, :fears, :details, :images)
    end
end
