class NotificationsController < ApplicationController

  skip_before_filter :authenticate, only: [:latest]

  def index
  end

  def new
  end

  def create
  end

  def update
  end

  def latest
    render json: Notification.order("created_at DESC").first, only: [:text, :id, :visible]
  end
end
