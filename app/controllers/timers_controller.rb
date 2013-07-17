class TimersController < ApplicationController
  skip_before_filter :authenticate, only: [:status]

  def show
  end

  def update
    case params["command"]
    when "start"
      start_timer
    when "stop"
      stop_timer
    when "reset"
      reset_timer
    end
    timer.save!

    redirect_to :timer
  end

  def status
    stop_timer if Time.now > timer.ends_at && timer.status == "started"
    render json: timer, only: [:status, :started_at, :ends_at]
  end

  private

  def timer
    @timer ||= Timer.instance
  end

  def stop_timer
    timer.status = "ended"
    timer.started_at = nil
  end

  def start_timer
    timer.status = "started"
    timer.started_at = Time.now
  end

  def reset_timer
    timer.status = "cleared"
    timer.started_at = nil
  end

end