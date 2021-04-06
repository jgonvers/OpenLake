class ApplicationController < ActionController::Base  
  
  add_flash_types :danger, :success, :info, :warning 

  def after_sign_in_path_for(resource)
    events_path
  end
end
