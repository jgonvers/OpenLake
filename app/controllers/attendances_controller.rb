class AttendancesController < ApplicationController
  def create
    # check if already attending
    attendance = Attendance.where(user: current_user, event_id: params[:event_id])
    msg = ""
    event = Event.find(params[:event_id])
    if attendance.count.zero?
      @attendance = Attendance.new(
        user: current_user,
        event_id: params[:event_id]
      ).save
      msg = "you are now attending #{event.title}"
    elsif Event.find(params[:event_id]).creator != current_user
      attendance.first.delete
      msg = "you are no longer attending #{event.title}"
    end
    redirect_to event_path(params[:event_id]), success: msg
  end
end
