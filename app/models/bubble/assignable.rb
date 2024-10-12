module Bubble::Assignable
  extend ActiveSupport::Concern

  included do
    has_many :assignments, dependent: :delete_all

    has_many :assignees, through: :assignments
    has_many :assigners, through: :assignments

    scope :assigned_to, ->(user) { joins(:assignments).where(assignments: { assignee: user }) }
    scope :assigned_by, ->(user) { joins(:assignments).where(assignments: { assigner: user }) }
  end

  def assign(users, assigner: Current.user)
    transaction do
      Assignment.insert_all Array(users).collect { |user| { assignee_id: user.id, assigner_id: assigner.id, bubble_id: id } }
      track_event :assigned, assignee_ids: Array(users).map(&:id)
    end
  end
end
