module Bubble::Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, dependent: :delete_all

    after_create -> { track_event :created }
  end

  private
    def track_event(action, creator: Current.user, **particulars)
      events.create! action:, creator:, particulars:
    end
end
