require 'fileutils'
require 'rmagick'
require 'aws-sdk'
require 'pathname'
require 'uri'
include Magick

class BiosController < ApplicationController
  before_action :set_bio, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:new, :create, :edit, :update]
  before_action :require_admin, only: [:destroy]

  # GET /bios
  # GET /bios.json
  def index
    @bios = Bio.all
  end

  # GET /bios/1
  # GET /bios/1.json
  def show
    @images = Photo.where(bio_id: @bio.id)
    respond_to do |format|
        format.html # show.html.erb
        format.js # show.js.erb
        format.json { render json: @bio }
    end
  end

  # GET /bios/new
  def new
    @bio = Bio.new
  end

  # GET /bios/1/edit
  def edit
    @images  = Photo.where(bio_id: @bio.id)
  end

  # POST /bios
  # POST /bios.json
  def create
    @bio = Bio.new(bio_params)
    respond_to do |format|
      if @bio.save
        save_images_to_s3 params['bio']['images']
        @bio.save

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
        save_images_to_s3 params['bio']['images']
        @bio.save
        params['images'].each do |img|
          if img.should_remove
            Photo.find_by(id: img.id).delete
          end
        end
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
    s3 = Aws::S3::Resource.new(region: ENV['S3_REGION'])
    bucket = s3.bucket(ENV['S3_BUCKET_NAME'])
    Photo.where( bio_id: @bio.id).each do |image|
      if (image.path)
        imagename = URI(image.path).path.chomp('/').split('/').last
        obj = bucket.object(imagename)
        obj.delete
      end
      if (image.thumbnail)
        thumbname = URI(image.thumbnail).path.chomp('/').split('/').last
        objthumb = bucket.object(thumbname)
        objthumb.delete
      end
      image.destroy

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
      params.require(:bio).permit(:name, :age, :breed, :likes, :fears, :details, :images)
    end

    def save_images_to_s3(image_list)
      if image_list

        s3 = Aws::S3::Resource.new(region: ENV['S3_REGION'])
        bucket = s3.bucket(ENV['S3_BUCKET_NAME'])
        image_list.each do |uf|
          image = Photo.new
          s3image = bucket.object("#{@bio.id}_#{Pathname.new(uf.path).basename.to_s}")
          s3thumb = bucket.object("thumb_#{@bio.id}_#{Pathname.new(uf.path).basename.to_s}")
          img = Image.read(uf.path)[0]
          img.auto_orient!
          img.resize_to_fit!(500, 500)
          s3image.put(body: img.to_blob, acl: 'public-read')
          image.path = s3image.public_url
          image.thumbnail = s3thumb.public_url
          target = Image.new(100, 100) do
            self.background_color = 'white'
          end
          target.format = img.format
          img.resize_to_fit!(100, 100)
          s3thumb.put(body: target.composite(img, CenterGravity, CopyCompositeOp).to_blob, acl: 'public-read')
          if @bio.main_image == nil
            @bio.main_image = s3thumb.public_url
          end
          @bio.photos << image
          image.save
          uf.tempfile.unlink
        end
      end
    end
end
