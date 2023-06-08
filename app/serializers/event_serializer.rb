class EventSerializer < ActiveModel::Serializer
  attributes :id, :event_name, :start_time, :end_time, :description, :resource, :person_name, :text

  def text
    object.person_name + " - " + object.event_name
  end
end
