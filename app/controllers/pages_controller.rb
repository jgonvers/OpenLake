class PagesController < ApplicationController
  
  layout "empty"
  
  def home
    render layout: 'empty'
  end

end
