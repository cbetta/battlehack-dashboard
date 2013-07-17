class Notification < ActiveRecord::Base

  def self.latest
    order("created_at DESC").first
  end
end
