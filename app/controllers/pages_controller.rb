class PagesController < ApplicationController
  layout "empty"

  def home
    redirect_to events_path unless current_user.nil?
  end
end
