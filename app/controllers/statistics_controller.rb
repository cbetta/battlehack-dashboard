class StatisticsController < ApplicationController

  skip_before_filter :authenticate, only: [:latest]

  def show
  end

  def edit
    @statistic = Statistic.instance
  end

  def update
    @statistic = Statistic.instance
    @statistic.text = params[:statistic][:text]
    if @statistic.save!
      redirect_to :statistic
    else
      render :edit
    end
  end

  def latest
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    html = markdown.render(Statistic.instance.text)
    render json: {html: html}.to_json, only: [:text, :id]
  end

  private

end
