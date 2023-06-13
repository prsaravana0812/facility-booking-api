class Api::V1::EventsController < ApplicationController
  before_action :authenticate_request
  before_action :set_event, only: %i[ show update destroy ]
  before_action :validate_event_overlap, only: %i[ create update ]

  def index
    calendar_date = params[:calendar_date].present? ? params[:calendar_date] : Time.now.strftime("%d/%m/%Y")
    events = Event.current_events(calendar_date, current_user.id)
    return response_success(200, "Events are empty") unless events.present?
    response_success(200, "Events are found", ActiveModelSerializers::SerializableResource.new(events, each_serializer: EventSerializer))
  end

  def show
    return response_failure(404, "Event not found") unless @event.present?
    response_success(200, "Event found", ActiveModelSerializers::SerializableResource.new(@event, serializer: EventSerializer))
  end

  def create
    event = Event.new(event_params)

    if event.save
      response_success(201, "Event created successfully.", ActiveModelSerializers::SerializableResource.new(event, serializer: EventSerializer))
    else
      response_failure(500, "Unable to save event", event.errors)
    end
  end

  def update
    if @event.update(event_params)
      response_success(200, "Event updated successfully.", ActiveModelSerializers::SerializableResource.new(@event, serializer: EventSerializer))
    else
      response_failure(500, "Unable to update event", @event.errors)
    end
  end

  def destroy
    if @event.destroy
      response_success(200, "Event deleted successfully.")
    else
      response_failure(500, "Unable to delete event", @event.errors)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:event_name, :start_time, :end_time, :description, :resource, :person_name).merge(user: current_user)
    end

    def validate_event_overlap
      range = Range.new params[:start_time], params[:end_time]
      overlaps = Event.exclude_self(params[:id]).with_resource(params[:resource]).in_range(range)
      overlap_error unless overlaps.empty?
    end

    def overlap_error
      response_failure(409, "There is already an event scheduled between these times")
    end
end
