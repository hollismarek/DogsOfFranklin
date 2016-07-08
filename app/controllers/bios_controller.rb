require 'fileutils'
require 'rmagick'
include Magick

class BiosController < ApplicationController
  before_action :set_bio, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:new, :create, :show, :edit, :update]
  before_action :require_admin, only: [:destroy]

  # GET /bios
  # GET /bios.json
  def index
    @bios = Bio.all
  end

  # GET /bios/1
  # GET /bios/1.json
  def show
  end

  # GET /bios/new
  def new
    @bio = Bio.new
  end

  # GET /bios/1/edit
  def edit
  end

  # POST /bios
  # POST /bios.json
  def create
    @bio = Bio.new(bio_params)
    #logger.debug Time.now.to_s + " >> " + params["bio"]["images"].inspect

    respond_to do |format|
      if @bio.save
        #http://localhost:3000/images/public/1/greathall.png
        params['bio']['images'].each do |uf|
          image = Photo.new
          folder = "public/images/#{@bio.id.to_s}/thumbs"
          FileUtils.mkdir_p(folder)

          image.path = "images/#{@bio.id.to_s}/#{uf.original_filename}"
          thumbnail_path = "images/#{@bio.id.to_s}/thumbs/#{uf.original_filename}"

          if @bio.main_image == nil
            @bio.main_image = thumbnail_path
          end
          #FileUtils.cp(uf.path, "public/" + image.path)
          img = Image.read(uf.path)[0]
          img.auto_orient!
          img.resize_to_fit!(500, 500)
          img.write('public/' + image.path)
          target = Image.new(100, 100) do
            self.background_color = 'white'
          end
          img.resize_to_fit!(100, 100)
          target.composite(img, CenterGravity, CopyCompositeOp).write("public/" + thumbnail_path)
          @bio.photos << image
          image.save
          @bio.save
          uf.tempfile.unlink
        end
        format.html { redirect_to bios_path, notice: 'Bio was successfully created.' }
        format.json { render :show, status: :created, location: @bio }
      else
        format.html { render :new }
        format.json { render json: @bio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bios/1
  # PATCH/PUT /bios/1.json
  def update
    respond_to do |format|
      if @bio.update(bio_params)
        format.html { redirect_to @bio, notice: 'Bio was successfully updated.' }
        format.json { render :show, status: :ok, location: @bio }
      else
        format.html { render :edit }
        format.json { render json: @bio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bios/1
  # DELETE /bios/1.json
  def destroy
    Photo.where( bio_id: @bio.id).each do |image|
      image.destroy
    end
    directory = "public/images/#{@bio.id}"
    if File.directory?(directory)
      FileUtils.remove_dir directory
    end
    @bio.destroy
    respond_to do |format|
      format.html { redirect_to bios_url, notice: 'Bio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bio
      @bio = Bio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bio_params
      params.require(:bio).permit(:name, :age, :breed, :likes, :fears, :details)
    end
end
