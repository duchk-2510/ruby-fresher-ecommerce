class StatisticsController < ApplicationController
  DATE_FORMAT = {day: "%d/%m", month: "%m-%Y", year: "%Y"}.freeze
  before_action{authorize! :read, :statistics}

  def show
    @page = 1
  end

  def chart_data
    @page = (params[:page] || "1").to_i
    @sales = Sale.send("group_by_#{params[:type]}", :date)
                 .sum(:revenue).to_a
    adjust_page
    @sales = @sales.paginate page: @page, per_page: Settings.sales_data_per_page
    format = DATE_FORMAT[params[:type].to_sym]
    render json: @sales.map{|k, v| [k.strftime(format), v / 1_000_000]}
  end

  def chart_change_page
    @page = (params[:page] || "1").to_i
    respond_to do |format|
      format.js
    end
  end

  private

  def adjust_page
    max_page = (@sales.size - 1) / Settings.sales_data_per_page + 1
    @page = [@page, max_page].min
    @page = [@page, 1].max
  end
end
