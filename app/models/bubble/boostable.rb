module Bubble::Boostable
  extend ActiveSupport::Concern

  def boost!
    transaction do
      increment! :boost_count
      track_event :boosted, boost_count:
    end
  end
end
