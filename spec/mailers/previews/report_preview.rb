# Preview all emails at http://localhost:3000/rails/mailers/report
class ReportPreview < ActionMailer::Preview
  def daily_report
    ReportMailer.daily_report Date.new(2021,05,30)
  end
end
