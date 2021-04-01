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
  end

  def edit
  end

  def update
  end
end
