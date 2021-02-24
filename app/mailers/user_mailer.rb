class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  def send_notification(user, booking)
    @user = user
    @booking = booking
    @room = Room.find_by(id: booking.room_id)
    mail(to: user.email, subject: 'notification booking room')
  end

  def notification_remainder(user, booking)
    @user = user
    @booking = booking
    @room = Room.find_by(id: booking.room_id)
    mail(to: user.email, subject: 'notification_remainder booking room')
  end

  def check_in_notification(user, booking)
    @user = user
    @booking = booking
    @room = Room.find_by(id: booking.room_id)
    mail(to: user.email, subject: 'check in booking room')
  end
end
