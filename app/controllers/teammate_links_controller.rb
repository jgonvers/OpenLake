class TeammateLinksController < ApplicationController
  after_action :clean_up

  def pending
    teammate = User.find(params[:id])
    # check actual state
    outgoing = TeammateLink.where(user: current_user, teammate: teammate)[0]
    if outgoing.nil?
      TeammateLink.new(user: current_user, teammate: teammate).save
    else
      outgoing.status = "pending"
      outgoing.save
    end
  end

  def destroy
    teammate = User.find(params[:id])
    TeammateLink.where(user: current_user, teammate: teammate)[0]&.destroy
  end

  def blocked
    teammate = User.find(params[:id])
    outgoing = TeammateLink.where(user: current_user, teammate: teammate)[0]
    if outgoing.nil?
      TeammateLink.new(user: current_user, teammate: teammate, status: "blocked").save
    else
      outgoing.status = "blocking"
      outgoing.save
    end
  end

  def accepted
    teammate = User.find(params[:id])
    outgoing = TeammateLink.where(user: current_user, teammate: teammate)[0]
    if outgoing.nil?
      TeammateLink.new(user: current_user, teammate: teammate, status: "accepted").save
    else
      outgoing.status = "accepted"
      outgoing.save
    end
  end

  private

  def clean_up
    link1 = TeammateLink.where(user: current_user, teammate: User.find(params[:id]))[0]
    link2 = TeammateLink.where(user: User.find(params[:id]), teammate: current_user)[0]
    if !link1.nil? && !link2.nil?
      if link1.status == "blocked" && link2.status != "blocked"
        link2.destroy
      elsif link2.status == "blocked" && link1.status != "blocked"
        link1.destroy
      elsif link1.status == "accepted" && link2.status != "accepted"
        change_to_accepted(link2)
      elsif link2.status == "accepted" && link1.status != "accepted"
        change_to_accepted(link1)
      elsif link1.status == "pending" && link2.status == "pending"
        accept(link1, link2)
      end
    elsif !link1.nil? && link1.status == "accepted"
      link1.destroy
    elsif !link2.nil? && link2.status == "accepted"
      link2.destroy
    end
  end

  def accept(link1, link2)
    change_to_accepted(link1)
    change_to_accepted(link2)
  end

  def change_to_accepted(link)
    link.status = "accepted"
    link.save
  end
end
