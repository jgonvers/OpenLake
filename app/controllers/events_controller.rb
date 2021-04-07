class EventsController < ApplicationController
  before_action :authenticate_user!
  # before_filter :authenticate_user!
  def index
    @events = Event.geocoded.select { |event| event.start_time >= Time.now }
    return if params[:search].nil?

    if params[:search][:sort].nil? || params[:search][:sort].nil? == 'distance'
      @events = @events.sort_by { |e| current_user.distance_to(e).round(0) }
    else
      @events = @events.sort_by(&:start_time)
    end

    unless params[:search][:category].nil?
      @events = select_category(@events,
                                params[:search][:category].keys.map(&:to_i))
    end

    @events = @events.select { |e| current_user.teammates_in_event?(e) } unless params[:search][:teammate].nil?
  end

  def show
    @event = Event.find(params[:id])
    @markers = [{
      lat: @event.latitude,
      lng: @event.longitude
    }]
    @teammates_in_event = current_user.nil? ? nil : current_user.teammates_in_event(@event)
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, success: "event not found"
  end

  def new
    @event = Event.new
    @categories = Category.all.distinct
  end

  def create
    @event = Event.new(event_params)
    @event.creator_id = current_user.id
    if @event.save
      redirect_to event_path(@event), success: "Your event #{@event.title} was successfully created!"
    else
      @categories = Category.all.distinct
      render :new, danger: "Event could not be created"
    end
  end

  def edit
  end

  def update
  end

  private

  def select_category(events, categories)
    events.select { |e| categories.include? e.category_id }
  end

  def event_params
    params.require(:event).permit(:category_id, :title, :content, :address, :participants_maximum, :start_time,
                                  :end_time)
  end
end
