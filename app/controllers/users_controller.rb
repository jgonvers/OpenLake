class UsersController < ApplicationController
  def homepage
    redirect_to user_path(current_user)
  end

  def show
    if params[:id].nil?
      authenticate_user!
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    rating = 0
    reviews_count = 0
    if current_user == @user
      @upcoming_events = []
      @user.events.each { |event| @upcoming_events << event if event.start_time > Time.now }
    else
      @past_events = []
      @user.created_events.each { |event| @past_events << event if event.end_time < Time.now }
      @past_events.each do |event|
        event.reviews.each do |reviews|
          reviews_count += 1
          rating += reviews.rating
        end
      end
      if reviews_count.zero?
        @rating = -1
      else
        @rating = rating.fdiv(reviews_count).round(0).to_i
      end
    end
  end

  def index
    @users = User.all
  end

  def teammates
    @user = User.find(params[:id]) # user ID
    @users = @user.teammates # array of teammates of @user
    render 'users/index'
  end

  def events_created
    @events = User.find(params[:id]).created_events
    render "events/index"
  end

  def events_attended
    @events = User.find(params[:id]).events
    render "events/index"
  end
end
