class NotificationsController < ApplicationController

  skip_before_filter :authenticate, only: [:latest]

  def index
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new
    @notification.visible = true
    @notification.text = params[:notification][:text]
    if @notification.save!
      redirect_to :notifications
    else
      render :new
    end
  end

  def update
    case params["command"]
    when "show"
      show_notification
    when "hide"
      hide_notification
    end

    redirect_to :notifications
  end

  def latest
    render json: Notification.order("created_at DESC").first, only: [:text, :id, :visible]
  end

  private

  def show_notification
    Notification.latest.update_attributes!(visible: true)
  end

  def hide_notification
    Notification.latest.update_attributes!(visible: false)
  end


end
