module Event::Assignments
  extend ActiveSupport::Concern

  included do
    store_accessor :particulars, :assignee_ids
  end

  def assignee_names
    assignees.map &:name
  end

  private
    def assignees
      @assignees ||= creator.account.users.find assignee_ids
    end
end
