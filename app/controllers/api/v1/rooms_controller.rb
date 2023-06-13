class Api::V1::RoomsController < ApplicationController
  before_action :authenticate_request
  before_action :set_room, only: %i[ show update destroy ]

  def index
    rooms = Room.all
    return response_success(200, "Rooms are empty") unless rooms.present?
    response_success(200, "Rooms are found", ActiveModelSerializers::SerializableResource.new(rooms, each_serializer: RoomSerializer))
  end

  def show
    return response_failure(404, "Room not found") unless @room.present?
    response_success(200, "Room found", ActiveModelSerializers::SerializableResource.new(@room, serializer: RoomSerializer))
  end

  def create
    room = Room.new(room_params)

    if room.save
      response_success(201, "Room created successfully.", ActiveModelSerializers::SerializableResource.new(room, serializer: RoomSerializer))
    else
      response_failure(500, "Unable to save room", room.errors)
    end
  end

  def update
    if @room.update(room_params)
      response_success(200, "Room updated successfully.", ActiveModelSerializers::SerializableResource.new(@room, serializer: RoomSerializer))
    else
      response_failure(500, "Unable to update room", @room.errors)
    end
  end

  def destroy
    if @room.destroy
      response_success(200, "Room deleted successfully.")
    else
      response_failure(500, "Unable to delete room", @room.errors)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name)
    end
end
