class BookingsController < ApplicationController
  before_action :authorize_request
# get /booking
  def index
    if current_user.role == 'admin'
    bookings = Booking.all
    render json: bookings, status: :ok
    else
    render json: { errors: "Forbidden" },
            status: :forbiddene
    end
  end
#get /booking-me
  def all_by_current
    result = current_user.bookings
    render json: result, status: :ok
  end
#get /booking/:id
  def show
    bookings = Booking.find_by(id: params[:id])
    render json: bookings, status: :ok
  end
#post /booking/create-booking
  def create
    booking                = Booking.new
    booking.user_id        = current_user.id
    booking.room_id        = params[:rooms_id]
    booking.total_person   = params[:total_person]
    booking.boking_time    = params[:booking_date]
    booking.check_in_time  = params[:check_in_time]
    booking.check_out_time = params[:check_out_time]
    booking.noted          = params[:noted]
    err, message           = Booking.check_available_room(booking)

    unless err
      render json: { errors: message }, status: 422
      return
    end

    Booking.send_mail_notif(booking)
    render json: { status: "OK", message: "successfully booking room", data: message}, status: 201
  end
#post /booking/check-in
  def check_in
    current_booking = Booking.find_by(id: params[:id])
    current_booking.check_in_time = Time.now
    current_booking.save
    user = User.find_by(id: current_booking.user_id)

    UserMailer.check_in_notification(user,  current_booking).deliver_now
    render json: { status: "OK", message: "successfully check in room", data: nil}, status: 201
    
  end
end
