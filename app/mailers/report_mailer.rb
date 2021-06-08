class ReportMailer < ApplicationMailer
  def daily_report date
    @sales = Sale.within_date date
    @total_revenue = Sale.total_revenue date
    mail to: Settings.receive_report_email,
         subject: t("report.daily_report", date: date)
  end
end
