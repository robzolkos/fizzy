class Event < ApplicationRecord
  THREADABLE_ACTIONS = %w[ assigned boosted created ]

  include Assignments

  belongs_to :creator, class_name: "User"
  belongs_to :bubble

  scope :threadable, -> { where action: THREADABLE_ACTIONS }
end
