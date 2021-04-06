class EventsController < ApplicationController
  before_action :authenticate_user!
  # before_filter :authenticate_user!
  def index
    @events = Event.all
    if params[:dropdown] == 'date'
      @events = Event.all.order(:start_time)
    elsif params[:dropdown] == 'distance' || params[:dropdown] == nil
      @events = @events.sort_by { |e| current_user.distance_to(e).round(0) }
    elsif params[:dropdown] == 'teammate'
      @events = @events.select do |e|
        current_user.teammates_in_event?(e)
      end
      @events = @events.sort_by { |e| current_user.distance_to(e).round(0) }
    else
      @events = @events.select do |e|
        e.category.name == params[:dropdown]
      end
      @events = @events.sort_by { |e| current_user.distance_to(e).round(0) }
    end
    render layout: 'layout_index'
  end

  def show
    @event = Event.find(params[:id])
    @markers = [{
      lat: @event.latitude,
      lng: @event.longitude
    }]
    @teammates_in_event = current_user.nil? ? nil : current_user.teammates_in_event(@event)
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

  def event_params
    params.require(:event).permit(:category_id, :title, :content, :address, :participants_maximum, :start_time,
                                  :end_time)
  end
end
