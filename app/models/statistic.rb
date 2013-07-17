class Statistic < ActiveRecord::Base

  def self.instance
    Statistic.first || Statistic.create!
  end
end
