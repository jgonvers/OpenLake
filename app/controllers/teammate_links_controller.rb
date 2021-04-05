class TeammateLinksController < ApplicationController
  def pending
    teammate = User.find(params[:id])
    # check actual state
    outgoing = TeammateLink.where(user: current_user, teammate: teammate)[0]
    incoming = TeammateLink.where(user: teammate, teammate: current_user)[0]
    if incoming.nil? && outgoing.nil?
      #create link if none exist
      TeammateLink.new(user: current_user, teammate: teammate).save
    elsif incoming.nil?
      #change status to pending if outgoing exist and not incoming
      outgoing.status = "pending"
      outgoing.save
    elsif outgoing.nil?
      if incoming.status != "blocked"
        # accept teammate if incoming not blocked ( accepted || pending) and incoming not exist
        # do nothing if blocked
        accept_teammate(current_user, teammate)
      end
    else
      if incoming.status == "blocked"
        # clean up if incoming is blocked

    end
    byebug
  end

  def create_old
    teammate = User.find(params[:id])

    return if teammate_link_exist?(current_user, teammate)

    # do nothing if teammate_link already_exist
    # maybe cause problem if simultaneous enough?
    if teammate_link_exist?(teammate, current_user)
      # check if teammate link exist dans l'autre sense
      status = teammate_link_status(teammate, current_user)
      if status == "pending"
        # teammate_link status existant et pending == acceptation de teammate
        if accept_teammate(current_user, teammate)
          # successful save
          return
        else
          # problem saving
          return
        end
      elsif status == "blocked"
        # link blocked from other side
        return
      elsif accept_teammate(current_user, teammate)
        # link accepted from otherside and link not existing on this side
        # should not be possible, should log it
        return
      # successful save
      else
        # problem saving
        return
      end
    else
      # create teammate_link avec status pending
      t_link = TeammateLink(
        user: current_user,
        teammate: teammate
      ).save
      if t_link
        return
      else
        return
      end
    end
  end

  def test
  end

  private

  def clean_up(user1, user2)
    link1 = TeammateLink.where(user: user1, teammate: user2)[0]
    link2 = TeammateLink.where(user: user2, teammate: user1)[0]
    if !link1.nil? && !link2.nil?
      if link1.status == "blocked" && link2.status != "blocked"
        link2.destroy
      elsif link2.status == "blocked" && link1.status != "blocked"
        link1.destroy
      elsif link1.status == "accepted" && link2.status != "accepted"
        link2.status = "accepted"
        link2.save
      elsif link2.status == "accepted" && link1.status != "accepted"
        link1.status = "accepted"
        link1.save
      elsif link1.status == "pending" && link2.status == "pending"
        link1.status = "accepted"
        link1.save
        link2.status = "accepted"
        link2.save
      end
    elsif !link1.nil? && link1.status == "accepted"
      link1.destroy
    elsif !link2.nil? && link2.status == "accepted"
      link2.destroy
    end
  end 

  def create_pending(teammate)
  end

  def teammate_link_exist?(user, teammate)
    !TeammateLink.where(user: user, teammate: teammate).count.zero?
  end

  def teammate_link_status(user, teammate)
    TeammateLink.where(user: user, teammate: teammate)[0].status
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
