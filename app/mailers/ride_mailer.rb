class RideMailer < ApplicationMailer

  def ride_match_mailer
    subject = "Your Ride  #{params[:ride].ride_type} has been Matched"
    mail_user(params[:ride], params[:ride].user, params[:match], subject)
  end

  def ride_withdraw_mailer
    subject = "#{params[:match].first_name} has withdrawn interest in your Ride #{params[:ride].ride_type}" 
    mail_user(params[:ride], params[:ride].user, params[:match], subject)
  end

  private

  def mail_user(ride, ride_owner, ride_match, subject)
    @ride = ride
    @ride_match = ride_match
    @ride_owner = ride_owner
    mail(
      to: @ride_owner.email,
      subject: subject
    )
  end
end
