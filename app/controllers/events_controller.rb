class EventsController < ApplicationController
  # before_action :authenticate_user!
  # before_filter :authenticate_user!
  def index
    @events = []
    Event.all.each { |e| @events << e }
    @events = @events.sort
    render layout: 'layout_index'
  end

  def show
    @event = Event.find(params[:id])
    @markers = [{
      lat: @event.latitude,
      lng: @event.longitude
    }]
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(
      category_id: event_params[:category], title: event_params[:title],
      content: event_params[:content], address: event_params[:address],
      participants_maximum: event_params[:participants_maximum],
      start_time: event_params[:start_time],
      end_time: event_params[:end_time]
    )
    @event.creator_id = current_user.id
    if @event.save!
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def event_params
    params.require(:event).permit(:category, :title, :content, :address, :participants_maximum, :start_time, :end_time)
  end
end
