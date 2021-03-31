class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @markers = [{
        lat: @event.latitude,
        lng: @event.longitude
    }]
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
end
