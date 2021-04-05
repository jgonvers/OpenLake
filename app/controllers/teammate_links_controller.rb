class TeammateLinksController < ApplicationController
  def create
    teammate = User.find(params[:id])
    
    return if teammate_link_exist?(current_user, teammate)
    # do nothing if teammate_link already_exist
    # maybe cause problem if simultaneous enough?
    if teammate_link_exist?(teammate, current_user)
      # check if teammate link exist dans l'autre sense
      status = teammate_link_status(teammate, current_user)
      if status == "pending"
        #teammate_link status existant et pending == acceptation de teammate
        if accept_teammate(current_user,teammate)
          #successful save
          return
        else
          #problem saving
          return
        end
      elsif status == "blocked"
        # link blocked from other side
        return
      else
        # link accepted from otherside and link not existing on this side
        # should not be possible, should log it
        if accept_teammate(current_user,teammate)
          #successful save
          return
        else
          #problem saving
          return
        end
      end
    else
      #create teammate_link avec status pending
      t_link = TeammateLink(
        user: current_user,
        teammate: teammate,
      ).save
      if t_link
        return
      else
        return
      end
    end
  end

  def update
  end

  def destroy
  end

  private

  def teammate_link_exist?(user, teammate)
    !TeammateLink.where(user:user,teammate:teammate).count).zero?
  end

  def teammate_link_status(user,teammate)
    TeammateLink.where(user:user,teammate:teammate)[0].status
  end

  def accept_teammate(user, teammate)
    # teammate -> user already exist
    t1 = TeammateLink.where(user: teammate, teammate: user)[0]
    t2 = TeammateLink.new(user: user, teammate: teammate)
    t1.status = "accepted"
    t2.status = "accepted"
    t1.save && t2.save
  end
end
