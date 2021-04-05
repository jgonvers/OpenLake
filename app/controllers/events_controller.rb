class EventsController < ApplicationController
  before_action :authenticate_user!
  # before_filter :authenticate_user!
  def index
    # @events = []
    # date = Time.now
    # Event.all.each { |e| @events << e if e.start_time >= date }
    # @events = @events.sort_by { |e| current_user.distance_to(e).round(0) }
    @events = Event.all
    if params[:dropdown] == 'date'
      @events = Event.all.order(:start_time)
    else
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
  end

  def new
    @event = Event.new
    @categories = Category.all.distinct
  end

  def create
    @event = Event.new(event_params)
    @event.creator_id = current_user.id
    if @event.save
      redirect_to events_path
    else
      @categories = Category.all.distinct
      render :new
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
