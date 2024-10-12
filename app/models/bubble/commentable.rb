module Bubble::Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, dependent: :delete_all
  end

  def comment!(body)
    comments.create! body:
  end
end
