class Room < ApplicationRecord
   has_many :bookings
   mount_uploader :photo, RoomUploader
end
