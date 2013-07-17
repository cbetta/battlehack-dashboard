class DashboardController < ApplicationController
  skip_before_filter :authenticate

  def index
    @timer = Timer.first
  end
end
