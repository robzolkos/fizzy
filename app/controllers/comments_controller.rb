class CommentsController < ApplicationController
  include BubbleScoped, BucketScoped

  def create
    @bubble.comment! params.dig(:comment, :body).presence
    redirect_to bucket_bubble_url(@bucket, @bubble)
  end
end
