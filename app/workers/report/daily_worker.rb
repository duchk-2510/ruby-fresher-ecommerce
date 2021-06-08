class Report::DailyWorker
  include Sidekiq::Worker

  def perform
    date = Time.zone.today
    logger.info "Start updating Sales in #{date}"
    Sale.statisticize_sale date
    logger.info "Finished updating Sales in #{date}"
    ReportMailer.daily_report(date).deliver_now
    logger.info "Sent a report email"
  end
end
