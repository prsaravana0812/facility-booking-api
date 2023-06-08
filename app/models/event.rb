class Event < ApplicationRecord
  scope :current_events, -> (calendarDate) { where(start_time: calendarDate.to_date.beginning_of_day..calendarDate.to_date.end_of_day) }
  scope :exclude_self, -> (id) { where.not(id: id) }
  scope :with_resource, -> (resource) { where(resource: resource) }
  scope :in_range, -> (range) { where("(start_time BETWEEN ? AND ?) OR (end_time BETWEEN ? AND ?)", range.first, range.last, range.first, range.last) }
end
