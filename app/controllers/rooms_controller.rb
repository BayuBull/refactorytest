class RoomsController < ApplicationController
  before_action :authorize_request
#  get /rooms
  def index
    rooms = Room.all
    render json: rooms, status: :ok
  end
#  get /rooms/users/:username
  def show
     if current_user.role == 'admin'
    room = Room.find_by(id: params[:id])
    render json: room, status: :ok
    else
      render json: { errors: "Forbidden" },
              status: :forbidden
    end
  end
# post /rooms
  def create
    if current_user.role == 'admin'
      room = Room.new(room_params)
      room.save
      render json: room, status: :created
    else
      render json: { errors: "Forbidden" },
              status: :forbidden
    end
  end

  def room_params
    params.permit(
      :photo, :room_name, :room_capacity
    )
  end
end
