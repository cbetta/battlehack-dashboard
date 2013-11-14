class Timer < ActiveRecord::Base

  before_save :set_ends_at

  def self.instance
    Timer.first || Timer.create(status: "cleared")
  end

  def remaining
    Time.at(24.hours - (updated_at - started_at)).utc
  end

  private

  def set_ends_at
    self.ends_at = started_at + 24.hours unless started_at.nil?
  end
end
