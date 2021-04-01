class AttendancesController < ApplicationController

  def create
    if Event.where(user: current_user, event_id: params[:event_id]).count.zero?
      @attendance = Attendance.new
      @attendance.user = current_user
      @attendance.event_id = params[:event_id]
      @attendance.save
    end
    redirect_to event_path(params[:event_id])
  end
end
