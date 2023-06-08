require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url, as: :json
    assert_response :success
  end

  test "should create event" do
    assert_difference("Event.count") do
      post events_url, params: { event: { description: @event.description, end_time: @event.end_time, event_name: @event.event_name, person_name: @event.person_name, resource: @event.resource, start_time: @event.start_time } }, as: :json
    end

    assert_response :created
  end

  test "should show event" do
    get event_url(@event), as: :json
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { description: @event.description, end_time: @event.end_time, event_name: @event.event_name, person_name: @event.person_name, resource: @event.resource, start_time: @event.start_time } }, as: :json
    assert_response :success
  end

  test "should destroy event" do
    assert_difference("Event.count", -1) do
      delete event_url(@event), as: :json
    end

    assert_response :no_content
  end
end
