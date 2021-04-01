class PagesController < ApplicationController
  layout "empty"

  def home
    redirect_to logged_user_path unless current_user.nil?
  end
end
