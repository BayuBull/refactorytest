class Booking < ApplicationRecord
#Set FK dari user dan room
  belongs_to :room
  belongs_to :user

  def self.check_available_room(booking)
    binding.pry
    room = Room.find_by(id: booking.room_id)
    last_booking = Booking.where(room_id: booking.room_id).order(check_out_time: :desc).last

    return booking.save, booking if last_booking.nil?

    return false, "ruang sudah dipesan" if last_booking.check_out_time > booking.boking_time

    return false, "ruangan tidak cukup" if booking.total_person.to_i > room.room_capacity.to_i

    return booking.save, booking
  end

  def self.send_mail_notif(booking)
    user = User.find_by(id: booking.user_id)

    UserMailer.send_notification(user, booking).deliver_now
    remainder = booking.boking_time.strftime("%e").to_i - Date.today.strftime("%e").to_i rescue nil

    UserMailer.delay(run_at: remainder.days.from_now).notification_remainder(user, booking) rescue nil

  end
end
