class UsersController < ApplicationController
  def homepage
  end

  def show
    @user = User.find(params[:id])
    rating = 0
    reviews_count = 0
    if current_user.nil? || current_user != @user
      @user.created_events.each do |event|
        event.reviews.each do |reviews|
          reviews_count += 1
          rating += reviews.rating
        end
      end
      if reviews_count = 0
        @rating = 4
      else
        @rating = rating.fdiv(reviews_count).round(0).to_i
      end
    else
      @upcoming_events = []
      @user.events.each { |event| @upcoming_events << event if event.start_time > Time.now }
    end
  end

  def teammates
  end

  def events_created
  end

  def events_attended
  end
end
