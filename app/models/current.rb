class Current < ActiveSupport::CurrentAttributes
  attribute :session, :user

  delegate :account, to: :user, allow_nil: true

  def session=(session)
    super
    self.user = session.user
  end
end
