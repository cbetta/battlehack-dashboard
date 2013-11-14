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
    when "pause"
      pause_timer
    when "resume"
      resume_timer
    end
    timer.save!

    redirect_to :timer
  end

  def status
    stop_timer if timer_ended?
    render json: timer, only: [:status, :started_at, :ends_at], methods: [:remaining]
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
    if params[:time]
      timer.started_at = Time.now - (24.hours - seconds_for(params[:time]).seconds)
    else
      timer.started_at = Time.now
    end
  end

  def reset_timer
    timer.status = "cleared"
    timer.started_at = nil
  end

  def pause_timer
    timer.status = "paused"
  end

  def timer_ended?
    timer.status == "started" && Time.now > timer.ends_at
  end

  def seconds_for time
    parts = time.split(":")
    (parts[-3].to_i*3600) + (parts[-2].to_i*60) + (parts[-1].to_i)
  end

end