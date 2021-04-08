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
      @past_events = []
      @user.events.each { |event| @upcoming_events << event if event.start_time > Time.now }
      @user.events.each { |event| @past_events << event if event.end_time <= Time.now }
      @pending_teammates_count = pending_teammates.count
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
    if params[:query].present?
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    else
      @users = User.all
    end
    @users = @users.reject { |user| user == current_user }
  end

  def teammates
    @user = User.find(params[:id]) # user ID
    @users = @user.accepted_teammates # array of teammates of @user
    render 'users/index'
  end

  def events_created
    @events = User.find(params[:id]).created_events
    @events = @events.sort_by(&:start_time).reverse
    render "events/index_clean"
  end

  def events_attended
    @events_participated = User.find(params[:id]).events
    @events_created = User.find(params[:id]).created_events
    @events = @events_created.nil? ? @events_participated : @events_participated + @events_created
    @events = @events.select { |event| event.end_time <= Time.now }
    @events = @events.sort_by(&:end_time).reverse
    render "events/index_clean"
  end

  def pending_teammates
    @pending_tmates = TeammateLink.where(teammate: current_user, status: "pending")
    @pending_tmates = @pending_tmates.map(&:user)
  end

  def test
  end
end
