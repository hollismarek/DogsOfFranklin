class HomeController < ApplicationController
  def index
    if Photo.count > 0
      @image_path = "/" + Photo.first.path
    else
      @image_path = 'peteyatrest.png'
    end
  end

  def about
  end

  def gallery
  end

  def contact
  end

  def links
  end

end
