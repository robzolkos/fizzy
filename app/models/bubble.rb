class Bubble < ApplicationRecord
  include Assignable, Boostable, Colored, Commentable, Eventable, Poppable, Searchable, Taggable, Threaded

  belongs_to :bucket
  belongs_to :creator, class_name: "User", default: -> { Current.user }

  has_one_attached :image, dependent: :purge_later

  searchable_by :title, using: :bubbles_search_index

  before_save :set_default_title

  scope :reverse_chronologically, -> { order(created_at: :desc, id: :desc) }
  scope :ordered_by_activity, -> { left_joins(:comments).group(:id).order(Arel.sql("COUNT(comments.id) + boost_count DESC")) }

  scope :mentioning, ->(query) do
    bubbles = search(query).select(:id).to_sql
    comments = Comment.search(query).select(:bubble_id).to_sql

    left_joins(:comments)
      .where("bubbles.id in (#{bubbles}) or comments.bubble_id in (#{comments})")
      .distinct
  end

  private
    def set_default_title
      self.title = title.presence || "Untitled"
    end
end
